#!/bin/bash
# Script to sign all commits in the repository
# This rewrites Git history to add signatures to all commits

echo "🔐 Starting to sign all commits in the repository..."
echo "⚠️  WARNING: This will rewrite Git history!"
echo ""

# Check if GPG is configured
SIGNING_KEY=$(git config --get user.signingkey)
if [ -z "$SIGNING_KEY" ]; then
    echo "❌ Error: No GPG signing key configured!"
    echo "Configure it with: git config user.signingkey YOUR_KEY_ID"
    exit 1
fi

echo "✅ Using GPG key: $SIGNING_KEY"
echo ""

# Get the root commit (first commit in the repository)
ROOT_COMMIT=$(git rev-list --max-parents=0 HEAD)
echo "📍 Root commit: $ROOT_COMMIT"

# Count total commits
TOTAL_COMMITS=$(git rev-list --count HEAD)
echo "📊 Total commits to sign: $TOTAL_COMMITS"
echo ""

echo "🚀 Starting the signing process..."
echo "   This may take a few minutes depending on repository size..."
echo ""

# Use git filter-branch to sign all commits
git filter-branch -f --commit-filter '
    if [ "$GIT_COMMIT" = "'$ROOT_COMMIT'" ]; then
        # For the root commit, we need to handle it specially
        git commit-tree -S "$@"
    else
        # For all other commits
        git commit-tree -S "$@"
    fi
' -- --all

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ SUCCESS: All commits have been signed!"
    echo ""
    echo "📋 Next steps:"
    echo "   1. Verify the signatures: git log --show-signature --oneline"
    echo "   2. If everything looks good, force push: git push --force-with-lease origin main"
    echo "   3. Inform collaborators about the history rewrite"
    echo ""
    echo "⚠️  Note: You'll need to force push because history was rewritten"
else
    echo ""
    echo "❌ ERROR: Failed to sign commits!"
    echo "   You can restore from backup: git checkout backup-before-signing"
    exit 1
fi
