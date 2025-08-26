# GPG Setup for Signed Commits - Linux Guide

## Quick Setup via Terminal

### Step 1: Install GPG

Most Linux distributions come with GPG pre-installed. If not, install it using your package manager:

```bash
# Ubuntu/Debian
sudo apt update && sudo apt install gnupg

# CentOS/RHEL/Fedora
sudo dnf install gnupg2
# or for older versions:
sudo yum install gnupg2

# Arch Linux
sudo pacman -S gnupg

# openSUSE
sudo zypper install gpg2
```

### Step 2: Verify GPG Installation

```bash
gpg --version
```

### Step 3: Generate GPG Key

```bash
gpg --full-generate-key
```

**When prompted, choose:**

- Key type: `1` (RSA and RSA)
- Key size: `4096`
- Key validity: `0` (key does not expire, or choose a specific time)
- Real name: `Your Full Name` (use your real name)
- Email: `your-github-email@example.com` (use your GitHub email)
- Comment: Leave blank or add a comment
- Passphrase: Choose a strong passphrase (remember this!)

### Step 4: Get Your Key ID

```bash
gpg --list-secret-keys --keyid-format=long
```

Look for output like:

```
sec   rsa4096/ABC123DEF456 2025-07-24 [SC]
      1234567890ABCDEF1234567890ABCDEF12345678
uid                 [ultimate] Your Name <your-email@example.com>
ssb   rsa4096/XYZ789 2025-07-24 [E]
```

The key ID is `ABC123DEF456` (after rsa4096/)

### Step 5: Export Your Public Key

```bash
gpg --armor --export YOUR_KEY_ID
```

(Replace YOUR_KEY_ID with your actual key ID)

Copy the entire output (including -----BEGIN PGP PUBLIC KEY BLOCK----- and -----END PGP PUBLIC KEY BLOCK-----)

### Step 6: Add Key to GitHub

1. Go to GitHub → Settings → SSH and GPG keys
2. Click "New GPG key"
3. Paste your public key
4. Click "Add GPG key"

### Step 7: Configure Git

```bash
git config --global user.signingkey YOUR_KEY_ID
git config --global commit.gpgsign true
```

### Step 8: Test Signed Commit

```bash
cd /path/to/your/project
git commit --allow-empty -m "test: verify GPG signed commits are working"

# Verify the signature
git log --show-signature -1
```

You should see output like:

```
gpg: Good signature from "Your Name <your-email@example.com>" [ultimate]
```

## Additional Configuration

### Set GPG TTY (if needed)

Add to your shell profile (~/.bashrc, ~/.zshrc, etc.):

```bash
export GPG_TTY=$(tty)
```

### Configure GPG Agent (for passphrase caching)

```bash
# Add to ~/.gnupg/gpg-agent.conf
default-cache-ttl 28800
max-cache-ttl 86400
```

Then restart the agent:

```bash
gpgconf --kill gpg-agent
gpg-agent --daemon
```

## Troubleshooting

### GPG Agent Issues

```bash
# Restart GPG agent
gpgconf --kill all
gpg-agent --daemon

# Check GPG agent status
gpg-agent --version
```

### Permission Issues

```bash
# Fix GPG directory permissions
chmod 700 ~/.gnupg
chmod 600 ~/.gnupg/*
```
