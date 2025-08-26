---
layout: default
title: Code Quality
nav_order: 7
---

# Code Quality & Coverage Standards

This template enforces strict code quality standards including **85% minimum test coverage** to ensure maintainable,
reliable code.

## 📊 Coverage Requirements

### Minimum Coverage Standards

- **Overall Project Coverage**: 85% instruction and branch coverage
- **Individual Class Coverage**: 85% instruction coverage
- **Method Coverage**: 76.5% instruction coverage (90% of overall requirement)

### Coverage Verification

```bash
# Run tests with coverage verification
./gradlew test jacocoTestCoverageVerification

# Generate coverage reports
./gradlew jacocoTestReport

# Aggregate coverage across all modules
./gradlew jacocoRootReport
```

### Coverage Reports

- **HTML Report**: `build/reports/jacoco/test/html/index.html`
- **XML Report**: `build/reports/jacoco/test/jacocoTestReport.xml` (for CI tools)
- **CSV Report**: `build/reports/jacoco/test/jacocoTestReport.csv` (for badges)
- **Aggregate Report**: `build/reports/jacoco/aggregate/index.html`

## 🎯 What's Excluded from Coverage

### Automatically Excluded Classes

The template intelligently excludes boilerplate code that doesn't require testing:

```groovy
// Configuration and framework classes
'**/*Config*', '**/*Configuration*', '*Application*'

// Data classes and DTOs
'*.dto.*', '*.entity.*', '*.model.*'

// Exception classes (definition only)
'*.exception.*', '**/*Exception*'

// Kotlin-generated code
'**/*\$Companion*', '**/*\$WhenMappings*'

// Spring auto-configuration
'**/*AutoConfiguration*', '**/autoconfigure/**'
```

### Smart Exclusions

- **Properties classes**: Configuration binding classes
- **Builder patterns**: Often boilerplate code
- **Generated code**: Serializers, creators, etc.
- **Framework classes**: Spring context and configuration

## 🧪 Coverage-Driven Testing Strategy

### Test Organization for Coverage

```
src/test/kotlin/
├── unit/small/         # Fast tests (< 100ms) - High coverage impact
├── unit/medium/        # Tests with mocks (< 1s) - Medium coverage  
├── integration/        # Full context tests - Lower coverage priority
└── performance/        # JMH benchmarks - Excluded from coverage
```

### Writing Tests for 85% Coverage

**Example Service with Full Coverage:**

```kotlin
@Service
@Transactional
class ExampleService {
    fun getWelcomeMessage(name: String = "World"): String {
        return "Hello, $name! This is your Kotlin Multimodule Template."
    }
    
    suspend fun getAsyncWelcomeMessage(name: String = "World"): String {
        kotlinx.coroutines.delay(100)
        return "Hello async, $name! This is your Kotlin Multimodule Template."
    }
}
```

**Comprehensive Test Coverage:**

```kotlin
class ExampleServiceUnitTest {
    @Test
    fun getWelcomeMessage_WithCustomName_ReturnsPersonalizedMessage() {
        // Covers: main path with parameter
    }
    
    @Test  
    fun getWelcomeMessage_WithDefaultName_ReturnsDefaultMessage() {
        // Covers: default parameter branch
    }
    
    @Test
    fun getWelcomeMessage_WithEmptyString_ReturnsMessageWithEmptyName() {
        // Covers: edge case handling
    }
    
    @Test
    fun getAsyncWelcomeMessage_WithCustomName_ReturnsAsyncMessage() {
        // Covers: async method main path
    }
    
    @Test
    fun getAsyncWelcomeMessage_ExecutionTime_CompletesWithinReasonableTime() {
        // Covers: async delay behavior
    }
}
```

## 🚦 Coverage Quality Gates

### Build Integration

```yaml
# GitHub Actions example
- name: Run Tests with Coverage
  run: ./gradlew test jacocoTestCoverageVerification

- name: Upload Coverage Reports
  uses: codecov/codecov-action@v3
  with:
    file: build/reports/jacoco/test/jacocoTestReport.xml
```

### Local Development

```bash
# Quick coverage check during development
./gradlew test jacocoTestReport

# View coverage in browser
open build/reports/jacoco/test/html/index.html

# Verify coverage meets standards
./gradlew jacocoTestCoverageVerification
```

### Coverage Failure Handling

When coverage falls below 85%:

1. **Identify uncovered code**:

```bash
# Generate detailed report
./gradlew jacocoTestReport --info
```

2. **Add targeted tests**:
  - Focus on uncovered branches
  - Test edge cases and error paths
  - Ensure all public methods are tested

3. **Review exclusions**:
  - Verify excluded classes are actually boilerplate
  - Consider if complex logic needs coverage

## 📈 Coverage Best Practices

### 1. Write Testable Code

```kotlin
// ✅ Good: Testable with clear dependencies
@Service
class UserService(private val repository: UserRepository) {
    fun createUser(userData: UserData): User {
        return repository.save(User(userData))
    }
}

// ❌ Avoid: Hard to test with static dependencies
@Service  
class UserService {
    fun createUser(userData: UserData): User {
        return StaticRepository.save(User(userData))
    }
}
```

### 2. Test Both Success and Failure Paths

```kotlin
@Test
fun createUser_WithValidData_ReturnsUser() {
    // Test happy path
}

@Test
fun createUser_WithInvalidData_ThrowsValidationException() {
    // Test error path - important for coverage!
}
```

### 3. Cover Edge Cases

```kotlin
@Test
fun processInput_WithEmptyString_HandlesGracefully() {
    // Edge case coverage
}

@Test
fun processInput_WithNullValue_ThrowsAppropriateException() {
    // Null handling coverage
}
```

### 4. Mock External Dependencies

```kotlin
@Test
fun serviceMethod_WithMockedDependency_ProcessesCorrectly() {
    // Given
    every { mockRepository.findById(any()) } returns testUser
    
    // When & Then - focuses on service logic only
}
```

## 🔧 Configuration Details

### Gradle Configuration

The template uses these coverage settings in `gradle.properties`:

```properties
code_coverage_minimum=0.85
```

### JaCoCo Rules

```groovy
violationRules {
    rule {
        limit {
            counter = 'INSTRUCTION'
            value = 'COVEREDRATIO' 
            minimum = 0.85
        }
        limit {
            counter = 'BRANCH'
            value = 'COVEREDRATIO'
            minimum = 0.85
        }
    }
}
```

## 🎯 Coverage Metrics Explained

### Instruction Coverage (85% required)

- **What**: Percentage of bytecode instructions executed
- **Why**: Most accurate measure of code execution
- **Focus**: Ensure all code paths are tested

### Branch Coverage (85% required)

- **What**: Percentage of decision branches taken
- **Why**: Ensures conditional logic is tested
- **Focus**: Test both true/false paths of conditions

### Method Coverage (76.5% required)

- **What**: Percentage of methods called during tests
- **Why**: Ensures public API is tested
- **Focus**: All public methods should have tests

## 🚨 Troubleshooting Coverage Issues

### Common Problems

**Issue**: Coverage below 85% but all logic seems tested
**Solution**: Check for uncovered exception handling or default branches

**Issue**: Kotlin companion objects affecting coverage
**Solution**: Already excluded via `'**/*\$Companion*'` pattern

**Issue**: Spring configuration classes lowering coverage
**Solution**: Already excluded via `'**/*Config*'` pattern

### Debugging Low Coverage

```bash
# Generate detailed HTML report
./gradlew jacocoTestReport

# Look for red/yellow highlighted code in:
# build/reports/jacoco/test/html/index.html
```

This comprehensive coverage strategy ensures your template projects maintain high quality standards while providing
clear guidelines for developers to achieve and maintain 85% test coverage.
