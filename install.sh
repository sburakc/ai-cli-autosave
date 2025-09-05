#!/bin/bash

# AI CLI AutoSave Installation Script
# https://github.com/yourusername/ai-cli-autosave

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Installation directory
INSTALL_DIR="${HOME}/.local/bin"
REPO_URL="https://github.com/sburakc/ai-cli-autosave.git"

echo -e "${BLUE}==================================${NC}"
echo -e "${BLUE}   AI CLI AutoSave Installer${NC}"
echo -e "${BLUE}==================================${NC}"
echo

# Check for required commands
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}Error: $1 is required but not installed.${NC}"
        echo "Please install $1 and try again."
        exit 1
    fi
}

echo "Checking requirements..."
check_command git
check_command bash
echo -e "${GREEN}✓ All requirements met${NC}"
echo

# Create installation directory if needed
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Creating installation directory: $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR"
fi

# Check if already installed
if [ -f "$INSTALL_DIR/ai-autosave" ]; then
    echo -e "${YELLOW}AI CLI AutoSave is already installed.${NC}"
    read -p "Do you want to update it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
    rm -f "$INSTALL_DIR/ai-autosave"
fi

# Download the script
echo "Downloading AI CLI AutoSave..."
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Clone repository or download directly
if command -v curl &> /dev/null; then
    curl -sSL "https://raw.githubusercontent.com/sburakc/ai-cli-autosave/main/bin/ai-autosave" -o ai-autosave
elif command -v wget &> /dev/null; then
    wget -q "https://raw.githubusercontent.com/sburakc/ai-cli-autosave/main/bin/ai-autosave" -O ai-autosave
else
    git clone --depth 1 "$REPO_URL" .
    cp bin/ai-autosave ai-autosave
fi

# Make executable and install
chmod +x ai-autosave
mv ai-autosave "$INSTALL_DIR/"

echo -e "${GREEN}✓ AI CLI AutoSave installed successfully!${NC}"
echo

# Check if install directory is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo -e "${YELLOW}Warning: $INSTALL_DIR is not in your PATH.${NC}"
    echo
    echo "Add it to your PATH by adding this line to your ~/.bashrc or ~/.zshrc:"
    echo
    echo -e "${BLUE}export PATH=\"\$PATH:$INSTALL_DIR\"${NC}"
    echo
    echo "Or run this command now (temporary):"
    echo -e "${BLUE}export PATH=\"\$PATH:$INSTALL_DIR\"${NC}"
    echo
fi

# Clean up
cd - > /dev/null
rm -rf "$TEMP_DIR"

# Test installation
if command -v ai-autosave &> /dev/null; then
    echo -e "${GREEN}✓ Installation verified successfully!${NC}"
    echo
    echo "You can now use ai-autosave:"
    echo -e "${BLUE}  ai-autosave claude${NC}     # Start Claude with auto-save"
    echo -e "${BLUE}  ai-autosave gemini${NC}     # Start Gemini with auto-save"
    echo -e "${BLUE}  ai-autosave --help${NC}     # Show help"
else
    echo "To start using ai-autosave, run:"
    echo -e "${BLUE}  $INSTALL_DIR/ai-autosave claude${NC}"
fi

echo
echo -e "${GREEN}Happy coding! Never lose a conversation again! 🎉${NC}"