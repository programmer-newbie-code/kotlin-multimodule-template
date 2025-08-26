# Commit Message and PR Title Conventions

This project follows the **Conventional Commits** specification, with a focus on **PR titles** since we use **squash
merging only**.

## 🔄 **Important: Squash Merging Only**

This repository is configured for **squash merging only**. This means:

- ✅ **PR Title is crucial** - becomes the final commit message after squash
- ℹ️ **Individual commit messages** - less critical, used only during development
- 🎯 **Focus on PR titles** - ensure they follow conventional format

## Format

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

## Types

| Type       | Description                                               | Example                                           |
|------------|-----------------------------------------------------------|---------------------------------------------------|
| `feat`     | A new feature                                             | `feat(core): add bulk fetch operation`            |
| `fix`      | A bug fix                                                 | `fix(redis): resolve connection leak issue`       |
| `docs`     | Documentation only changes                                | `docs: update API documentation`                  |
| `style`    | Code style changes (formatting, missing semi colons, etc) | `style: fix code formatting`                      |
| `refactor` | Code change that neither fixes a bug nor adds a feature   | `refactor(cache): simplify key generation logic`  |
| `perf`     | Performance improvements                                  | `perf(core): optimize batch processing`           |
| `test`     | Adding missing tests or correcting existing tests         | `test(redis): add integration tests`              |
| `chore`    | Changes to build process, auxiliary tools, libraries      | `chore(deps): update spring boot to 3.5.4`        |
| `ci`       | Changes to CI configuration files and scripts             | `ci: add coverage reporting workflow`             |
| `build`    | Changes to build system or external dependencies          | `build: update gradle wrapper to 8.5`             |
| `revert`   | Reverts a previous commit                                 | `revert: revert "feat: add experimental feature"` |

## Scopes

Common scopes for this project:

| Scope      | Description                     |
|------------|---------------------------------|
| `core`     | Changes to bulk-core module     |
| `redis`    | Changes to bulk-redis module    |
| `caffeine` | Changes to bulk-caffeine module |
| `spring`   | Changes to bulk-spring module   |
| `cache`    | General caching functionality   |
| `config`   | Configuration-related changes   |
| `api`      | Public API changes              |
| `deps`     | Dependency updates              |
| `ci`       | CI/CD pipeline changes          |
| `docs`     | Documentation changes           |
| `test`     | Testing infrastructure          |
| `security` | Security-related changes        |

## 🎯 **PR Title Requirements (CRITICAL)**

**Pull Request titles MUST follow conventional commit format since they become the final commit message:**

- ✅ `feat(redis): implement connection pooling`
- ✅ `feat(redis): Implement connection pooling`
- ✅ `fix: resolve memory leak in cache manager`
- ✅ `fix: Resolve memory leak in cache manager`
- ✅ `docs: update contributing guidelines`
- ✅ `docs: Update contributing guidelines`
- ❌ `Add new feature` (missing type)
- ❌ `Fix bug` (missing description)
- ❌ `FEAT: new feature` (uppercase type)

**Note**: The description can start with either lowercase or uppercase - choose what feels natural!

## 💻 **Individual Commit Messages (Development Only)**

Since we use squash merging, individual commit messages are used only during development and won't appear in the main
branch history. However, for good development practices:

### ✅ **Recommended** (but not enforced):

```bash
feat(redis): add connection pooling logic
fix: resolve timeout issue
test: add unit tests for cache manager
docs: update README
```

### ✅ **Also acceptable** (for development commits):

```bash
WIP: working on redis integration
temp: debugging connection issue
checkpoint: basic implementation done
fix typo
```

## Branch Naming Convention

Branch names must follow this pattern: `<prefix>/<description>`

### Valid Prefixes

| Prefix     | Purpose                  | Example                            |
|------------|--------------------------|------------------------------------|
| `feature`  | New features             | `feature/redis-connection-pooling` |
| `fix`      | Bug fixes                | `fix/memory-leak-core`             |
| `hotfix`   | Critical fixes           | `hotfix/security-vulnerability`    |
| `chore`    | Maintenance tasks        | `chore/update-dependencies`        |
| `docs`     | Documentation updates    | `docs/api-documentation`           |
| `refactor` | Code refactoring         | `refactor/simplify-cache-logic`    |
| `test`     | Testing improvements     | `test/integration-tests`           |
| `perf`     | Performance improvements | `perf/optimize-batch-operations`   |

### Branch Naming Rules

- Use lowercase letters, numbers, and hyphens only
- Separate words with hyphens (`-`)
- Be descriptive but concise
- Maximum 50 characters

### Examples

#### Good Branch Names ✅

```bash
feature/bulk-redis-adapter
fix/connection-timeout-issue
docs/update-readme
test/caffeine-integration
chore/gradle-wrapper-update
```

#### Bad Branch Names ❌

```bash
Feature/NewStuff          # Uppercase letters
fix_memory_leak           # Underscores instead of hyphens  
feature/ABC-123           # Uppercase in description
my-random-branch          # No prefix
feature/                  # Empty description
```

## Examples

### ✅ **Good PR Titles** (Critical - these become final commits):

```bash
feat(core): add bulk fetch operation with timeout support
fix(redis): resolve connection leak in batch operations
docs: update README with new installation instructions
perf(caffeine): optimize cache eviction algorithm
test(spring): add integration tests for autoconfiguration
chore(deps): update spring boot to 3.5.4
ci: add automated dependency updates
refactor(api): simplify cache key generation
```

### ✅ **Good Development Commits** (Optional - for your workflow):

```bash
feat(redis): initial connection pooling implementation
WIP: working on timeout handling
fix: resolve compilation error
test: add basic unit tests
checkpoint: basic redis adapter working
fix typo in documentation
temp: debugging connection issue
```

### ❌ **Bad PR Titles** (Will be rejected):

```bash
Add feature                    # Missing type and scope
fix bug                       # Too vague
FEAT: new cache layer         # Uppercase type
Fixed the redis thing         # Not conventional format
Update stuff                  # Not descriptive
```

## Commit Signing Requirement

All commits MUST be signed with GPG:

```bash
# Sign individual commit
git commit -S -m "feat(core): add new feature"

# Configure Git to always sign commits
git config --global commit.gpgsign true
```

See our [GPG Setup Guide](gpg-setup.md) for detailed instructions.

## Validation

Our CI/CD pipeline automatically validates:

- ✅ **PR title format** (CRITICAL - enforced strictly)
- ℹ️ ~~Individual commit messages~~ (disabled for squash-merge-only repos)
- ℹ️ **GPG signatures** (informational only)

**Only PR titles are strictly enforced** since they become the final commit messages after squash merge.

## Workflow Summary

### 📝 **For Contributors:**

1. **Create feature branch**: `feature/your-feature-name`
2. **Make commits**: Use any commit style during development
3. **Create PR**: Ensure PR title follows `type(scope): description` format
4. **After merge**: Your PR title becomes the final commit message

### 🔍 **What Gets Validated:**

| Element            | Validation Level     | Impact                       |
|--------------------|----------------------|------------------------------|
| **PR Title**       | ✅ **Strict**         | **Blocks merge if invalid**  |
| Individual Commits | ℹ️ **None**          | No validation (squash merge) |
| Branch Name        | ✅ **Strict**         | **Blocks PR if invalid**     |
| GPG Signatures     | ℹ️ **Informational** | Shows status, doesn't block  |

## Tools

### Local PR Title Validation

You can validate PR titles locally using simple bash commands:

```bash
# Test a PR title format
PR_TITLE="feat(core): add new caching layer"
if echo "$PR_TITLE" | grep -qE '^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)(\(.+\))?: .{3,}$'; then
  echo "✅ Valid PR title format"
else
  echo "❌ Invalid PR title format"
fi
```

### IDE Integration

Most IDEs support conventional commits plugins that can help with formatting:

- **IntelliJ IDEA**: Conventional Commits plugin
- **VS Code**: Conventional Commits extension
- **Vim**: vim-conventional-commits plugin

**Note**: These plugins help with formatting but remember that individual commits are optional since we use squash
merging.

## Questions?

If you have questions about commit conventions, please:

1. Check this documentation
2. Look at recent PR titles in the repository
3. Ask in a GitHub issue with the `question` label

---

## 📖 **Quick Reference:**

**✅ PR Title (CRITICAL):** `type(scope): description`  
**✅ Branch Name:** `prefix/description`  
**ℹ️ Individual Commits:** Any format (optional, for development)
