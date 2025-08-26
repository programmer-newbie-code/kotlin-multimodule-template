---
layout: home
title: Home
nav_order: 1
---

# Kotlin Multimodule Template

A minimal, production-ready Kotlin multimodule template for Spring Boot applications with proper Spring-Kotlin
integration, comprehensive testing, and GitHub template features.

## 🎯 Overview

This template provides a clean foundation for creating scalable Kotlin microservices with:

- **Simple 2-module architecture** (service + application layers)
- **Spring-Kotlin integration** with `allopen` plugin configured
- **Dependency locking** for reproducible builds
- **Comprehensive testing setup** with unit test grouping
- **GitHub template ready** with customization scripts
- **Production-ready CI/CD** and security scanning

## 🚀 Quick Start

### 1. Use This Template

Click "Use this template" button on GitHub to create your new repository.

### 2. Customize Your Project

```bash
# Linux/Mac
./customize.sh

# Windows PowerShell  
./customize.ps1
```

### 3. Build and Run

```bash
./gradlew build
./gradlew :springboot-application:bootRun
```

### 4. Test Your Setup

```bash
curl http://localhost:8080/api/example/health
```

## 📚 Documentation Sections

### Getting Started

- [Template Setup Guide](./template-setup.md) - Step-by-step customization
- [Project Structure](./project-structure.md) - Understanding the architecture
- [Dependency Management](./dependency-management.md) - Gradle locks and versions

### Development

- [Unit Testing Guide](./unit-testing.md) - Testing strategies and grouping
- [Spring-Kotlin Integration](./spring-kotlin.md) - Allopen plugin and beans
- [Code Quality](./code-quality.md) - Coverage, security, and style

### CI/CD & Deployment

- [GitHub Workflows](./workflows.md) - Automated testing and deployment
- [Branch Protection](./branch-protection.md) - Repository security
- [Commit Conventions](./commit-conventions.md) - Git workflow standards

### Reference

- [API Documentation](./api/) - Module APIs and interfaces
- [Troubleshooting](./troubleshooting.md) - Common issues and solutions

## 🏗️ Architecture

### Current Modules

- **service-module**: Business logic and services with Spring annotations
- **springboot-application**: REST controllers and application configuration

### Key Features

- ✅ **Spring Bean Creation**: Kotlin `allopen` plugin configured for Spring annotations
- ✅ **Dependency Injection**: Works seamlessly with `@Service`, `@Controller` annotations
- ✅ **Transaction Management**: `@Transactional` support with AOP proxies
- ✅ **Reproducible Builds**: Dependency locking enabled
- ✅ **Modular Testing**: Unit tests grouped by scope and performance

## 🧪 Testing Strategy

This template includes comprehensive testing setup:

```bash
# Run all tests
./gradlew test

# Run specific test groups
./gradlew test --tests "*Unit*"
./gradlew test --tests "*Integration*"

# Performance tests
./gradlew jmh
```

## 📦 Dependency Management

Uses Gradle dependency locking for reproducible builds:

```bash
# Update locks after adding dependencies
./gradlew resolveAndLockAll --write-locks

# Check for dependency updates
./gradlew dependencyUpdates
```

## 🔒 Security

- **Dependency vulnerability scanning** with OWASP
- **License compliance checking**
- **GPG commit signing** (optional)
- **Branch protection** for main branches

## 📈 Getting Help

- 📖 [Full Documentation](./template-setup.md)
- 🐛 [Issue Tracker](https://github.com/programmer-newbie-code/kotlin-multimodule-template/issues)
- 💬 [Discussions](https://github.com/programmer-newbie-code/kotlin-multimodule-template/discussions)
- 📧 [Contributing](./contributing.md)
