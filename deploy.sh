#!/bin/bash

# Twitter Follower Bot Website - Quick Deploy Script
# This script helps you deploy the website to GitHub Pages

echo "🚀 Twitter Follower Bot Website - Deployment Script"
echo "=================================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

echo "✅ Git is installed"
echo ""

# Get GitHub username
read -p "Enter your GitHub username: " github_username

if [ -z "$github_username" ]; then
    echo "❌ GitHub username cannot be empty"
    exit 1
fi

# Get repository name
read -p "Enter repository name (default: twitter-follower-bot): " repo_name
repo_name=${repo_name:-twitter-follower-bot}

echo ""
echo "📝 Configuration:"
echo "   GitHub Username: $github_username"
echo "   Repository Name: $repo_name"
echo "   Your site will be: https://$github_username.github.io/$repo_name/"
echo ""

read -p "Is this correct? (y/n): " confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "❌ Deployment cancelled"
    exit 1
fi

echo ""
echo "🔄 Updating URLs in files..."

# Update URLs in index.html
sed -i.bak "s|https://yourusername.github.io/twitter-follower-bot/|https://$github_username.github.io/$repo_name/|g" index.html

# Update URLs in README.md
sed -i.bak "s|yourusername|$github_username|g" README.md
sed -i.bak "s|twitter-follower-bot|$repo_name|g" README.md

# Update URLs in sitemap.xml
sed -i.bak "s|yourusername|$github_username|g" sitemap.xml
sed -i.bak "s|twitter-follower-bot|$repo_name|g" sitemap.xml

# Update URLs in robots.txt
sed -i.bak "s|yourusername|$github_username|g" robots.txt
sed -i.bak "s|twitter-follower-bot|$repo_name|g" robots.txt

# Remove backup files
rm -f *.bak

echo "✅ URLs updated successfully"
echo ""

# Initialize git if not already done
if [ ! -d .git ]; then
    echo "🔧 Initializing Git repository..."
    git init
    git config user.email "support@appilot.app"
    git config user.name "Appilot"
fi

# Add and commit all files
echo "📦 Staging files..."
git add .

echo "💾 Creating commit..."
git commit -m "Deploy Twitter Follower Bot website"

# Set up remote
echo "🔗 Setting up remote repository..."
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$github_username/$repo_name.git"

# Rename branch to main if needed
git branch -M main

echo ""
echo "✨ Setup complete!"
echo ""
echo "📋 Next steps:"
echo ""
echo "1. Create a new repository on GitHub:"
echo "   Go to: https://github.com/new"
echo "   Name: $repo_name"
echo "   Visibility: Public"
echo "   DO NOT initialize with README"
echo ""
echo "2. Push your code:"
echo "   Run: git push -u origin main"
echo ""
echo "3. Enable GitHub Pages:"
echo "   Go to: https://github.com/$github_username/$repo_name/settings/pages"
echo "   Source: Deploy from branch 'main' / folder '/ (root)'"
echo ""
echo "4. Your website will be live at:"
echo "   https://$github_username.github.io/$repo_name/"
echo ""
echo "📖 For detailed instructions, see DEPLOYMENT.md"
echo ""

read -p "Do you want to push to GitHub now? (y/n): " push_now

if [ "$push_now" = "y" ] || [ "$push_now" = "Y" ]; then
    echo ""
    echo "🚀 Pushing to GitHub..."
    echo "Note: You may need to enter your GitHub username and Personal Access Token"
    echo ""
    git push -u origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "🎉 Successfully pushed to GitHub!"
        echo ""
        echo "Now enable GitHub Pages at:"
        echo "https://github.com/$github_username/$repo_name/settings/pages"
    else
        echo ""
        echo "⚠️  Push failed. Please follow the manual instructions in DEPLOYMENT.md"
    fi
else
    echo ""
    echo "👍 You can push manually later with:"
    echo "   git push -u origin main"
fi

echo ""
echo "✅ Done!"
