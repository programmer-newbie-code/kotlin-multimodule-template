---
layout: default
title: Dependency Management
nav_order: 4
---

# Dependency Management

This template uses Gradle dependency locking to ensure reproducible builds across different environments and team
members.

## 📦 Dependency Locking Overview

Dependency locking prevents the "works on my machine" problem by:

- **Locking exact versions** of all transitive dependencies
- **Ensuring reproducible builds** across environments
- **Preventing unexpected version changes** during builds
- **Providing security** through consistent dependency versions

## 🔧 How It Works

### Lock Files

The template generates lock files for each module:

```
├── gradle.lockfile                    # Root project locks
├── service-module/
│   └── gradle.lockfile               # Service module locks
└── springboot-application/
    └── gradle.lockfile               # Application module locks
```

### Version Management

All dependency versions are centralized in `gradle.properties`:

```properties
# Dependency versions
testng_version=7.7.0
mockk_version=1.13.10
h2_version=2.2.224
kotlin_coroutines_version=1.8.0

# Gradle plugin versions
kotlin_version=1.9.25
spring_boot_version=3.5.3
```

## 🛠️ Common Commands

### Adding New Dependencies

1. **Add to gradle.properties** (if new version):

```properties
new_library_version=1.2.3
```

2. **Add to module build.gradle**:

```groovy
dependencies {
    implementation "com.example:new-library:$new_library_version"
}
```

3. **Update locks**:

```bash
./gradlew resolveAndLockAll --write-locks
```

### Updating Dependencies

```bash
# Check for available updates
./gradlew dependencyUpdates

# Update specific version in gradle.properties
# Then regenerate locks
./gradlew resolveAndLockAll --write-locks
```

### Troubleshooting Lock Issues

```bash
# If you get "not part of dependency lock state" errors:
./gradlew resolveAndLockAll --write-locks

# To see dependency tree
./gradlew dependencies

# To see specific configuration dependencies
./gradlew :service-module:dependencies --configuration runtimeClasspath
```

## 🔍 Dependency Analysis

### Security Scanning

```bash
# Run OWASP dependency check
./gradlew dependencyCheckAnalyze

# View report at: build/reports/dependency-check-report.html
```

### License Compliance

```bash
# Generate license report
./gradlew generateLicenseReport

# View report at: build/reports/dependency-license/
```

### Version Analysis

```bash
# Check for outdated dependencies
./gradlew dependencyUpdates

# View report at: build/dependencyUpdates/report.html
```

## 📋 Best Practices

### 1. Version Management

- ✅ **Use variables** in `gradle.properties` for all versions
- ✅ **Group related versions** (e.g., all Spring Boot versions)
- ✅ **Document version choices** for major dependencies

### 2. Lock File Management

- ✅ **Commit lock files** to version control
- ✅ **Update locks** after any dependency changes
- ✅ **Review lock changes** in pull requests

### 3. Security

- ✅ **Run security scans** regularly
- ✅ **Update dependencies** promptly for security fixes
- ✅ **Monitor vulnerability reports**

## 🚨 Common Issues

### Lock State Errors

**Problem**: `Could not resolve all files... not part of dependency lock state`

**Solution**:

```bash
./gradlew resolveAndLockAll --write-locks
./gradlew clean build
```

### Version Conflicts

**Problem**: Different modules requiring different versions

**Solution**:

1. Use `gradle.properties` to enforce consistent versions
2. Add explicit dependency management in root `build.gradle`
3. Use `force` in resolution strategy if needed

### Plugin Version Issues

**Problem**: Plugin versions causing conflicts

**Solution**:

1. Update plugin versions in `gradle.properties`
2. Ensure plugin compatibility
3. Check plugin documentation for version requirements

## 📊 Dependency Categories

### Core Dependencies

```groovy
// Kotlin essentials
implementation "org.jetbrains.kotlin:kotlin-reflect"
implementation "org.jetbrains.kotlin:kotlin-stdlib"

// Coroutines
implementation "org.jetbrains.kotlinx:kotlinx-coroutines-core:$kotlin_coroutines_version"
```

### Spring Dependencies

```groovy
// Spring Boot starters
implementation "org.springframework.boot:spring-boot-starter-web"
implementation "org.springframework.boot:spring-boot-starter-data-jpa"

// Spring validation
implementation "org.springframework.boot:spring-boot-starter-validation"
```

### Testing Dependencies

```groovy
// Test frameworks
testImplementation "org.testng:testng:$testng_version"
testImplementation "io.mockk:mockk:$mockk_version"
testImplementation "org.springframework.boot:spring-boot-starter-test"
```

## 🎯 Template-Specific Configuration

### Automatic Module Discovery

The template uses automatic module discovery in `settings.gradle`:

```groovy
// Auto-include all folders with build.gradle
file(".").listFiles()
  .findAll { it.isDirectory() && new File(it, "build.gradle").exists() }
  .each { include it.name }
```

### Publishing Configuration

Ready for GitHub Packages publishing:

```groovy
repositories {
  maven {
    name = "GitHubPackages"
    url = uri("https://maven.pkg.github.com/your-org/your-repo")
    credentials {
      username = System.getenv("GITHUB_ACTOR")
      password = System.getenv("GITHUB_TOKEN")
    }
  }
}
```

This ensures your template projects can easily publish to GitHub Packages with proper authentication.
