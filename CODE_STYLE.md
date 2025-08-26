# Code Style Guide

This document outlines the code style conventions for this project and provides instructions for setting up your
development environment to adhere to these conventions.

## Style Overview

We follow a style based on Google's style guide with the following key aspects:

- **Indentation**: 2 spaces (no tabs)
- **Line length**: 120 characters maximum
- **File encoding**: UTF-8
- **Line endings**: LF (Unix-style)
- **No wildcard imports**: Each class should be imported explicitly
- **Final newline**: All files end with a newline

## Language-Specific Guidelines

### Kotlin Style

As this project is primarily written in Kotlin, we follow
the [Kotlin coding conventions](https://kotlinlang.org/docs/coding-conventions.html) with Google-style 2-space
indentation:

- **Naming conventions**:
  - Use camelCase for properties, variables, functions, and parameters
  - Use PascalCase for classes, interfaces, and type parameters
  - Use UPPER_SNAKE_CASE for constants

- **Class structure**:
  ```kotlin
  class Example(
    val property1: String,
    private val property2: Int
  ) {
    // Properties first
    val derivedProperty = property1.length
    
    // Methods grouped by functionality
    fun method1() {
      // 2-space indentation
    }
    
    // Inner classes last
    inner class InnerExample {
      // ...
    }
  }
  ```

- **Function declarations**:
  - Keep parameter lists on a single line for short functions
  - For functions with many parameters, break after the opening parenthesis and indent parameters by 2 spaces:
  ```kotlin
  fun longFunctionName(
    param1: String,
    param2: Int,
    param3: Boolean
  ): ReturnType {
    // Function body
  }
  ```

### Java Style

For Java code, we follow the [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html) with 2-space
indentation.

## Module-Specific Guidelines

### Bulk Cache Components

Our project consists of several modules (`bulk-core`, `bulk-caffeine`, `bulk-redis`, `bulk-spring`). Each module has its
own conventions:

#### Annotations

For annotations in `bulk-core`:

- Place documentation above annotations
- Use descriptive parameter names
- Include examples in KDoc comments

#### Cache Implementations

For cache implementations in `bulk-caffeine` and `bulk-redis`:

- Group related functionality into separate files
- Use descriptive method names that clearly indicate their purpose
- Document public APIs with KDoc comments

## File Organization

### Directory Structure

Maintain the following directory structure:
<!-- TODO: Replace with your own package structure -->

- `io.programmernewbie.template.annotation` - Annotation classes
- `io.programmernewbie.template.core` - Core interfaces and implementations
- `io.programmernewbie.template.service` - Service implementations

### Package Declarations

Package declarations should:

- Align with the directory structure
- Be the first non-comment line in the file
- Be followed by an empty line

### Import Statements

- Group imports by package, separated by empty lines
- Do not use wildcard imports
- Sort imports alphabetically within groups

## Build Files

### Gradle Build Files

Each module has its own `build.gradle` file. These files should:

- Use consistent dependency declarations
- Reference versions from `gradle.properties` using `${property_name}` syntax
- Group dependencies by type (implementation, testImplementation, etc.)

## Gradle Script Formatting

Our project uses several Gradle scripts in the `scripts/` directory (e.g., `kotlin.gradle`, `jacoco.gradle`,
`tasks.gradle`, `spring_boot.gradle`) that should follow the same formatting standards as our Kotlin and Java code:

### Gradle Script Guidelines

1. **Indentation**: Use 2 spaces for indentation in all Gradle files
2. **Block style**: Opening braces should be on the same line as the declaration
3. **String quotes**: Prefer double quotes for strings in Gradle files
4. **Plugin application**: Put each plugin application on its own line
5. **Dependencies**: Format multi-line dependencies with proper indentation

Example Gradle script format:

```groovy
apply plugin: "java"
apply plugin: "kotlin"

dependencies {
  implementation "org.springframework:spring-core:${spring_version}"
  implementation "org.jetbrains.kotlin:kotlin-stdlib:${kotlin_version}"
  
  testImplementation "org.testng:testng:${testng_version}"
}

tasks.register("customTask") {
  group = "Custom"
  description = "Example task"
  
  doLast {
    println "Running custom task"
  }
}
```

### Formatting Gradle Scripts

For formatting Gradle scripts:

- In **IntelliJ IDEA**: Use Code → Reformat Code (Ctrl+Alt+L / Cmd+Option+L)
- In **VS Code**: With the Gradle extension installed, use Format Document (Shift+Alt+F / Shift+Option+F)
- Consider using a Gradle-specific formatter like [Spotless](https://github.com/diffplug/spotless) with the Gradle
  extension to automate formatting

## Documentation

### KDoc/JavaDoc Comments

- Document all public APIs with KDoc (Kotlin) or JavaDoc (Java)
- Include parameter descriptions, return values, and examples where appropriate
- Use markdown syntax in KDoc comments

Example:

```kotlin
/**
 * Retrieves cached values in bulk for multiple keys.
 *
 * @param keys Collection of keys to retrieve from cache
 * @return Map of keys to their cached values, omitting any keys not found
 * @throws CacheException if there is an error accessing the cache
 *
 * Example:
 * ```

* val values = bulkCache.getAll(listOf("key1", "key2", "key3"))
* ```

*/
fun <K, V> getAll(keys: Collection<K>): Map<K, V>

```

## Commit Guidelines

- Use [Conventional Commits](https://www.conventionalcommits.org/) format
- Reference issue numbers in commit messages when applicable
- Keep commits focused on a single logical change
- Sign all commits with your GPG key

## Testing Standards

- Write unit tests for all public APIs
- Name test classes with a `Test` suffix
- Name test methods to clearly describe what they're testing
- Maintain at least 70% code coverage

## IDE/Editor Setup

This project includes configuration files for various IDEs and editors to make it easier to follow the code style.

### IntelliJ IDEA

The `.idea/codeStyles/Project.xml` file configures IntelliJ IDEA to use the project code style. When you open the project in IntelliJ IDEA:

1. Go to Settings → Editor → Code Style
2. Ensure "Project" is selected in the Scheme dropdown
3. The IDE will automatically apply the correct formatting

You can reformat code at any time with:
- **Windows/Linux**: Ctrl+Alt+L
- **macOS**: Option+Command+L

### Visual Studio Code

The project includes VS Code settings in the `.vscode` directory:

1. Install the recommended extensions:
   - "EditorConfig for VS Code"
   - "Extension Pack for Java"
   - "Kotlin Language"

2. VS Code will automatically apply the formatting settings from `.vscode/settings.json`

3. Format your code with:
   - **Windows/Linux**: Shift+Alt+F
   - **macOS**: Shift+Option+F

### Eclipse

For Eclipse users:

1. Import the formatter settings from `.vscode/java-formatter.xml`:
   - Go to Window → Preferences → Java → Code Style → Formatter
   - Click "Import" and select the java-formatter.xml file
   - Select "SpringBulkLayeredCache" profile

### Other Editors

This project includes an `.editorconfig` file that is supported by many editors. Most modern editors either natively support EditorConfig or have plugins available.

## Automatic Formatting on Save

When possible, enable "Format on Save" in your IDE/editor to ensure your code always adheres to the style guidelines. This is already configured in the VS Code settings.

## Pre-commit Checks

Consider setting up a Git pre-commit hook to verify formatting before committing:

```bash
#!/bin/sh
# Add formatting verification command here
# Example for Kotlin:
# ./gradlew ktlintCheck
```

## Project-Specific Script Guidelines

### Scripts Organization

This project uses a modular script structure in the `scripts/` directory. Each script has a specific purpose:

- **kotlin.gradle**: Kotlin language configuration and dependencies
- **spring_boot.gradle**: Spring Boot plugin and dependency configuration
- **tasks.gradle**: Custom Gradle tasks like `resolveAndLockAll`
- **jacoco.gradle**: Code coverage configuration and reporting

### Script-Specific Formatting

#### JaCoCo Script Formatting

For the `jacoco.gradle` script:

- Use comments to explain coverage thresholds and exclusion patterns
- Use consistent formatting for exclusion patterns, each on a separate line with explanatory comments
- Format the nested `reports` block with proper indentation

Example:

```groovy
jacocoTestReport {
  dependsOn test
  reports {
    xml.required = true // XML report needed for coverage tools in CI
    csv.required = true // CSV report used for badge generation
    html.required = true
    html.outputLocation = layout.buildDirectory.dir('reports/jacoco')
  }
}
```

#### Task Script Formatting

For the `tasks.gradle` script:

- Separate task registration with empty lines
- Place task group and description fields at the top of the task configuration
- Use proper indentation for nested closures like `doLast` and `doFirst`

Example:

```groovy
tasks.register('resolveAndLockAll') {
  group = "dependency locking"
  description = "Resolves and locks all project dependencies"
  
  doLast {
    println "Resolving dependencies..."
    // Task implementation
  }
}
```

## Cache Implementation Guidelines

### Layered Caching Patterns

When implementing cache providers:

1. **Cache Operations**:
  - Keep bulk operations and single operations consistent
  - Use descriptive method names that clearly indicate their purpose
  - Return empty collections rather than null for bulk operations

2. **Performance Considerations**:
  - Minimize object allocations in hot paths
  - Use proper nullability annotations to prevent NPEs
  - Consider thread safety in cache implementation

3. **Error Handling**:
  - Use specific exception types for different error conditions
  - Catch and handle provider-specific exceptions, translating to common exceptions
  - Log errors with appropriate detail at appropriate levels

Example:

```kotlin
override fun <K, V> getAll(keys: Collection<K>): Map<K, V> {
  if (keys.isEmpty()) {
    return emptyMap()
  }
  
  try {
    // Provider-specific implementation
    return providerCache.getAll(keys)
  } catch (e: ProviderSpecificException) {
    logger.error("Failed to retrieve items from cache", e)
    throw CacheOperationException("Failed to retrieve items from cache", e)
  }
}
```

### Spring Integration Guidelines

For Spring integration in the `bulk-spring` module:

1. **Bean Configuration**:
  - Keep bean definitions minimal and focused
  - Use `@ConditionalOn...` annotations appropriately
  - Provide sensible defaults that work well in most environments

2. **Annotation Processing**:
  - Follow Spring's annotation processing patterns
  - Document public APIs thoroughly with examples
  - Handle edge cases explicitly

### Multi-Module Structure

Our project follows a modular structure to separate concerns:

- **bulk-core**: Base interfaces and annotations
- **bulk-caffeine**: Caffeine-based cache implementation
- **bulk-redis**: Redis-based cache implementation
- **bulk-spring**: Spring framework integration

When contributing:

1. Place code in the appropriate module based on its dependencies
2. Avoid circular dependencies between modules
3. Minimize dependency leakage (e.g., don't expose Redis-specific types in interfaces)

## Performance Sensitive Code

For performance-critical sections:

- Add comments explaining performance considerations
- Consider using inline functions for small, frequently called methods
- Use primitive collections when appropriate to reduce boxing/unboxing
- Add benchmarks for critical sections in separate benchmark modules
- Document performance characteristics in KDoc comments

## Questions and Style Discussions

If you have questions about the code style or would like to propose changes, please open a discussion issue on the
GitHub repository.
