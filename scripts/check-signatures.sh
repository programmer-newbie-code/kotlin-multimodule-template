#!/bin/bash
# Script to check signature status of all commits
# This will show signed vs unsigned commits clearly

echo "🔍 Checking signature status of all commits..."
echo "=================================================="

# Get all commit hashes
commits=$(git log --format="%H" --reverse)

signed_count=0
unsigned_count=0
total_count=0

echo -e "\n📋 COMMIT SIGNATURE ANALYSIS:\n"

for commit in $commits; do
    total_count=$((total_count + 1))

    # Get commit info
    commit_short=$(git log --format="%h" -n 1 $commit)
    commit_msg=$(git log --format="%s" -n 1 $commit)
    commit_author=$(git log --format="%an" -n 1 $commit)
    commit_date=$(git log --format="%ad" --date=short -n 1 $commit)

    # Check if commit is signed
    signature_check=$(git log --show-signature --format="" -n 1 $commit 2>&1)

    if echo "$signature_check" | grep -q "Good signature\|gpg:"; then
        if echo "$signature_check" | grep -q "Good signature"; then
            echo "✅ $commit_short - $commit_msg"
            echo "   👤 $commit_author ($commit_date) - VERIFIED SIGNATURE"
            signed_count=$((signed_count + 1))
        else
            echo "⚠️  $commit_short - $commit_msg"
            echo "   👤 $commit_author ($commit_date) - SIGNED BUT UNVERIFIED"
            signed_count=$((signed_count + 1))
        fi
    else
        echo "❌ $commit_short - $commit_msg"
        echo "   👤 $commit_author ($commit_date) - NO SIGNATURE"
        unsigned_count=$((unsigned_count + 1))
    fi
    echo ""
done

echo "=================================================="
echo "📊 SUMMARY:"
echo "   Total commits: $total_count"
echo "   ✅ Signed commits: $signed_count"
echo "   ❌ Unsigned commits: $unsigned_count"
echo "   📈 Signature coverage: $(( signed_count * 100 / total_count ))%"
echo "=================================================="

if [ $unsigned_count -gt 0 ]; then
    echo ""
    echo "⚠️  WARNING: $unsigned_count commits are not signed!"
    echo "   This means they cannot be verified for authenticity."
    echo ""
    echo "💡 Options to fix this:"
    echo "   1. Leave as-is (historical commits often aren't signed)"
    echo "   2. Rewrite history with signed commits (advanced, risky)"
    echo "   3. Ensure all FUTURE commits are signed (recommended)"
fi
