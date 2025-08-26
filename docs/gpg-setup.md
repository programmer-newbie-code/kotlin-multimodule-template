# GPG Setup for Signed Commits

This guide helps you set up GPG (GNU Privacy Guard) for signing your Git commits across different operating systems.
Signed commits provide cryptographic proof that commits come from a trusted source.

## Quick Platform Selection

Choose your operating system to get started:

| Platform       | Guide                                       | Package Manager                        |
|----------------|---------------------------------------------|----------------------------------------|
| 🪟 **Windows** | [Windows Setup Guide](gpg-setup-windows.md) | winget, Chocolatey, or Direct Download |
| 🐧 **Linux**   | [Linux Setup Guide](gpg-setup-linux.md)     | apt, dnf, pacman, zypper               |
| 🍎 **macOS**   | [macOS Setup Guide](gpg-setup-macos.md)     | Homebrew, MacPorts, or GPG Suite       |

## Why Sign Your Commits?

- **🔒 Authentication**: Proves commits actually came from you
- **🛡️ Integrity**: Ensures commits haven't been tampered with
- **✅ Trust**: GitHub shows "Verified" badge for signed commits
- **🏢 Compliance**: Required by many organizations and projects

## What You'll Need

- **Email**: The same email address used for your GitHub account
- **Strong Passphrase**: To protect your private key
- **5-10 minutes**: For initial setup

## Quick Overview

All platforms follow these general steps:

1. **Install GPG** (varies by platform)
2. **Generate RSA 4096-bit key pair**
3. **Export public key**
4. **Add public key to GitHub**
5. **Configure Git for automatic signing**
6. **Test with a signed commit**

## After Setup

Once you've completed the setup for your platform:

### Verify Your Setup

```bash
# Check your configuration
git config --global user.signingkey
git config --global commit.gpgsign

# Test with a signed commit
git commit --allow-empty -m "test: verify GPG signed commits"
git log --show-signature -1
```

### GitHub Integration

After adding your public key to GitHub, you'll see:

- ✅ **"Verified" badge** next to your commits
- 🔒 **Green shield icon** indicating cryptographic verification
- 👤 **Commit author verification** in the GitHub UI

## Troubleshooting

### Common Issues Across Platforms

**GPG not found:**

- Ensure GPG is installed and in your PATH
- Restart your terminal after installation

**Passphrase prompts:**

- Configure GPG agent for passphrase caching
- Set up appropriate pinentry program for your OS

**Git can't find GPG:**

- Set explicit GPG program path: `git config --global gpg.program /path/to/gpg`

**Permission denied:**

- Check GPG directory permissions: `chmod 700 ~/.gnupg`

### Platform-Specific Help

Each platform guide includes detailed troubleshooting sections for OS-specific issues.

## Security Best Practices

- **🔐 Use strong passphrases** (12+ characters with mixed case, numbers, symbols)
- **💾 Backup your private key** securely
- **⏰ Consider key expiration** (1-2 years) for enhanced security
- **🚫 Never share your private key** or passphrase
- **🔄 Keep your GPG software updated**

## Team Usage

For teams requiring signed commits:

1. **Document the requirement** in your project README
2. **Link to these setup guides** for new contributors
3. **Configure branch protection** to require signed commits
4. **Consider key management** for organization keys

## Repository Configuration

To enforce signed commits in your repository:

```yaml
# In GitHub Actions workflows
- name: Verify signed commits
  run: |
    # Check that recent commits are signed
    git log --show-signature -5
```

Or configure branch protection rules in GitHub to require signed commits.

---

**Need help?** Check the platform-specific guides linked above, or refer to the troubleshooting sections in each guide.
