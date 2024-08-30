#!/bin/bash

# Your GitHub username
USERNAME="your_github_username"

# Use environment variable for GitHub token
TOKEN=$GITHUB_TOKEN

# Directory to store the mirrored repositories
BACKUP_DIR="$HOME/github-backup"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Fetch the list of all repositories
repos=$(curl -s -u $USERNAME:$TOKEN "https://api.github.com/user/repos?per_page=100&page=1" | jq -r '.[].ssh_url')

# Iterate through the list of repositories and mirror them
for repo in $repos; do
    repo_name=$(basename "$repo" .git)
    echo "Mirroring $repo_name..."

    git clone --mirror "$repo" "$BACKUP_DIR/$repo_name"
done

echo "All repositories have been mirrored to $BACKUP_DIR"
