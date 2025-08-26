# GitHub Workflows Documentation

This document describes the function of each GitHub workflow in this repository.

## Core Workflows

### 1. Build, Test, and Publish (`build-test-publish.yml`)

**Purpose**: Main CI/CD pipeline for building, testing, and publishing the library.

**Triggers**:

- Push to `main` branch
- Pull requests to `main` branch
- Tags starting with `v*`

**Functions**:

- ✅ Validates Gradle wrapper
- 🏗️ Builds all modules
- 🧪 Runs tests with coverage reporting
- 📊 Generates JaCoCo coverage badges
- 📦 Creates JAR artifacts
- 🚀 Publishes releases (production and development)
- 💬 Comments coverage results on PRs
- ❌ Fails PRs with coverage below 70%

**Artifacts**:

- JAR files for all modules
- Coverage reports and badges

### 2. Security Scan (`security-scan.yml`)

**Purpose**: Comprehensive security analysis of the codebase and dependencies.

**Triggers**:

- Push to `main` branch
- Pull requests to `main` branch
- Weekly schedule (Monday 6 AM)

**Functions**:

- 🛡️ OWASP dependency vulnerability scanning
- 🔍 CodeQL static analysis for security issues
- 🔐 TruffleHog secrets scanning
- 📄 Uploads security reports

### 3. Dependency Check (`dependency-check.yml`)

**Purpose**: Focused dependency vulnerability monitoring.

**Triggers**:

- Weekly schedule (Sunday midnight)
- Manual trigger
- Changes to build files or lock files

**Functions**:

- 🔍 Scans dependencies for known vulnerabilities
- 📊 Generates detailed vulnerability reports
- 🚨 Creates GitHub issues for critical vulnerabilities
- ❌ Fails builds with high/critical vulnerabilities

### 4. License Compliance (`license-compliance.yml`)

**Purpose**: Ensures all dependencies have compatible licenses.

**Triggers**:

- Push to `main` branch
- Pull requests to `main` branch
- Weekly schedule (Monday 2 AM)

**Functions**:

- 📜 Generates license reports for all dependencies
- ⚠️ Flags restrictive licenses (GPL, AGPL, etc.)
- 🔍 Additional secrets scanning
- 📄 Creates license compliance artifacts

### 5. Performance Testing (`performance-test.yml`)

**Purpose**: Runs JMH benchmarks to monitor performance.

**Triggers**:

- Pull requests affecting source code
- Push to `main` branch
- Manual trigger

**Functions**:

- 🏃 Runs JMH performance benchmarks (if available)
- 📊 Generates performance reports
- 💬 Comments benchmark results on PRs
- 📈 Tracks performance over time

### 6. Dependency Updates (`dependency-updates.yml`)

**Purpose**: Automated dependency management.

**Triggers**:

- Weekly schedule (Monday 3 AM)
- Manual trigger

**Functions**:

- ⬆️ Updates Gradle wrapper to latest version
- 🔄 Updates dependencies to latest compatible versions
- 🔒 Regenerates lock files
- 🔧 Creates PR with dependency updates

### 7. Generate Changelog (`changelog.yml`)

**Purpose**: Maintains project changelog using conventional commits.

**Triggers**:

- Push to `main` branch
- Tags starting with `v*`
- Manual trigger

**Functions**:

- 📝 Generates CHANGELOG.md from commit history
- 🏷️ Creates release notes for tags
- 🔄 Commits changelog updates automatically

### 8. Deploy GitHub Pages (`pages.yml`)

**Purpose**: Publishes documentation website.

**Triggers**:

- Manual trigger only (currently disabled)
- Can be enabled for docs changes

**Functions**:

- 🌐 Builds Jekyll documentation site
- 📤 Deploys to GitHub Pages
- 📚 Makes documentation accessible via web

## Branch Protection and Code Quality

### Coverage Requirements

- **Minimum Overall Coverage**: 70%
- **Minimum Branch Coverage**: 60%
- All PRs must meet these thresholds to be merged

### Security Requirements

- No high or critical vulnerability dependencies
- All commits must be GPG signed
- Code must pass security scans

### Testing Requirements

- Unit tests must use `@Test(groups=["small"])` annotation
- All modules require test coverage (except excluded ones)
- Performance tests use JMH framework

## Workflow Optimization

The workflows are designed to:

- ✅ Run in parallel where possible
- 🔄 Share artifacts between jobs
- 📦 Cache dependencies for faster builds
- 💾 Store reports for analysis
- 🚫 Fail fast on critical issues

## Artifact Management

### Development Releases (`*-dev` tags)

- Stored in `.repo/dev-releases/` directory
- Marked as prerelease
- Available for testing purposes

### Production Releases (version tags)

- Published to GitHub Packages
- Created as GitHub releases
- Include changelog and artifacts

## Manual Triggers

Most workflows support manual triggering via GitHub Actions UI:

1. Go to Actions tab
2. Select workflow
3. Click "Run workflow"
4. Choose branch and parameters
