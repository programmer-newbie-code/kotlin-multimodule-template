# 🚀 Using This Template

This repository is configured as a **GitHub Template Repository**. Here's how to use it effectively:

## 📋 Quick Start Guide

### Step 1: Create Repository from Template

1. Click the **"Use this template"** button on GitHub
2. Choose **"Create a new repository"**
3. Fill in your repository details:
  - Repository name (e.g., `my-awesome-service`)
  - Description
  - Public/Private visibility
4. Click **"Create repository from template"**

### Step 2: Clone Your New Repository

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git
cd YOUR-REPO-NAME
```

### Step 3: Customize the Template

Choose one of these methods:

#### Option A: Automated Customization (Recommended)

```bash
# For Linux/Mac
./customize.sh

# For Windows PowerShell
./customize.ps1
```

The script will prompt you for:

- **Project name** (e.g., "my-awesome-service")
- **Organization domain** (e.g., "com.mycompany")
- **GitHub organization** (e.g., "my-org")

#### Option B: Manual Customization

See [TEMPLATE_SETUP.md](TEMPLATE_SETUP.md) for detailed manual instructions.

### Step 4: Verify Setup

```bash
# Build the project
./gradlew build

# Run fast tests
./gradlew test -PtestGroups=small

# Run the application
./gradlew :springboot-application:bootRun

# Test your endpoints
curl http://localhost:8080/api/example/health
```

## 🎯 What This Template Provides

### 🏗️ **Architecture**

- **2-module structure**: `service-module` (business logic) + `springboot-application` (REST API)
- **Spring Boot 3.5.3** with Kotlin 1.9.25
- **Spring-Kotlin integration** (allopen plugin configured)

### 🧪 **Testing Strategy**

- **TestNG with groups**: `@Test(groups = ["small"])` for fast tests
- **85% coverage requirement** enforced by JaCoCo
- **MockK integration** for Kotlin-friendly mocking
- **Test naming convention**: `fun \`function, condition, expectation\`()`

### 📦 **Build & Dependencies**

- **Gradle dependency locking** for reproducible builds
- **Version centralization** in `gradle.properties`
- **Multi-module build** with shared configuration scripts

### 🔧 **Development Tools**

- **Code quality**: OWASP dependency scanning, license reporting
- **CI/CD ready**: GitHub Actions workflows included
- **Documentation**: Comprehensive GitHub Pages docs

## 🛠️ **Customization Points**

After using the template, you'll typically want to customize:

### 1. **Package Structure**

```
FROM: io.programmernewbie.template
TO:   com.yourcompany.yourproject
```

### 2. **Project Identity**

- Repository name
- Artifact names
- Main application class name
- GitHub URLs for publishing

### 3. **Business Logic**

- Replace `ExampleService` with your services
- Replace `ExampleController` with your REST endpoints
- Add your domain models and repositories

### 4. **Dependencies**

- Add your specific dependencies to `gradle.properties`
- Update module `build.gradle` files as needed

## 📚 **Next Steps After Customization**

1. **Remove example code**: Delete `ExampleService` and `ExampleController`
2. **Add your business logic**: Implement your actual services and controllers
3. **Configure database**: Update `application.yml` for your database
4. **Add authentication**: Implement security if needed
5. **Update documentation**: Customize README.md for your project

## 🆘 **Getting Help**

- 📖 **Full documentation**: Check the `docs/` folder or GitHub Pages
- 🐛 **Issues**: Report problems in the template repository
- 💬 **Discussions**: Ask questions in GitHub Discussions
- 📧 **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md)

## ✅ **Template Validation**

This template includes automated validation to ensure it works correctly:

- ✅ Builds successfully out of the box
- ✅ All tests pass with 85% coverage
- ✅ Customization scripts work properly
- ✅ All required files are present

---

**Happy coding! 🎉** Your Kotlin multimodule project is ready for development.
