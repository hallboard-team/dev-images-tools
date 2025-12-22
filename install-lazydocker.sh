#!/usr/bin/env bash

set -e

echo "🚀 Installing LazyDocker (latest release)..."

# ------------------------------
# 1. Detect architecture
# ------------------------------
ARCH=$(uname -m)
if [[ "$ARCH" != "x86_64" ]]; then
  echo "❌ Unsupported architecture: $ARCH"
  echo "LazyDocker supports x86_64 only."
  exit 1
fi

# ------------------------------
# 2. Download latest release
# ------------------------------
echo "⬇️  Downloading LazyDocker archive..."
URL=$(curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest \
  | grep "browser_download_url.*Linux_x86_64.tar.gz" \
  | cut -d '"' -f 4)

wget -q --show-progress "$URL" -O lazydocker.tar.gz

# ------------------------------
# 3. Extract and install
# ------------------------------
echo "📦 Extracting..."
tar -xzf lazydocker.tar.gz
rm lazydocker.tar.gz

echo "📁 Moving binary to /usr/local/bin..."
sudo mv lazydocker /usr/local/bin/lazydocker
sudo chmod +x /usr/local/bin/lazydocker

# ------------------------------
# 4. Ensure PATH includes ~/.local/bin and /usr/local/bin
# ------------------------------
echo "🔧 Updating PATH for Bash and Zsh..."

# Add PATH to .bashrc
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

if ! grep -q 'export PATH="/usr/local/bin:$PATH"' ~/.bashrc 2>/dev/null; then
  echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
fi

# Add PATH to .zshrc
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

if ! grep -q 'export PATH="/usr/local/bin:$PATH"' ~/.zshrc 2>/dev/null; then
  echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
fi

# Add PATH to .profile (VS Code terminals)
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.profile 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.profile
fi

if ! grep -q 'export PATH="/usr/local/bin:$PATH"' ~/.profile 2>/dev/null; then
  echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.profile
fi

# ------------------------------
# 5. Test installation
# ------------------------------
echo "🧪 Testing LazyDocker installation..."

if lazydocker --version >/dev/null 2>&1; then
  echo "✅ LazyDocker installed successfully!"
else
  echo "⚠️ LazyDocker installed, but shell may need reload."
fi

echo ""
echo "🎉 Done! Start LazyDocker with: lazydocker"
echo "If inside VS Code, open a new terminal first."
