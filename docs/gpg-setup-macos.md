# GPG Setup for Signed Commits - macOS Guide

## Quick Setup via Terminal

### Step 1: Install GPG

Install GPG using Homebrew (recommended) or MacPorts:

```bash
# Using Homebrew (recommended)
brew install gnupg

# Using MacPorts (alternative)
sudo port install gnupg2

# Using direct download (if no package manager)
# Download from https://gpgtools.org/ and install GPG Suite
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

# If using Homebrew GPG, you might need to specify the path
git config --global gpg.program $(which gpg)
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

## macOS-Specific Configuration

### Set GPG TTY for Terminal

Add to your shell profile (~/.zshrc, ~/.bash_profile, etc.):

```bash
export GPG_TTY=$(tty)
```

### Configure Pinentry for macOS

Install pinentry-mac for better password prompts:

```bash
brew install pinentry-mac

# Add to ~/.gnupg/gpg-agent.conf
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf

# Restart GPG agent
gpgconf --kill gpg-agent
```

### Using GPG Suite (Alternative)

If you prefer a GUI approach:

1. Download GPG Suite from https://gpgtools.org/
2. Install the package
3. Use GPG Keychain Access to generate and manage keys
4. Export public key and add to GitHub as described above

## Troubleshooting

### GPG Agent Issues on macOS

```bash
# Restart GPG agent
gpgconf --kill all

# Check if agent is running
ps aux | grep gpg-agent
```

### Homebrew vs System GPG

```bash
# Check which GPG Git is using
git config --global gpg.program

# Force use of Homebrew GPG
git config --global gpg.program /opt/homebrew/bin/gpg
# or for Intel Macs:
git config --global gpg.program /usr/local/bin/gpg
```

### Keychain Integration

If using GPG Suite, you can integrate with macOS Keychain:

```bash
# Add to ~/.gnupg/gpg-agent.conf
use-standard-socket
enable-ssh-support
```
