# Template Setup Guide

This guide helps you customize the Kotlin Multimodule Template for your specific project.

## 🎯 Quick Customization Checklist

### 1. Project Identity

- [ ] Update `rootProject.name` in `settings.gradle`
- [ ] Update `group` in root `build.gradle`
- [ ] Update GitHub repository URL in `build.gradle` publishing section

### 2. Package Structure

- [ ] Replace `io.programmernewbie.template` with your package name in:
  - All `.kt` files
  - `scanBasePackages` in main application class
- [ ] Update directory structure to match new package name

### 3. Application Naming

- [ ] Rename `KotlinMultimoduleTemplateApplication.kt` to match your project
- [ ] Update class name inside the file
- [ ] Update main application class reference

### 4. Example Code Replacement

- [ ] Replace `ExampleService` with your business logic
- [ ] Replace `ExampleController` with your REST endpoints
- [ ] Update or remove example endpoints

## 🛠️ Step-by-Step Customization

### Step 1: Basic Project Settings

1. **Update settings.gradle**:

```gradle
rootProject.name = "your-project-name"
```

2. **Update root build.gradle**:

```gradle
group = "com.yourcompany.yourproject"
```

3. **Update publishing URL** (if using GitHub Packages):

```gradle
url = uri("https://maven.pkg.github.com/your-org/your-repo")
```

### Step 2: Package Structure Changes

**Option A: Manual Update**

1. Rename directories under `src/main/kotlin/` to match your package
2. Update package declarations in all `.kt` files
3. Update import statements if needed

**Option B: Use IDE Refactoring**

1. In IntelliJ IDEA: Right-click package → Refactor → Rename
2. Choose "Rename package" and update all occurrences

### Step 3: Application Class Updates

1. **Rename the main application file**:
  - From: `KotlinMultimoduleTemplateApplication.kt`
  - To: `YourProjectNameApplication.kt`

2. **Update the class content**:

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

1. **Service Layer**: Replace `ExampleService` with your business logic:

```kotlin
@Service
@Transactional
class YourBusinessService {
    // Your actual business methods here
}
```

2. **Controller Layer**: Replace `ExampleController` with your REST endpoints:

```kotlin
@RestController
@RequestMapping("/api/your-resource")
class YourResourceController(
    private val yourBusinessService: YourBusinessService
) {
    // Your actual REST endpoints here
}
```

## 🔧 Advanced Customization

### Adding New Modules

1. Create new directory: `your-new-module/`
2. Add `build.gradle` file
3. Create `src/main/kotlin/` structure
4. Module will be auto-discovered by settings.gradle

### Database Configuration

1. **For PostgreSQL**:

```gradle
// In springboot-application/build.gradle
runtimeOnly "org.postgresql:postgresql"
```

2. **For MySQL**:

```gradle
// In springboot-application/build.gradle
runtimeOnly "com.mysql:mysql-connector-j"
```

3. **Update application.yml**:

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/yourdb
    username: ${DB_USER:user}
    password: ${DB_PASSWORD:password}
```

### Adding Security

1. **Add Spring Security dependency**:

```gradle
implementation "org.springframework.boot:spring-boot-starter-security"
```

2. **Create security configuration**:

```kotlin
@Configuration
@EnableWebSecurity
class SecurityConfig {
    // Your security configuration
}
```

## 📋 Verification Steps

After customization, verify everything works:

1. **Build successfully**:

```bash
./gradlew build
```

2. **Run application**:

```bash
./gradlew :springboot-application:bootRun
```

3. **Test endpoints**:

```bash
curl http://localhost:8080/api/your-resource/endpoint
```

4. **Run tests**:

```bash
./gradlew test
```

## 🚨 Common Issues

### Build Failures

- Check package names match directory structure
- Verify all imports are updated
- Ensure gradle.properties versions are correct

### Runtime Issues

- Verify scanBasePackages includes your service packages
- Check Spring Boot auto-configuration
- Review application logs for configuration errors

### IDE Issues

- Refresh Gradle project after changes
- Invalidate caches and restart if needed
- Check Project Structure settings

## 📞 Need Help?

- Check existing issues in the template repository
- Create a new issue with your specific problem
- Include error messages and configuration details
