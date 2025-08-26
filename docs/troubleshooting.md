---
layout: default
title: Troubleshooting
nav_order: 10
---

# Troubleshooting Guide

Common issues and solutions when using the Kotlin Multimodule Template.

## 🔧 Build Issues

### Dependency Lock State Errors

**Error**: `Could not resolve all files... not part of dependency lock state`

**Cause**: Dependency locks are out of sync with current dependencies

**Solution**:

```bash
# Regenerate all lock files
./gradlew resolveAndLockAll --write-locks

# Clean and rebuild
./gradlew clean build
```

### Kotlin Compilation Errors

**Error**: `Unresolved reference` or `Type mismatch`

**Common Causes & Solutions**:

1. **Package name mismatch**:
  - Check package declarations match directory structure
  - Verify import statements are correct

2. **Missing allopen plugin**:
  - Ensure `kotlin.gradle` includes allopen plugin
  - Check Spring annotations are in allopen configuration

3. **Version conflicts**:
  - Use consistent versions in `gradle.properties`
  - Check for transitive dependency conflicts

### Spring Boot Issues

**Error**: `No qualifying bean of type` or `BeanCreationException`

**Solutions**:

1. **Component scanning**:

```kotlin
@SpringBootApplication(
  scanBasePackages = [
    "your.package.service",
    "your.package.controller"
  ]
)
```

2. **Missing annotations**:

```kotlin
@Service  // Ensure service classes are annotated
@RestController  // Ensure controllers are annotated
```

3. **Circular dependencies**:

```kotlin
// Use @Lazy annotation to break cycles
@Service
class ServiceA(@Lazy private val serviceB: ServiceB)
```

## 🏃 Runtime Issues

### Application Won't Start

**Error**: `Port 8080 was already in use`

**Solution**:

```bash
# Change port
export SERVER_PORT=8081
./gradlew :springboot-application:bootRun

# Or in application.yml
server:
  port: 8081
```

**Error**: `Failed to configure a DataSource`

**Solution**:

```yaml
# For testing with H2
spring:
  datasource:
    url: jdbc:h2:mem:testdb
    driver-class-name: org.h2.Driver
  h2:
    console:
      enabled: true
```

### Transaction Issues

**Error**: `@Transactional` not working

**Cause**: Kotlin classes are final, Spring can't create proxies

**Solution**: Template already includes allopen plugin, but verify:

```groovy
// In kotlin.gradle
allOpen {
  annotations("org.springframework.transaction.annotation.Transactional")
}
```

## 🧪 Testing Issues

### Test Discovery Problems

**Error**: Tests not found or not running

**Solutions**:

1. **Check test location**:

```
src/test/kotlin/  ← Correct location
src/test/java/   ← Wrong for Kotlin
```

2. **TestNG configuration**:

```kotlin
// Ensure test classes use TestNG
import org.testng.annotations.Test

@Test
class YourTest {
  // Test methods
}
```

3. **Test naming**:

```bash
# Run specific test patterns
./gradlew test --tests "*Test"
./gradlew test --tests "*Integration*"
```

### MockK Issues

**Error**: `MockK` mocks not working

**Solution**:

```kotlin
@BeforeEach
fun setup() {
    MockKAnnotations.init(this)  // Initialize mocks
}

// Or use programmatic approach
val mockService = mockk<YourService>()
```

### Spring Test Context Issues

**Error**: `Failed to load ApplicationContext`

**Solutions**:

1. **Test configuration**:

```kotlin
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@TestPropertySource(properties = ["spring.jpa.hibernate.ddl-auto=create-drop"])
class IntegrationTest
```

2. **Test profiles**:

```kotlin
@ActiveProfiles("test")
class ServiceTest
```

## 📦 GitHub Template Issues

### Customization Script Failures

**Error**: Script can't find files or permissions denied

**Solutions**:

1. **Linux/Mac permissions**:

```bash
chmod +x customize.sh
./customize.sh
```

2. **Windows PowerShell execution policy**:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
./customize.ps1
```

3. **Manual customization**: If scripts fail, follow the manual steps in [Template Setup Guide](./template-setup.md)

### GitHub Actions Issues

**Error**: Workflow failures in forked repositories

**Solutions**:

1. **Update repository references**:

```yaml
# In .github/workflows/*.yml
- name: Publish to GitHub Packages
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

2. **Enable GitHub Packages**:
  - Go to repository Settings → Actions → General
  - Enable "Read and write permissions"

## 🔍 Debugging Tips

### Enable Debug Logging

```yaml
# In application.yml
logging:
  level:
    your.package: DEBUG
    org.springframework: DEBUG
    org.hibernate.SQL: DEBUG
```

### Gradle Debug Information

```bash
# Verbose Gradle output
./gradlew build --info --stacktrace

# Debug dependency resolution
./gradlew dependencies --configuration runtimeClasspath

# Check for duplicate classes
./gradlew buildEnvironment
```

### Spring Boot Debugging

```bash
# Enable debug mode
./gradlew :springboot-application:bootRun --args='--debug'

# Enable actuator endpoints
# Add to application.yml:
management:
  endpoints:
    web:
      exposure:
        include: health,info,beans,env
```

## 📊 Performance Issues

### Slow Build Times

**Solutions**:

1. **Enable Gradle daemon and parallel builds** (already configured):

```properties
# In gradle.properties
org.gradle.parallel=true
org.gradle.caching=true
org.gradle.configureondemand=true
```

2. **Increase memory**:

```properties
org.gradle.jvmargs=-Xmx4g -XX:MaxMetaspaceSize=512m
```

### Slow Test Execution

**Solutions**:

1. **Run test groups separately**:

```bash
./gradlew test --tests "**/unit/small/**"  # Fast tests first
```

2. **Parallel test execution**:

```groovy
test {
  maxParallelForks = Runtime.runtime.availableProcessors()
}
```

## 🆘 Getting Help

### Template-Specific Issues

- 📖 [GitHub Issues](https://github.com/programmer-newbie-code/kotlin-multimodule-template/issues)
- 💬 [GitHub Discussions](https://github.com/programmer-newbie-code/kotlin-multimodule-template/discussions)

### Framework Documentation

- [Spring Boot Reference](https://docs.spring.io/spring-boot/docs/current/reference/html/)
- [Kotlin Documentation](https://kotlinlang.org/docs/home.html)
- [Gradle User Manual](https://docs.gradle.org/current/userguide/userguide.html)

### Community Support

- [Spring Community](https://spring.io/community)
- [Kotlin Slack](https://kotlinlang.slack.com/)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/kotlin+spring-boot)
