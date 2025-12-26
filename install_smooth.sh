#!/bin/bash
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Mitsugen: Smooth Installer ===${NC}"

# 1. Check for Python 3.10+
if ! command -v python3 &> /dev/null; then
    echo "Python 3 could not be found. Please install python3."
    exit 1
fi

# 2. Create Virtual Environment
VENV_DIR=".venv"
if [ ! -d "$VENV_DIR" ]; then
    echo -e "${GREEN}Creating virtual environment in $VENV_DIR...${NC}"
    python3 -m venv "$VENV_DIR"
else
    echo -e "${BLUE}$VENV_DIR already exists. Skipping creation.${NC}"
fi

# 3. Activate and Install
echo -e "${GREEN}Installing dependencies (this might take a moment)...${NC}"
source "$VENV_DIR/bin/activate"

# Upgrade pip first
pip install --upgrade pip

# Install the project in editable mode
pip install -e .

echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo -e "${BLUE}To run Mitsugen, simply use:${NC}"
echo -e "  ${GREEN}source .venv/bin/activate && mitsugen --help${NC}"
echo ""
echo -e "${BLUE}Or use the helper command:${NC}"
echo -e "  ${GREEN}./run.sh --ui${NC}"

# Create run.sh helper
cat > run.sh <<EOL
#!/bin/bash
source .venv/bin/activate
mitsugen "\$@"
EOL
chmod +x run.sh

echo ""
echo -e "${BLUE}Created 'run.sh' for your convenience.${NC}"
