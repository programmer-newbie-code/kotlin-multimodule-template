# Kotlin Multimodule Template Customization Script (PowerShell)
# This script helps you quickly customize the template for your project

param(
    [string]$ProjectName,
    [string]$OrganizationDomain,
    [string]$GitHubOrg
)

Write-Host "Kotlin Multimodule Template Customization" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green
Write-Host ""

# Get user input if not provided as parameters
if (-not $ProjectName) {
    $ProjectName = Read-Host "Enter your project name (e.g., my-awesome-project)"
}
if (-not $OrganizationDomain) {
    $OrganizationDomain = Read-Host "Enter your organization domain (e.g., com.mycompany)"
}
if (-not $GitHubOrg) {
    $GitHubOrg = Read-Host "Enter your GitHub organization/username"
}

# Validate inputs
if (-not $ProjectName -or -not $OrganizationDomain -or -not $GitHubOrg) {
    Write-Host "Error: All fields are required" -ForegroundColor Red
    exit 1
}

# Convert project name to appropriate formats
$ProjectNameKebab = $ProjectName.ToLower() -replace '[^a-z0-9]', '-' -replace '--+', '-' -replace '^-|-$', ''
$ProjectNameWords = $ProjectName -replace '[^a-zA-Z0-9]', ' '
$ProjectNameCamel = (Get-Culture).TextInfo.ToTitleCase($ProjectNameWords) -replace ' ', ''
$PackageName = "$OrganizationDomain.$ProjectNameKebab"
$PackagePath = $PackageName -replace '\.', '/'

Write-Host ""
Write-Host "Configuration Summary:" -ForegroundColor Yellow
Write-Host "  Project Name: $ProjectName"
Write-Host "  Kebab Case: $ProjectNameKebab"
Write-Host "  Camel Case: $ProjectNameCamel"
Write-Host "  Package Name: $PackageName"
Write-Host "  GitHub Org: $GitHubOrg"
Write-Host ""

$Confirm = Read-Host "Continue with these settings? (y/N)"
if ($Confirm -ne "y" -and $Confirm -ne "Y") {
    Write-Host "Customization cancelled" -ForegroundColor Red
    exit 0
}

Write-Host ""
Write-Host "Starting customization..." -ForegroundColor Green

try {
    # Update settings.gradle
    Write-Host "Updating settings.gradle..."
    (Get-Content "settings.gradle") -replace "kotlin-multimodule-template", $ProjectNameKebab | Set-Content "settings.gradle"

    # Update root build.gradle
    Write-Host "Updating root build.gradle..."
    (Get-Content "build.gradle") -replace "io\.programmernewbie\.template", $PackageName | Set-Content "build.gradle"
    (Get-Content "build.gradle") -replace "programmer-newbie-code/kotlin-multimodule-template", "$GitHubOrg/$ProjectNameKebab" | Set-Content "build.gradle"

    # Create new package structure
    Write-Host "Creating new package structure..."
    $OldPackagePath = "io/programmernewbie/template"

    # Service module
    $ServiceNewPath = "service-module/src/main/kotlin/$PackagePath/service"
    New-Item -ItemType Directory -Path $ServiceNewPath -Force | Out-Null
    if (Test-Path "service-module/src/main/kotlin/$OldPackagePath/service") {
        Copy-Item "service-module/src/main/kotlin/$OldPackagePath/service/*" $ServiceNewPath -Force -ErrorAction SilentlyContinue
    }

    # SpringBoot application
    $AppNewPath = "springboot-application/src/main/kotlin/$PackagePath"
    $ControllerNewPath = "$AppNewPath/controller"
    New-Item -ItemType Directory -Path $AppNewPath -Force | Out-Null
    New-Item -ItemType Directory -Path $ControllerNewPath -Force | Out-Null

    if (Test-Path "springboot-application/src/main/kotlin/$OldPackagePath") {
        Copy-Item "springboot-application/src/main/kotlin/$OldPackagePath/*" $AppNewPath -Force -ErrorAction SilentlyContinue
        if (Test-Path "springboot-application/src/main/kotlin/$OldPackagePath/controller") {
            Copy-Item "springboot-application/src/main/kotlin/$OldPackagePath/controller/*" $ControllerNewPath -Force -ErrorAction SilentlyContinue
        }
    }

    # Update package declarations in Kotlin files
    Write-Host "Updating package declarations..."
    Get-ChildItem -Path . -Filter "*.kt" -Recurse | ForEach-Object {
        (Get-Content $_.FullName) -replace "package io\.programmernewbie\.template", "package $PackageName" | Set-Content $_.FullName
        (Get-Content $_.FullName) -replace "import io\.programmernewbie\.template", "import $PackageName" | Set-Content $_.FullName
        (Get-Content $_.FullName) -replace "`"io\.programmernewbie\.template\.service`"", "`"$PackageName.service`"" | Set-Content $_.FullName
        (Get-Content $_.FullName) -replace "`"io\.programmernewbie\.template`"", "`"$PackageName`"" | Set-Content $_.FullName
    }

    # Rename main application class
    $OldAppFile = "springboot-application/src/main/kotlin/$PackagePath/KotlinMultimoduleTemplateApplication.kt"
    $NewAppFile = "springboot-application/src/main/kotlin/$PackagePath/${ProjectNameCamel}Application.kt"

    if (Test-Path $OldAppFile) {
        Move-Item $OldAppFile $NewAppFile -Force
        (Get-Content $NewAppFile) -replace "KotlinMultimoduleTemplateApplication", "${ProjectNameCamel}Application" | Set-Content $NewAppFile
    }

    # Remove old package directories
    Write-Host "Cleaning up old package structure..."
    Remove-Item "service-module/src/main/kotlin/$OldPackagePath" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "springboot-application/src/main/kotlin/$OldPackagePath" -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host ""
    Write-Host "Customization completed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Build the project: ./gradlew build"
    Write-Host "2. Run the application: ./gradlew :springboot-application:bootRun"
    Write-Host "3. Test the endpoints: curl http://localhost:8080/api/example/health"
    Write-Host "4. Start building your application!"
    Write-Host ""
    Write-Host "See TEMPLATE_SETUP.md for detailed customization guide"

} catch {
    $errorMessage = $_.Exception.Message
    Write-Host "Error during customization: $errorMessage" -ForegroundColor Red
    exit 1
}
