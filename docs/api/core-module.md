---
layout: default
title: Core Module
parent: API Reference
nav_order: 1
---

# Core Module

The `core-module` provides the foundational interfaces and classes for your application.

## Key Components

### Core Interfaces

The module defines key interfaces that represent the domain model:

- `Repository` - Data access layer interface
- `Service` - Business logic layer interface
- `Model` - Domain model interfaces

### Usage Example

```kotlin
// Example service implementation
class UserServiceImpl(
    private val userRepository: UserRepository
) : UserService {

    override fun getUser(id: String): User? {
        return userRepository.findById(id)
    }

    override fun createUser(user: User): User {
        return userRepository.save(user)
    }
}
```

## Module Dependencies

To use the core module, include the dependency:

```kotlin
implementation(project(":core-module"))
```

This module should be kept free of implementation dependencies and should only define the contracts that other modules
implement.
