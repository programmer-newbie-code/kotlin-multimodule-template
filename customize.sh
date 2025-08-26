#!/bin/bash

# Kotlin Multimodule Template Customization Script
# This script helps you quickly customize the template for your project

set -e

echo "🚀 Kotlin Multimodule Template Customization"
echo "=============================================="

# Get user input
read -p "Enter your project name (e.g., my-awesome-project): " PROJECT_NAME
read -p "Enter your organization domain (e.g., com.mycompany): " ORGANIZATION_DOMAIN
read -p "Enter your GitHub organization/username: " GITHUB_ORG

# Validate inputs
if [[ -z "$PROJECT_NAME" || -z "$ORGANIZATION_DOMAIN" || -z "$GITHUB_ORG" ]]; then
    echo "❌ Error: All fields are required"
    exit 1
fi

# Convert project name to appropriate formats
PROJECT_NAME_KEBAB=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
PROJECT_NAME_CAMEL=$(echo "$PROJECT_NAME" | sed 's/[^a-zA-Z0-9]/ /g' | sed 's/\b\w/\U&/g' | sed 's/ //g')
PACKAGE_NAME="$ORGANIZATION_DOMAIN.$PROJECT_NAME_KEBAB"
PACKAGE_PATH=$(echo "$PACKAGE_NAME" | tr '.' '/')

echo ""
echo "📋 Configuration Summary:"
echo "  Project Name: $PROJECT_NAME"
echo "  Kebab Case: $PROJECT_NAME_KEBAB"
echo "  Camel Case: $PROJECT_NAME_CAMEL"
echo "  Package Name: $PACKAGE_NAME"
echo "  GitHub Org: $GITHUB_ORG"
echo ""

read -p "Continue with these settings? (y/N): " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo "❌ Customization cancelled"
    exit 0
fi

echo ""
echo "🔄 Starting customization..."

# Update settings.gradle
echo "📝 Updating settings.gradle..."
sed -i.bak "s/kotlin-multimodule-template/$PROJECT_NAME_KEBAB/g" settings.gradle

# Update root build.gradle
echo "📝 Updating root build.gradle..."
sed -i.bak "s/io\.programmernewbie\.template/$PACKAGE_NAME/g" build.gradle
sed -i.bak "s/programmer-newbie-code\/kotlin-multimodule-template/$GITHUB_ORG\/$PROJECT_NAME_KEBAB/g" build.gradle

# Update gradle.properties (no changes needed for basic setup)

# Create new package structure
echo "📁 Creating new package structure..."
OLD_PACKAGE_PATH="io/programmernewbie/template"

# Service module
mkdir -p "service-module/src/main/kotlin/$PACKAGE_PATH/service"
cp "service-module/src/main/kotlin/$OLD_PACKAGE_PATH/service/"* "service-module/src/main/kotlin/$PACKAGE_PATH/service/" 2>/dev/null || true

# SpringBoot application
mkdir -p "springboot-application/src/main/kotlin/$PACKAGE_PATH/controller"
cp "springboot-application/src/main/kotlin/$OLD_PACKAGE_PATH/"* "springboot-application/src/main/kotlin/$PACKAGE_PATH/" 2>/dev/null || true
cp "springboot-application/src/main/kotlin/$OLD_PACKAGE_PATH/controller/"* "springboot-application/src/main/kotlin/$PACKAGE_PATH/controller/" 2>/dev/null || true

# Update package declarations in Kotlin files
echo "📝 Updating package declarations..."
find . -name "*.kt" -type f -exec sed -i.bak "s/package io\.programmernewbie\.template/package $PACKAGE_NAME/g" {} \;
find . -name "*.kt" -type f -exec sed -i.bak "s/import io\.programmernewbie\.template/import $PACKAGE_NAME/g" {} \;

# Update scanBasePackages
find . -name "*.kt" -type f -exec sed -i.bak "s/\"io\.programmernewbie\.template\.service\"/\"$PACKAGE_NAME.service\"/g" {} \;
find . -name "*.kt" -type f -exec sed -i.bak "s/\"io\.programmernewbie\.template\"/\"$PACKAGE_NAME\"/g" {} \;

# Rename main application class
OLD_APP_FILE="springboot-application/src/main/kotlin/$PACKAGE_PATH/KotlinMultimoduleTemplateApplication.kt"
NEW_APP_FILE="springboot-application/src/main/kotlin/$PACKAGE_PATH/${PROJECT_NAME_CAMEL}Application.kt"

if [[ -f "$OLD_APP_FILE" ]]; then
    mv "$OLD_APP_FILE" "$NEW_APP_FILE"
    sed -i.bak "s/KotlinMultimoduleTemplateApplication/${PROJECT_NAME_CAMEL}Application/g" "$NEW_APP_FILE"
fi

# Remove old package directories
echo "🧹 Cleaning up old package structure..."
rm -rf "service-module/src/main/kotlin/$OLD_PACKAGE_PATH" 2>/dev/null || true
rm -rf "springboot-application/src/main/kotlin/$OLD_PACKAGE_PATH" 2>/dev/null || true

# Clean up backup files
find . -name "*.bak" -delete

echo ""
echo "✅ Customization completed successfully!"
echo ""
echo "🔧 Next steps:"
echo "1. Build the project: ./gradlew build"
echo "2. Run the application: ./gradlew :springboot-application:bootRun"
echo "3. Test the endpoints: curl http://localhost:8080/api/example/health"
echo "4. Start building your application!"
echo ""
echo "📚 See TEMPLATE_SETUP.md for detailed customization guide"
