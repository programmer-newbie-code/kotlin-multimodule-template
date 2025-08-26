# PowerShell script to check signature status of all commits
Write-Host "🔍 Checking signature status of all commits..." -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Gray

# Get all commit hashes in reverse order (oldest first)
$commits = git log --format="%H" --reverse
$signedCount = 0
$unsignedCount = 0
$totalCount = 0

Write-Host "`n📋 COMMIT SIGNATURE ANALYSIS:`n" -ForegroundColor Yellow

foreach ($commit in $commits) {
    $totalCount++

    # Get commit info
    $commitShort = git log --format="%h" -n 1 $commit
    $commitMsg = git log --format="%s" -n 1 $commit
    $commitAuthor = git log --format="%an" -n 1 $commit
    $commitDate = git log --format="%ad" --date=short -n 1 $commit

    # Check if commit is signed
    $signatureCheck = git log --show-signature --format="" -n 1 $commit 2>&1 | Out-String

    if ($signatureCheck -match "Good signature|gpg:") {
        if ($signatureCheck -match "Good signature") {
            Write-Host "✅ $commitShort - $commitMsg" -ForegroundColor Green
            Write-Host "   👤 $commitAuthor ($commitDate) - VERIFIED SIGNATURE" -ForegroundColor Green
            $signedCount++
        } else {
            Write-Host "⚠️  $commitShort - $commitMsg" -ForegroundColor Yellow
            Write-Host "   👤 $commitAuthor ($commitDate) - SIGNED BUT UNVERIFIED" -ForegroundColor Yellow
            $signedCount++
        }
    } else {
        Write-Host "❌ $commitShort - $commitMsg" -ForegroundColor Red
        Write-Host "   👤 $commitAuthor ($commitDate) - NO SIGNATURE" -ForegroundColor Red
        $unsignedCount++
    }
    Write-Host ""
}

Write-Host "==================================================" -ForegroundColor Gray
Write-Host "📊 SUMMARY:" -ForegroundColor Cyan
Write-Host "   Total commits: $totalCount" -ForegroundColor White
Write-Host "   ✅ Signed commits: $signedCount" -ForegroundColor Green
Write-Host "   ❌ Unsigned commits: $unsignedCount" -ForegroundColor Red
$coverage = [math]::Round(($signedCount * 100 / $totalCount), 1)
Write-Host "   📈 Signature coverage: $coverage%" -ForegroundColor White
Write-Host "==================================================" -ForegroundColor Gray

if ($unsignedCount -gt 0) {
    Write-Host "`n⚠️  WARNING: $unsignedCount commits are not signed!" -ForegroundColor Yellow
    Write-Host "   This means they cannot be verified for authenticity." -ForegroundColor Yellow
    Write-Host "`n💡 Options to fix this:" -ForegroundColor Cyan
    Write-Host "   1. Leave as-is (historical commits often aren't signed)" -ForegroundColor White
    Write-Host "   2. Rewrite history with signed commits (advanced, risky)" -ForegroundColor White
    Write-Host "   3. Ensure all FUTURE commits are signed (recommended)" -ForegroundColor Green
}
