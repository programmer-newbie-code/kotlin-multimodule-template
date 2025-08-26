# Security Policy

## Supported Versions

We actively maintain security updates for the following versions:

| Version | Supported          | End of Life |
|---------|--------------------|-------------|
| 1.x.x   | :white_check_mark: | TBD         |
| 0.x.x   | :x:                | 2024-12-31  |

## Security Standards

This project follows these security best practices:

- **Dependency Scanning**: Automatic OWASP dependency checks
- **Code Analysis**: CodeQL security analysis on all commits
- **Secret Scanning**: Automated detection of exposed secrets
- **Signed Commits**: All commits must be cryptographically signed
- **Branch Protection**: Main branch requires reviews and status checks

## Reporting a Vulnerability

We take security vulnerabilities seriously. Please follow responsible disclosure:

### 🔒 Private Disclosure (Recommended)

1. Use
   GitHub's [Security Advisories](https://github.com/programmer-newbie-code/kotlin-multimodule-template/security/advisories)
2. Click "Report a vulnerability"
3. Provide detailed information about the vulnerability

### 📧 Email Disclosure

<!-- TODO: Replace with your security email -->
If you prefer email, contact: security@programmer-newbie.io

- Use PGP encryption if possible
- Include "SECURITY" in the subject line

### ⚠️ What NOT to do

- Do not open public issues for security vulnerabilities
- Do not disclose vulnerabilities on social media
- Do not attempt to exploit vulnerabilities on production systems

## Information to Include

When reporting a vulnerability, please include:

- **Description**: Clear explanation of the vulnerability
- **Impact**: Potential security impact and affected components
- **Reproduction**: Step-by-step instructions to reproduce
- **Environment**: Affected versions, configurations, dependencies
- **Fix Suggestions**: Any ideas for remediation (optional)

## Response Process

1. **Acknowledgment**: We'll acknowledge receipt within 24 hours
2. **Investigation**: Initial assessment within 72 hours
3. **Updates**: Regular progress updates every 7 days
4. **Resolution**: Security patch and advisory publication
5. **Recognition**: Credit to reporter (if desired)

## Security Updates

- Security fixes are prioritized and released as soon as possible
- Critical vulnerabilities may trigger emergency releases
- Security advisories are published for all confirmed vulnerabilities
- Users are notified through GitHub releases and security advisories

## Scope

### In Scope

- Spring Bulk Layered Cache library code
- Build and deployment configurations
- Documentation that could lead to insecure usage

### Out of Scope

- Third-party dependencies (report to upstream projects)
- Issues in example applications or demos
- General configuration issues not related to security

## Bug Bounty

Currently, we do not offer a formal bug bounty program, but we recognize and credit security researchers who help
improve our project's security.

## Security Configuration

### NVD API Key (Optional but Recommended - FREE)

To speed up OWASP dependency vulnerability scanning, you can optionally configure a **free** NVD API key:

**⚠️ Without API Key:**

- Security scans still work perfectly
- Database updates are just **much slower** (5-10 minutes vs 30 seconds)
- You'll see the warning: "An NVD API Key was not provided"
- **No functionality is lost** - just slower performance

**✅ With Free API Key:**

- Much faster vulnerability database updates
- Same functionality, better performance
- No cost involved

**How to get your FREE API key:**

1. **Visit**: [NVD API Key Request](https://nvd.nist.gov/developers/request-an-api-key) (FREE)
2. **Provide**: Just your email address
3. **Receive**: API key sent instantly to your email
4. **Add to GitHub Secrets**: Go to repository Settings → Secrets and variables → Actions
5. **Add secret**: `NVD_API_KEY` with your API key value

**Cost**: $0.00 - Completely free service from NIST

### OWASP Dependency Check

The security scanning workflow uses OWASP Dependency Check to identify vulnerable dependencies:

- **Automatic Updates**: Downloads latest vulnerability database
- **Fail Threshold**: Builds fail on High/Critical vulnerabilities (CVSS ≥ 7.0)
- **Suppressions**: Use `owasp-suppressions.xml` to suppress false positives
- **Reports**: Generates HTML and JSON reports for analysis

**Commands:**

```bash
# Run security scan
./gradlew dependencyCheckAggregate

# View report
open build/reports/dependency-check-report.html
```

### Vulnerability Management

1. **Automatic Detection**: Weekly scans create GitHub issues for new vulnerabilities
2. **Dependency Updates**: Automated PRs update vulnerable dependencies
3. **Build Protection**: High/Critical vulnerabilities block PR merges
4. **Suppression**: Use suppressions for false positives or accepted risks

---

Thank you for helping keep Spring Bulk Layered Cache secure! 🔒
