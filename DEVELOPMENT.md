# Development Guide

This guide provides detailed instructions for setting up a development environment and working on Kotlin Multimodule
Template.

## Prerequisites

- JDK 21
- Gradle (wrapper included)
- Git with commit signing configured

## Development Environment Setup

1. **Clone your fork**:
   ```
   git clone https://github.com/YOUR-USERNAME/kotlin-multimodule-template.git
   cd kotlin-multimodule-template
   ```

2. **Set up Git hooks** (optional but recommended):

   Create a pre-commit hook to verify your commits are signed:

   ```bash
   # Create .git/hooks/pre-commit
   echo '#!/bin/sh
   if git config --get commit.gpgsign | grep -q "true"; then
     echo "Commit signing is enabled."
     exit 0
   else
     echo "Error: Commit signing is not enabled."
     echo "Please run: git config commit.gpgsign true"
     exit 1
   fi' > .git/hooks/pre-commit
   
   # Make it executable
   chmod +x .git/hooks/pre-commit
   ```

3. **Build the project**:
   ```
   ./gradlew build
   ```

4. **Run tests**:
   ```
   ./gradlew test
   ```

## Project Structure

- `springboot-application` - Example Spring Boot application
- `core-module` - Core interfaces and models (documentation)
- `feature-module` - Feature implementations (documentation)
- `scripts` - Gradle build scripts

## Development Workflow

1. Create a feature branch with a descriptive name
2. Make changes and write tests
3. Ensure all tests pass with `./gradlew test`
4. Commit with signed commits
5. Rebase on the latest main branch before submitting a PR
6. Submit a PR with a clear description of changes

## Dependency Management

We use Gradle dependency locking for reproducible builds:

1. Add dependencies in appropriate build.gradle file
2. Update dependency lock files:
   ```
   ./gradlew resolveAndLockAll --write-locks
   ```
3. Commit updated lock files

## Code Style

- Follow the Kotlin coding conventions
- Use meaningful variable and function names
- Document public APIs with KDoc comments
- Write tests for new functionality

## Useful Gradle Commands

- `./gradlew clean` - Clean the build
- `./gradlew build` - Build the project
- `./gradlew test` - Run tests
- `./gradlew resolveAndLockAll --write-locks` - Update dependency lock files
- `./gradlew publishToMavenLocal` - Publish to local Maven repository

## IDE Setup

### IntelliJ IDEA

1. Import the project as a Gradle project
2. Use the Kotlin plugin version compatible with the project
3. Enable the following settings:
  - Code Style > Kotlin > Use Kotlin code style
  - Build, Execution, Deployment > Build Tools > Gradle > Use Gradle for builds

## Troubleshooting

If you encounter issues:

1. Verify your Java version with `java -version`
2. Ensure dependency lock files are up to date
3. Try cleaning the build with `./gradlew clean`
4. Check Gradle wrapper version with `./gradlew --version`

If you need help, create an issue with the "help wanted" label.
