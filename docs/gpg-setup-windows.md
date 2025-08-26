# GPG Setup for Signed Commits - Windows Guide

## Quick Setup via Windows Terminal (Recommended)

### Step 1: Install GPG4Win via Winget

```powershell
# Install GPG4Win using Windows Package Manager
winget install GnuPG.Gpg4win
```

**Alternative package managers:**

```powershell
# Using Chocolatey (if you have it)
choco install gpg4win

# Using Scoop (if you have it)  
scoop install gpg4win
```

### Step 2: Generate GPG Key

```powershell
# Generate a new GPG key (use full path initially)
& "C:\Program Files (x86)\GnuPG\bin\gpg.exe" --full-generate-key
```

**When prompted, choose:**

- Key type: `1` (RSA and RSA)
- Key size: `4096`
- Key validity: `0` (key does not expire, or choose a specific time)
- Real name: `Your Full Name` (use your real name)
- Email: `your-github-email@example.com` (use your GitHub email)
- Comment: Leave blank or add a comment
- Passphrase: Choose a strong passphrase (remember this!)

### Step 3: Get Your Key ID

```powershell
& "C:\Program Files (x86)\GnuPG\bin\gpg.exe" --list-secret-keys --keyid-format=long
```

Look for output like:

```
sec   rsa4096/ABC123DEF456 2025-07-24 [SC]
      1234567890ABCDEF1234567890ABCDEF12345678
uid                 [ultimate] Your Name <your-email@example.com>
ssb   rsa4096/XYZ789 2025-07-24 [E]
```

The key ID is `ABC123DEF456` (after rsa4096/)

### Step 4: Export Your Public Key

```powershell
& "C:\Program Files (x86)\GnuPG\bin\gpg.exe" --armor --export YOUR_KEY_ID
```

(Replace YOUR_KEY_ID with your actual key ID)

Copy the entire output (including -----BEGIN PGP PUBLIC KEY BLOCK----- and -----END PGP PUBLIC KEY BLOCK-----)

### Step 5: Add Key to GitHub

1. Go to GitHub → Settings → SSH and GPG keys
2. Click "New GPG key"
3. Paste your public key
4. Click "Add GPG key"

### Step 6: Configure Git

```powershell
git config --global user.signingkey YOUR_KEY_ID
git config --global commit.gpgsign true
git config --global gpg.program "C:\Program Files (x86)\GnuPG\bin\gpg.exe"
```

### Step 7: Test Signed Commit

```powershell
cd C:\Users\Davit\Documents\Project\spring-bulk-layered-cache
git commit --allow-empty -m "test: verify GPG signed commits are working"

# Verify the signature
git log --show-signature -1
```

You should see output like:

```
gpg: Good signature from "Your Name <your-email@example.com>" [ultimate]
```

## Alternative: Manual Download

If winget is not available, download directly from https://www.gpg4win.org/
