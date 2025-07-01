# Notice

There are 2 branches, the `main` branch contains the experiment on the annotorius annotation library. The `major-refactor`
branch contains the features without annotation (user management, documents upload etc).

# Rails App Setup

## Prerequisites
- macOS, Linux, or WSL2 (for Windows)
- Git
- Build tools (Xcode Command Line Tools on macOS, build-essential on Ubuntu)

## Ruby Environment Setup

### 1. Install rbenv

**macOS (using Homebrew):**
```bash
brew install rbenv ruby-build
```
**Ubuntu**
```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```

Or follow the instructions here https://github.com/rbenv/rbenv

### 2. Use rbenv to install ruby 3.2.0
```bash
rbenv install 3.2.0  # Note: Ruby 8.0.2 doesn&#x27;t exist, using 3.2.0
rbenv global 3.2.0
```

### 3. Navigate to app root directory to install necessary packages
```bash
cd /path/to/app/
bundle
```

### 4. Run the application
```bash
foreman start -f Procfile.dev
```

### 5. Visit localhost:3000

