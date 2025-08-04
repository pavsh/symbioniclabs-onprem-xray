#!/bin/bash
echo "Setting up git repository..."

# Initialize git
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Complete n8n + Ollama + Qdrant AI stack"

# Add remote (replace with your repo URL)
git remote add origin https://github.com/pavsh/symbioniclabs-onprem-xray.git

# Push to GitHub
git branch -M main
git push -u origin main

echo "Repository setup complete!"
