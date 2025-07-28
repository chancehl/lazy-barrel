# Barrel

A simple Python utility that creates barrel files for JavaScript/TypeScript projects.

## What is a Barrel File?

A barrel file is an index file that re-exports multiple modules from a directory, making it easier to import multiple items from a single location. Instead of importing from multiple files:

```javascript
import { ComponentA } from './components/ComponentA';
import { ComponentB } from './components/ComponentB';
import { ComponentC } from './components/ComponentC';
```

You can import from a single barrel file:

```javascript
import { ComponentA, ComponentB, ComponentC } from './components';
```

## Usage

```bash
python main.py -d <directory> -o <output_file>
```

### Parameters

- `-d, --directory`: The directory containing the files you want to export
- `-o, --output`: The output file path where the barrel file will be created

### Example

```bash
python main.py -d ./src/components -o ./src/components/index.ts
```

This will scan all files in the `./src/components` directory and create an `index.ts` file with export statements like:

```typescript
export * from './ComponentA'
export * from './ComponentB'
export * from './ComponentC'
```

## How it Works

1. The script takes a directory path and scans all files in that directory
2. For each file, it generates an export statement that removes the file extension
3. All export statements are written to the specified output file
4. The script reports how many files were processed

## Development Setup

### Setting up Virtual Environment

1. Create a virtual environment:
```bash
python -m venv .venv
```

2. Activate the virtual environment:
```bash
# On macOS/Linux
source .venv/bin/activate

# On Windows
.venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. To deactivate the virtual environment when done:
```bash
deactivate
```

### Building Standalone Executable

This project includes PyInstaller configuration to create a standalone executable:

1. Make sure your virtual environment is activated and dependencies are installed
2. Build the executable:
```bash
pyinstaller barrel.spec
```

3. The executable will be created in the `dist/` directory
4. You can then run the executable directly without Python:
```bash
# On macOS/Linux
./dist/barrel -d ./src/components -o ./src/components/index.ts

# On Windows
dist\barrel.exe -d ./src/components -o ./src/components/index.ts
```

## Requirements

- Python 3.x
- virtualenv (for isolated development environment)
- PyInstaller (for creating standalone executables)

## Notes

- The script automatically removes file extensions from the export statements
- All files in the specified directory will be included in the barrel file
- Make sure the output file path is accessible and writable
