---
layout: default
title: Spring-Kotlin Integration
nav_order: 6
---

# Spring-Kotlin Integration

This template includes proper configuration for seamless Spring Framework integration with Kotlin, solving common issues
developers face when using Kotlin with Spring.

## 🎯 The Kotlin-Spring Challenge

### The Problem

Kotlin classes are **final by default**, which creates issues with Spring Framework:

- Spring cannot create **CGLIB proxies** for dependency injection
- **AOP (Aspect-Oriented Programming)** doesn't work
- **@Transactional** annotations fail to create transaction proxies
- **@Configuration** classes can't be extended by Spring

### The Solution: AllOpen Plugin

This template uses the Kotlin `allopen` plugin to automatically make classes **open** (non-final) when annotated with
specific Spring annotations.

## 🔧 Configuration Details

### Plugin Setup

The `allopen` plugin is configured in `scripts/kotlin.gradle`:

```groovy
apply plugin: "org.jetbrains.kotlin.plugin.allopen"

allOpen {
  annotations(
    "org.springframework.stereotype.Component",
    "org.springframework.stereotype.Service", 
    "org.springframework.stereotype.Repository",
    "org.springframework.stereotype.Controller",
    "org.springframework.web.bind.annotation.RestController",
    "org.springframework.boot.autoconfigure.SpringBootApplication",
    "org.springframework.context.annotation.Configuration",
    "org.springframework.transaction.annotation.Transactional"
  )
}
```

### What This Means

When you annotate a Kotlin class with any of these annotations, the compiler automatically makes it `open`:

```kotlin
// This class is automatically made 'open' by the allopen plugin
@Service
@Transactional
class ExampleService {
    // Spring can create transaction proxies for this class
    fun someBusinessMethod() { }
}
```

## ✅ Working Examples

### Service Layer

```kotlin
@Service
@Transactional
class UserService(
    private val userRepository: UserRepository
) {
    // ✅ Transaction management works
    // ✅ Dependency injection works  
    // ✅ AOP proxies work
    
    fun createUser(userData: UserData): User {
        // This method is automatically wrapped in a transaction
        return userRepository.save(User(userData))
    }
    
    @Transactional(readOnly = true)
    fun findUser(id: UUID): User? {
        // Read-only transaction
        return userRepository.findById(id)
    }
}
```

### Controller Layer

```kotlin
@RestController
@RequestMapping("/api/users")
class UserController(
    private val userService: UserService  // ✅ DI works automatically
) {
    // ✅ Spring can create proxies for this controller
    // ✅ All Spring MVC features work
    
    @PostMapping
    fun createUser(@RequestBody userData: UserData): ResponseEntity<User> {
        val user = userService.createUser(userData)
        return ResponseEntity.ok(user)
    }
    
    @GetMapping("/{id}")
    fun getUser(@PathVariable id: UUID): ResponseEntity<User> {
        val user = userService.findUser(id)
        return ResponseEntity.of(Optional.ofNullable(user))
    }
}
```

### Configuration Classes

```kotlin
@Configuration
@EnableJpaAuditing
class DatabaseConfig {
    // ✅ Spring can extend this configuration class
    
    @Bean
    fun auditingHandler(): AuditingHandler {
        return AuditingHandler(PersistenceContext())
    }
}
```

## 🚨 What You DON'T Need to Do

### ❌ Manual `open` Keywords

```kotlin
// DON'T do this - the plugin handles it automatically
open class ExampleService { }
```

### ❌ Interface-Based Proxies Only

```kotlin
// You CAN do this, but it's not required
interface UserService {
    fun createUser(userData: UserData): User
}

@Service
class UserServiceImpl : UserService {
    override fun createUser(userData: UserData): User { }
}
```

### ❌ Workarounds with Companion Objects

```kotlin
// DON'T need complex workarounds
class ExampleService {
    companion object {
        // Complex static initialization
    }
}
```

## 🔍 Verification

### Check That It's Working

```kotlin
@SpringBootTest
class SpringKotlinIntegrationTest {
    
    @Autowired
    private lateinit var exampleService: ExampleService
    
    @Test
    fun verifyProxyCreation() {
        // This will pass if proxies are created correctly
        assertTrue(AopUtils.isAopProxy(exampleService))
    }
    
    @Test  
    fun verifyTransactionSupport() {
        // This will pass if @Transactional works
        assertTrue(TransactionSynchronizationManager.isActualTransactionActive())
    }
}
```

### Debug Information

```kotlin
// In your application, you can check if proxies are created:
@Component
class ProxyChecker(
    @Autowired private val services: List<Any>
) {
    
    @PostConstruct
    fun checkProxies() {
        services.forEach { service ->
            val isProxy = AopUtils.isAopProxy(service)
            logger.info("${service.javaClass.simpleName} is proxy: $isProxy")
        }
    }
}
```

## 🧪 Testing Spring-Kotlin Integration

### Unit Tests with MockK

```kotlin
class ExampleServiceTest {
    
    @MockK
    private lateinit var dependency: SomeDependency
    
    @InjectMockKs
    private lateinit var service: ExampleService
    
    @BeforeEach
    fun setup() {
        MockKAnnotations.init(this)
    }
    
    @Test
    fun testServiceMethod() {
        // Given
        every { dependency.someMethod() } returns "test"
        
        // When
        val result = service.getWelcomeMessage("test")
        
        // Then
        assertEquals("Hello, test! This is your Kotlin Multimodule Template.", result)
        verify { dependency.someMethod() }
    }
}
```

### Integration Tests

```kotlin
@SpringBootTest
@TestPropertySource(properties = ["spring.jpa.hibernate.ddl-auto=create-drop"])
class ServiceIntegrationTest {
    
    @Autowired
    private lateinit var userService: UserService
    
    @Test
    @Transactional
    fun testTransactionalBehavior() {
        // This test verifies that @Transactional works correctly
        val userData = UserData("test@example.com", "Test User")
        
        val user = userService.createUser(userData)
        
        assertNotNull(user.id)
        assertEquals("test@example.com", user.email)
    }
}
```

## 🎓 Advanced Features

### Custom Annotations

You can add your own annotations to the `allopen` configuration:

```groovy
allOpen {
  annotations(
    // Spring annotations...
    "com.yourcompany.CustomTransactional",
    "com.yourcompany.ProxyRequired"
  )
}
```

### Conditional Configuration

```kotlin
@Configuration
@ConditionalOnProperty(name = "app.feature.enabled", havingValue = "true")
class FeatureConfig {
    // This configuration is automatically made 'open'
    
    @Bean
    @ConditionalOnMissingBean
    fun featureService(): FeatureService {
        return FeatureServiceImpl()
    }
}
```

## 📊 Performance Considerations

### Proxy Creation Impact

- **CGLIB proxies**: Slight memory overhead, negligible performance impact
- **JDK proxies**: Minimal overhead, used when interfaces are available
- **No proxies**: For classes without Spring annotations, no overhead

### Best Practices

- ✅ Use `@Transactional` judiciously (not on every method)
- ✅ Consider `@Transactional(readOnly = true)` for read operations
- ✅ Group related operations in single transactional methods
- ✅ Use `@Service` for business logic, `@Component` for utilities

## 🔗 Related Documentation

- [Spring Framework Reference - Kotlin Support](https://docs.spring.io/spring-framework/docs/current/reference/html/languages.html#kotlin)
- [Kotlin AllOpen Plugin](https://kotlinlang.org/docs/all-open-plugin.html)
- [Spring Boot Kotlin Guide](https://spring.io/guides/tutorials/spring-boot-kotlin/)

This configuration ensures your Kotlin Spring applications work seamlessly without the common pitfalls of final classes
and proxy creation issues.
