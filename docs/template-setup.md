---
layout: default
title: Template Setup Guide
nav_order: 2
---

# Template Setup Guide

This comprehensive guide walks you through customizing the Kotlin Multimodule Template for your specific project needs.

## 🚀 Quick Setup (Automated)

### Using the Customization Scripts

The template includes automated scripts for quick setup:

```bash
# For Linux/Mac users
./customize.sh

# For Windows PowerShell users
./customize.ps1
```

These scripts will prompt you for:

- **Project name** (e.g., "my-awesome-service")
- **Organization domain** (e.g., "com.mycompany")
- **GitHub organization** (e.g., "my-org")

The scripts automatically:

- ✅ Update package names throughout the project
- ✅ Rename the main application class
- ✅ Update build configuration
- ✅ Configure GitHub publishing settings
- ✅ Clean up old package structures

## 🛠️ Manual Setup (Step-by-Step)

### Step 1: Project Configuration

**Update `settings.gradle`:**

```groovy
rootProject.name = "your-project-name"
```

**Update `build.gradle` group:**

```groovy
group = "com.yourcompany.yourproject"
```

**Update GitHub publishing URL:**

```groovy
url = uri("https://maven.pkg.github.com/your-org/your-repo")
```

### Step 2: Package Structure

**Current structure:**

```
io.programmernewbie.template
```

**Change to your structure:**

```
com.yourcompany.yourproject
```

**Required changes:**

1. Rename directories under `src/main/kotlin/`
2. Update package declarations in all `.kt` files
3. Update import statements
4. Update `scanBasePackages` in main application

### Step 3: Application Class

**Rename the file:**

- From: `KotlinMultimoduleTemplateApplication.kt`
- To: `YourProjectNameApplication.kt`

**Update the class content:**

```kotlin
@SpringBootApplication(
  scanBasePackages = [
    "com.yourcompany.yourproject.service",
    "com.yourcompany.yourproject"
  ]
)
class YourProjectNameApplication

fun main(args: Array<String>) {
  runApplication<YourProjectNameApplication>(*args)
}
```

### Step 4: Replace Example Code

**Service Layer (`service-module`):**

```kotlin
@Service
@Transactional
class YourBusinessService {
    
    fun performBusinessLogic(input: String): String {
        // Your actual business logic here
        return "Processed: $input"
    }
}
```

**Controller Layer (`springboot-application`):**

```kotlin
@RestController
@RequestMapping("/api/your-resource")
class YourResourceController(
    private val businessService: YourBusinessService
) {
    
    @GetMapping
    fun getResource(): ResponseEntity<String> {
        val result = businessService.performBusinessLogic("example")
        return ResponseEntity.ok(result)
    }
}
```

## 🔧 Advanced Customization

### Adding New Modules

1. **Create module directory:**

```bash
mkdir your-new-module
```

2. **Create `build.gradle`:**

```groovy
apply from: "$rootDir/scripts/gradle/spring_library.gradle"

dependencies {
    // Module-specific dependencies
    implementation project(':service-module')
}
```

3. **Module auto-discovery:**
   The module will be automatically included via `settings.gradle`

### Database Configuration

**For PostgreSQL:**

```groovy
// In build.gradle
runtimeOnly "org.postgresql:postgresql"
```

```yaml
# In application.yml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/yourdb
    username: ${DB_USER:user}
    password: ${DB_PASSWORD:password}
  jpa:
    database-platform: org.hibernate.dialect.PostgreSQLDialect
```

**For MySQL:**

```groovy
runtimeOnly "com.mysql:mysql-connector-j"
```

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/yourdb
    username: ${DB_USER:user}
    password: ${DB_PASSWORD:password}
  jpa:
    database-platform: org.hibernate.dialect.MySQLDialect
```

### Adding Security

**Add dependency:**

```groovy
implementation "org.springframework.boot:spring-boot-starter-security"
```

**Create security configuration:**

```kotlin
@Configuration
@EnableWebSecurity
class SecurityConfig {

    @Bean
    fun filterChain(http: HttpSecurity): SecurityFilterChain {
        return http
            .authorizeHttpRequests { auth ->
                auth.requestMatchers("/api/public/**").permitAll()
                    .anyRequest().authenticated()
            }
            .httpBasic(withDefaults())
            .build()
    }
}
```

## 📦 Dependency Management

### Adding New Dependencies

1. **Add version to `gradle.properties`:**

```properties
new_library_version=1.2.3
```

2. **Add to module `build.gradle`:**

```groovy
implementation "com.example:new-library:$new_library_version"
```

3. **Update dependency locks:**

```bash
./gradlew resolveAndLockAll --write-locks
```

### Version Updates

```bash
# Check for updates
./gradlew dependencyUpdates

# Update specific versions in gradle.properties
# Then regenerate locks
./gradlew resolveAndLockAll --write-locks
```

## 🧪 Testing Setup

### Test Structure

```
src/test/kotlin/
├── unit/
│   ├── small/      # Fast unit tests (< 100ms)
│   └── medium/     # Tests with mocks (< 1s)
├── integration/    # Full Spring context tests
└── performance/    # JMH benchmarks
```

### Running Tests by Group

```bash
# Small unit tests only
./gradlew test --tests "**/unit/small/**"

# Integration tests
./gradlew test --tests "**/integration/**"

# Performance tests
./gradlew jmh
```

## 🔍 Verification Checklist

After customization, verify everything works:

- [ ] **Build successful**: `./gradlew build`
- [ ] **Application starts**: `./gradlew :springboot-application:bootRun`
- [ ] **Tests pass**: `./gradlew test`
- [ ] **Endpoints work**: `curl http://localhost:8080/api/your-endpoint`
- [ ] **Dependency locks updated**: Check for `.lockfile` files
- [ ] **Package names consistent**: No references to old packages

## 🚨 Common Issues

### Build Failures

**Issue**: Package names don't match directory structure
**Solution**: Ensure package declarations match folder hierarchy

**Issue**: Missing dependency versions
**Solution**: Add all versions to `gradle.properties`

### Runtime Issues

**Issue**: Spring can't find beans
**Solution**: Verify `scanBasePackages` includes your service packages

**Issue**: Database connection fails
**Solution**: Check `application.yml` database configuration

### Dependency Lock Issues

**Issue**: "Not part of dependency lock state" errors
**Solution**: Run `./gradlew resolveAndLockAll --write-locks`

## 📋 Template Checklist

### Before Publishing Your Project

- [ ] Update README.md with your project details
- [ ] Replace example code with real implementation
- [ ] Configure database for your needs
- [ ] Set up CI/CD workflows
- [ ] Add proper error handling
- [ ] Configure logging
- [ ] Add API documentation
- [ ] Set up monitoring/metrics

### Repository Settings

- [ ] Enable branch protection
- [ ] Configure required status checks
- [ ] Set up GitHub Packages (if needed)
- [ ] Configure secrets for CI/CD
- [ ] Enable security scanning

This guide ensures you can quickly adapt the template while maintaining all the production-ready features and best
practices.
