#!/bin/bash

# AI CLI AutoSave - Example aliases
# Add these to your ~/.bashrc, ~/.zshrc, or similar shell config

# Basic aliases
alias claude-save='ai-autosave claude'
alias gemini-save='ai-autosave gemini'
alias sgpt-save='ai-autosave sgpt'

# Quick shortcuts
alias cs='ai-autosave -s claude'      # Silent Claude
alias gs='ai-autosave -s gemini'      # Silent Gemini
alias cl='ai-autosave -d logs/ claude'  # Claude with custom log dir

# Advanced usage
alias claude-backup='ai-autosave -m script -i 30 claude'  # 30-second backups
alias claude-work='ai-autosave -d ~/work-logs/ claude'     # Work-specific logs

# View logs quickly
alias show-logs='ls -la .ai-cli-log/'
alias latest-log='ls -t .ai-cli-log/*.txt | head -1 | xargs cat'
alias search-logs='grep -r "$1" .ai-cli-log/'

# Functions for more complex operations
find-conversation() {
    if [ $# -eq 0 ]; then
        echo "Usage: find-conversation <search-term>"
        return 1
    fi
    grep -r "$1" .ai-cli-log/ --color=always
}

backup-logs() {
    local backup_dir="ai-logs-backup-$(date +%Y%m%d)"
    cp -r .ai-cli-log "$backup_dir"
    echo "Logs backed up to $backup_dir"
}

# Usage examples:
# source examples/aliases.sh
# claude-save                    # Start Claude with auto-save
# find-conversation "react"      # Search for React discussions
# backup-logs                    # Backup all conversations