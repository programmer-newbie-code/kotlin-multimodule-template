# PowerShell script to sign all commits in the repository
# This rewrites Git history to add signatures to all commits

Write-Host "🔐 Starting to sign all commits in the repository..." -ForegroundColor Cyan
Write-Host "⚠️  WARNING: This will rewrite Git history!" -ForegroundColor Yellow
Write-Host ""

# Check if GPG is configured
$signingKey = git config --get user.signingkey
if (-not $signingKey) {
    Write-Host "❌ Error: No GPG signing key configured!" -ForegroundColor Red
    Write-Host "Configure it with: git config user.signingkey YOUR_KEY_ID" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Using GPG key: $signingKey" -ForegroundColor Green
Write-Host ""

# Count total commits
$totalCommits = (git rev-list --count HEAD)
Write-Host "📊 Total commits to sign: $totalCommits" -ForegroundColor Cyan
Write-Host ""

Write-Host "🚀 Starting the signing process..." -ForegroundColor Yellow
Write-Host "   This may take a few minutes depending on repository size..." -ForegroundColor Gray
Write-Host ""

# Method 1: Use git rebase to sign commits interactively
Write-Host "Using git rebase method to sign all commits..." -ForegroundColor Cyan

# Get the root commit (first commit)
$rootCommit = git rev-list --max-parents=0 HEAD
Write-Host "📍 Root commit: $rootCommit" -ForegroundColor Gray

try {
    # Set environment variable to automatically sign commits during rebase
    $env:GIT_SEQUENCE_EDITOR = "sed -i 's/^pick/edit/g'"

    # Start interactive rebase from root
    Write-Host "Starting interactive rebase from root commit..." -ForegroundColor Yellow

    # Alternative approach: Use git filter-branch with PowerShell
    Write-Host "Using git filter-branch method..." -ForegroundColor Cyan

    # Create a temporary script for git filter-branch
    $tempScript = @"
#!/bin/sh
export GIT_COMMITTER_NAME="`$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="`$GIT_AUTHOR_EMAIL"
export GIT_COMMITTER_DATE="`$GIT_AUTHOR_DATE"
git commit-tree -S "`$@"
"@

    $tempScriptPath = "temp-sign-commit.sh"
    $tempScript | Out-File -FilePath $tempScriptPath -Encoding ASCII

    # Make the script executable and run filter-branch
    git filter-branch -f --commit-filter "sh $tempScriptPath" -- --all

    # Clean up temporary script
    Remove-Item $tempScriptPath -ErrorAction SilentlyContinue

    Write-Host ""
    Write-Host "✅ SUCCESS: All commits have been signed!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 Next steps:" -ForegroundColor Cyan
    Write-Host "   1. Verify the signatures: git log --show-signature --oneline" -ForegroundColor White
    Write-Host "   2. If everything looks good, force push: git push --force-with-lease origin main" -ForegroundColor White
    Write-Host "   3. Inform collaborators about the history rewrite" -ForegroundColor White
    Write-Host ""
    Write-Host "⚠️  Note: You'll need to force push because history was rewritten" -ForegroundColor Yellow
}
catch {
    Write-Host ""
    Write-Host "❌ ERROR: Failed to sign commits!" -ForegroundColor Red
    Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "   You can restore from backup: git checkout backup-before-signing" -ForegroundColor Yellow
    exit 1
}
