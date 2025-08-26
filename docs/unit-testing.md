---
layout: default
title: Unit Testing Guide
nav_order: 5
---

# Unit Testing Guide

This template provides a comprehensive testing strategy using **TestNG groups** to categorize tests, allowing you to run
different types of tests efficiently.

## 🧪 Testing Philosophy

### Test Pyramid Structure

- **Unit Tests** (70%): Fast, isolated tests for individual components
- **Integration Tests** (20%): Tests for module interactions
- **End-to-End Tests** (10%): Full application workflow tests

### TestNG Groups Strategy

Tests are organized using TestNG groups for flexible execution:

- **`@Test(groups = ["small"])`**: Fast tests (< 100ms) for pure logic
- **`@Test(groups = ["medium"])`**: Tests with lightweight dependencies (< 1s)
- **`@Test(groups = ["large"])`**: Integration tests requiring Spring context or external systems

## 🏗️ Test Structure & Naming

### Test Method Naming Convention

Use descriptive names with backticks following the pattern: **`function, condition, expectation`**

```kotlin
@Test(groups = ["small"])
class ExampleServiceUnitTest {
    
    @Test
    fun `getWelcomeMessage, with custom name, returns personalized message`() {
        // Given
        val name = "Alice"
        
        // When
        val result = exampleService.getWelcomeMessage(name)
        
        // Then
        assertEquals(result, "Hello, Alice! This is your Kotlin Multimodule Template.")
    }
}
```

### TestNG Groups Configuration

Apply groups at the class level for consistent categorization:

```kotlin
/**
 * Small unit tests for ExampleService
 */
@Test(groups = ["small"])
class ExampleServiceUnitTest {
    // All test methods inherit the "small" group
}
```

## 🚀 Running Tests

### By TestNG Groups

```bash
# Run only small/fast tests
./gradlew test -PtestGroups=small

# Run medium tests (with mocks/setup)
./gradlew test -PtestGroups=medium

# Run integration tests
./gradlew test -PtestGroups=large

# Run multiple groups
./gradlew test -PtestGroups="small,medium"

# Run all tests (default)
./gradlew test
```

### Additional Test Tasks

```bash
# Run integration tests specifically
./gradlew integrationTest

# Run all tests including integration
./gradlew allTests

# Run tests in parallel
./gradlew test -PtestGroups=small --parallel
```

## 📊 Coverage Integration

### 85% Minimum Coverage

The template enforces **85% instruction coverage** minimum:

```bash
# Run tests with coverage verification
./gradlew test jacocoTestCoverageVerification

# Generate coverage reports
./gradlew jacocoTestReport

# View coverage report
# Opens: build/reports/jacoco/test/html/index.html
```

### Coverage Exclusions

Smart exclusions are automatically applied:

- Configuration classes (`**/*Config*`, `*Application*`)
- Data classes (`*.dto.*`, `*.entity.*`, `*.model.*`)
- Kotlin-generated code (`**/*$Companion*`, `**/*$WhenMappings*`)
- Exception classes (`*.exception.*`, `**/*Exception*`)

## 🧪 Writing Effective Tests

### Small Group Tests (Fast)

**Characteristics**: Pure logic, no external dependencies, < 100ms

```kotlin
@Test(groups = ["small"])
class ExampleServiceUnitTest {

    @Test
    fun `getWelcomeMessage, with empty string, returns message with empty name`() {
        // Given
        val name = ""
        
        // When
        val result = exampleService.getWelcomeMessage(name)
        
        // Then
        assertEquals(result, "Hello, ! This is your Kotlin Multimodule Template.")
    }
}
```

### Medium Group Tests (With Mocks)

**Characteristics**: Uses mocks, lightweight dependencies, < 1s

```kotlin
@Test(groups = ["small"])  // Controller tests with mocks are still "small"
class ExampleControllerUnitTest {

    @BeforeMethod
    fun setup() {
        mockExampleService = mockk()
        controller = ExampleController(mockExampleService)
    }

    @Test
    fun `getWelcome, with custom name, returns response with message and timestamp`() {
        // Given
        val name = "Alice"
        every { mockExampleService.getWelcomeMessage(name) } returns "Hello, Alice!"

        // When
        val response = controller.getWelcome(name)

        // Then
        assertEquals(response["message"], "Hello, Alice!")
        verify { mockExampleService.getWelcomeMessage(name) }
    }
}
```

### Large Group Tests (Integration)

**Characteristics**: Full Spring context, database, external systems

```kotlin
@Test(groups = ["large"])
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class ExampleControllerIntegrationTest : AbstractTestNGSpringContextTests() {

    @Test
    fun `getWelcome, end to end, returns valid response`() {
        // Full integration test with real Spring context
    }
}
```

## 🔧 Test Configuration

### TestNG Groups in Gradle

The template configures TestNG groups via command-line parameters:

```groovy
// In scripts/testing.gradle
test {
    useTestNG() {
        if (project.hasProperty('testGroups')) {
            String groups = project.property('testGroups')
            includeGroups groups
        }
    }
}
```

### Performance Settings

```groovy
test {
    // Parallel execution
    maxParallelForks = Runtime.runtime.availableProcessors().intdiv(2) ?: 1
    
    // Memory settings
    jvmArgs '-Xmx1g', '-XX:MaxMetaspaceSize=256m'
}
```

## 📈 Coverage Quality Gates

### Build Integration

```bash
# Coverage verification runs automatically with check
./gradlew check  # Includes jacocoTestCoverageVerification

# Quick feedback during development
./gradlew test -PtestGroups=small jacocoTestReport
```

### CI/CD Integration

```yaml
# GitHub Actions example
- name: Run Small Tests
  run: ./gradlew test -PtestGroups=small

- name: Run All Tests with Coverage
  run: ./gradlew test jacocoTestCoverageVerification
```

## 🎯 Best Practices

### 1. Group Classification

- **Small**: Pure business logic, no I/O, fast execution
- **Medium**: With mocks, light setup, moderate execution time
- **Large**: Full context, real dependencies, slower execution

### 2. Test Naming

```kotlin
// ✅ Good: Descriptive and readable
fun `getWelcomeMessage, with null input, throws IllegalArgumentException`()

// ❌ Avoid: Unclear purpose
fun testGetWelcomeMessage1()
```

### 3. Coverage Strategy

- **Focus on business logic**: Ensure all service methods are tested
- **Test edge cases**: Empty strings, null values, boundary conditions
- **Mock external dependencies**: Keep tests fast and isolated

### 4. Group Organization

```kotlin
@Test(groups = ["small"])
class ServiceUnitTest {
    // Fast tests for service logic
}

@Test(groups = ["large"])  
class ServiceIntegrationTest {
    // Tests with full Spring context
}
```

This testing strategy ensures fast feedback during development while maintaining comprehensive coverage and quality
standards.
