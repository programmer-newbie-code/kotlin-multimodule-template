# Contributing to Kotlin Multimodule Template

Thanks for your interest! Here's how you can help:

## Documentation

Our full documentation is available at:
<!-- TODO: Replace with your own documentation URL -->
*
*[https://programmer-newbie-code.github.io/kotlin-multimodule-template/](https://programmer-newbie-code.github.io/kotlin-multimodule-template/)
**

Please refer to the documentation for detailed guides on project architecture and design principles.

## How to Contribute

### Fork and Pull Request Workflow

1. **Fork the repository** to your own GitHub account
2. **Clone your fork** to your local machine:
   ```
   git clone https://github.com/YOUR-USERNAME/kotlin-multimodule-template.git
   ```
3. **Add the original repo as a remote** to keep your fork in sync:
   ```
   git remote add upstream https://github.com/programmer-newbie-code/kotlin-multimodule-template.git
   ```
4. **Create a new branch** for your changes:
   ```
   git checkout -b feature/your-feature-name
   ```
5. **Make your changes** and commit them with signed commits (see below)
6. **Rebase on the latest main branch** before submitting your PR:
   ```
   git fetch upstream
   git rebase upstream/main
   ```
7. **Push your branch** to your fork:
   ```
   git push origin feature/your-feature-name
   ```
8. **Create a Pull Request** from your fork to the original repository

### Dependency Management

We use Gradle's dependency locking to ensure reproducible builds. All dependency versions are centrally defined in
`gradle.properties`.

When adding or updating dependencies:

1. **Add the dependency** to the appropriate `build.gradle` file
2. **Regenerate lock files** with:
   ```
   ./gradlew resolveAndLockAll --write-locks
   ```
3. **Commit both the build.gradle changes and the updated lock files**

### Code Signing Requirements

All commits must be signed with your GPG key. This helps verify the authenticity of contributions.

1. **Set up GPG** if you haven't already:
   ```
   git config --global user.signingkey YOUR_GPG_KEY_ID
   git config --global commit.gpgsign true
   ```

2. **Sign your commits** when committing:
   ```
   git commit -S -m "Your commit message"
   ```

3. **Verify** that commits are signed before pushing

## 🔐 **IMPORTANT: All commits must be GPG signed**

This repository requires all commits to be cryptographically signed for security and authenticity.

### Quick Setup

- **New to GPG?** See our [GPG Setup Guide](docs/gpg-setup.md)
- **Need help?** Check the platform-specific guides in the `docs/` folder

### Verification

Before contributing, verify your setup:

```bash
# Check if signing is enabled
git config commit.gpgsign
# Should return: true

# Check your signing key
git config user.signingkey
# Should return your GPG key ID

# Test with a signed commit
git commit --allow-empty -m "test: verify GPG signing"
git log --show-signature -1
# Should show "Good signature from [your name]"
```

**❌ Unsigned commits will be rejected during code review.**

### Branch Protection and Review Process

Our repository has branch protection rules in place:

- **Direct pushes to main are not allowed**
- **All PRs require at least one approving review**
- **All PRs must pass status checks** (including code coverage of at least 70%)
- **Commits must be signed**

### Commit Message and PR Title Conventions

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification for commit messages and pull
request titles to ensure consistency and enable automated tooling for releases and changelogs.

**Format**: `<type>(<scope>): <description>`

- **type**: Describes the kind of change (required)
- **scope**: Component affected by the change (optional)
- **description**: Brief description of the change

**Types**:

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation changes only
- `style`: Changes that don't affect code functionality (formatting, etc.)
- `refactor`: Code refactoring without feature changes or bug fixes
- `perf`: Performance improvements
- `test`: Adding or fixing tests
- `chore`: Changes to build process, tooling, etc.
- `ci`: Changes to CI configuration files and scripts
- `revert`: Reverts a previous commit

**Examples**:

- `feat(core): add bulk fetch operation`
- `fix(redis): resolve connection leak issue`
- `docs: update API documentation`
- `test(caffeine): add coverage for eviction policy`

Both commit messages and PR titles should follow these conventions. The PR title will be used as the squash commit
message when merging.

### Development Tags

For development versions:

- Use `-dev` suffix on version tags (e.g., `v1.0.0-dev`)
- Development versions will be built but not published to the package registry

For release versions:

- Use clean version tags without suffixes (e.g., `v1.0.0`)
- Release versions will be built and published to the GitHub Package Registry

## Code Quality and Testing

### Code Style

We use a standardized code style with 2 space indentation. Please configure your IDE accordingly:

- For IntelliJ IDEA, import the provided `.idea` configuration
- For VS Code, use the settings in `.vscode` directory

### Testing Requirements

- **Maintain code coverage** of at least 70%
- **Add tests** for any new features or bug fixes
- **Run the full test suite** before submitting PRs:
  ```
  ./gradlew test
  ```

### Code Coverage

Check code coverage with:

```
./gradlew jacocoTestReport
```

Verify coverage meets our 70% threshold:

```
./gradlew jacocoTestCoverageVerification
```

## Questions?

If you have any questions or need help, please open an issue with the label "question".
