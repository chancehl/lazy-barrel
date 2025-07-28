# Barrel - Makefile for development and build tasks

# Variables
PYTHON = python3
VENV_DIR = .venv
VENV_ACTIVATE = $(VENV_DIR)/bin/activate
PIP = $(VENV_DIR)/bin/pip
PYINSTALLER = $(VENV_DIR)/bin/pyinstaller

# Default target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  setup     - Create virtual environment and install dependencies"
	@echo "  build     - Build standalone executable with PyInstaller"
	@echo "  clean     - Remove build artifacts and cache files"
	@echo "  clean-all - Remove build artifacts, cache files, and virtual environment"
	@echo "  dev       - Quick development setup (setup + activate instructions)"
	@echo "  install   - Install executable globally (requires sudo on macOS/Linux)"
	@echo "  help      - Show this help message"

# Create virtual environment and install dependencies
.PHONY: setup
setup:
	@echo "Creating virtual environment..."
	$(PYTHON) -m venv $(VENV_DIR)
	@echo "Installing dependencies..."
	$(PIP) install -r requirements.txt
	@echo "Setup complete! Run 'source $(VENV_ACTIVATE)' to activate the environment."

# Build executable
.PHONY: build
build: $(VENV_DIR)
	@echo "Building executable with PyInstaller..."
	$(PYINSTALLER) barrel.spec
	@echo "Build complete! Executable created in dist/barrel"

# Clean build artifacts
.PHONY: clean
clean:
	@echo "Cleaning build artifacts..."
	rm -rf build/
	rm -rf dist/
	rm -rf *.spec~
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	@echo "Clean complete!"

# Clean everything including virtual environment
.PHONY: clean-all
clean-all: clean
	@echo "Removing virtual environment..."
	rm -rf $(VENV_DIR)
	@echo "Full clean complete!"

# Development setup with activation reminder
.PHONY: dev
dev: setup
	@echo ""
	@echo "Development environment ready!"
	@echo "To activate the virtual environment, run:"
	@echo "  source $(VENV_ACTIVATE)"
	@echo ""
	@echo "To build the executable, run:"
	@echo "  make build"

# Install executable globally
.PHONY: install
install: build
	@echo "Installing barrel executable globally..."
	@if [ "$$(uname)" = "Darwin" ] || [ "$$(uname)" = "Linux" ]; then \
		echo "Installing to /usr/local/bin/ (requires sudo)..."; \
		sudo cp dist/barrel /usr/local/bin/barrel; \
		sudo chmod +x /usr/local/bin/barrel; \
		echo "Installation complete! You can now run 'barrel' from anywhere."; \
	else \
		echo "For Windows, manually copy dist/barrel.exe to a directory in your PATH"; \
		echo "Common locations: C:\\Windows\\System32\\ or create a bin folder in your user directory"; \
	fi

# Ensure virtual environment exists
$(VENV_DIR):
	@echo "Virtual environment not found. Run 'make setup' first."
	@exit 1
