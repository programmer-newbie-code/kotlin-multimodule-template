# Kotlin Multimodule Template

A minimal, production-ready Kotlin multimodule template for Spring Boot applications. This template provides a clean
foundation for building scalable microservices with proper module separation and **Spring-Kotlin integration**.

## 🏗️ Architecture

This template follows a simple two-module architecture:

- **service-module**: Contains business logic and services
- **springboot-application**: Contains REST controllers and application configuration

## 🔧 Spring-Kotlin Integration

This template includes proper **Kotlin `allopen` plugin configuration** to solve the common issue where Spring cannot
create beans from Kotlin classes (since Kotlin classes are `final` by default).

### What's Configured:

The `allopen` plugin automatically makes Kotlin classes **open** (non-final) when annotated with:

- `@Component`, `@Service`, `@Repository`
- `@Controller`, `@RestController`
- `@Configuration`, `@SpringBootApplication`
- `@Transactional`

### Why This Matters:

- ✅ **Spring dependency injection works correctly**
- ✅ **Spring AOP and transaction proxies work**
- ✅ **No need to manually add `open` keywords**
- ✅ **Your `@Service` and `@Controller` classes work out of the box**

## 🚀 Quick Start

### 1. Use This Template

Click "Use this template" button on GitHub to create a new repository from this template.

### 2. Customize for Your Project

Run the customization script or manually update:

```bash
# Linux/Mac
./customize.sh

# Windows PowerShell  
./customize.ps1
```

**Package Names**: Replace `io.programmernewbie.template` with your desired package:

- Update package declarations in all `.kt` files
- Update `scanBasePackages` in `KotlinMultimoduleTemplateApplication.kt`
- Update `group` in `build.gradle`

**Project Name**:

- Update `rootProject.name` in `settings.gradle`
- Update artifact names in `build.gradle` files

### 3. Build and Run

```bash
# Build the project
./gradlew build

# Run the application
./gradlew :springboot-application:bootRun

# Run tests
./gradlew test
```

### 4. Verify Setup

Once running, test the example endpoints:

```bash
# Health check
curl http://localhost:8080/api/example/health

# Welcome message
curl http://localhost:8080/api/example/welcome?name=YourName

# Async welcome message
curl http://localhost:8080/api/example/welcome-async?name=YourName
```

## 📁 Project Structure

```
kotlin-multimodule-template/
├── service-module/                 # Business logic layer
│   └── src/main/kotlin/
│       └── io/programmernewbie/template/service/
│           └── ExampleService.kt   # Example service implementation
├── springboot-application/         # Application layer
│   └── src/main/kotlin/
│       └── io/programmernewbie/template/
│           ├── KotlinMultimoduleTemplateApplication.kt  # Main application
│           └── controller/
│               └── ExampleController.kt                 # Example REST controller
├── scripts/                        # Gradle build scripts
│   ├── kotlin.gradle              # Kotlin + allopen plugin config
│   ├── spring_library.gradle      # Spring library configuration
│   └── spring_boot.gradle         # Spring Boot application config
├── docs/                          # Documentation
├── build.gradle                   # Root build configuration
├── settings.gradle                # Module configuration
└── gradle.properties             # Dependency versions
```

## 🛠️ Development

### Adding New Modules

1. Create a new directory for your module
2. Add a `build.gradle` file
3. The module will be automatically included (see `settings.gradle`)

### Adding Dependencies

Update `gradle.properties` with version numbers and reference them in module `build.gradle` files.

### Spring Configuration Tips

**Services**: Just use `@Service` - no need for `open` keyword:

```kotlin
@Service
@Transactional
class YourService {
    // Spring will create proxies correctly
}
```

**Controllers**: Just use `@RestController` - works automatically:

```kotlin
@RestController
@RequestMapping("/api/your-resource")
class YourController(
    private val yourService: YourService  // Dependency injection works
) {
    // Your endpoints here
}
```

### Code Quality

The template includes:

- JaCoCo for code coverage
- OWASP dependency check
- License reporting
- Kotlin code style enforcement

Run quality checks:

```bash
./gradlew check
./gradlew jacocoTestReport
./gradlew dependencyCheckAnalyze

# Update dependency locks after adding new dependencies
./gradlew resolveAndLockAll --write-locks
```

## 🔧 Configuration

### Environment Variables

- `SPRING_PROFILES_ACTIVE`: Set active Spring profiles
- `SERVER_PORT`: Override default port (8080)

### Application Properties

Configure in `springboot-application/src/main/resources/application.yml`

## 📦 Deployment

### JAR Build

```bash
./gradlew :springboot-application:bootJar
```

### Docker

```dockerfile
FROM openjdk:17-jre-slim
COPY springboot-application/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

## 🤝 Contributing

1. Fork this repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Getting Help

- Check the [HELP.md](HELP.md) for troubleshooting
- Review [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines
- Open an issue for bugs or feature requests

---

**Template Version**: 1.0.0  
**Kotlin Version**: 1.9.25  
**Spring Boot Version**: 3.5.3
