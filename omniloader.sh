#!/bin/bash
# CATMEGACONNECTOR 0.A - The Ultimate devkitPro Installer
# Author: Catsan 🐾
# Installs GBA, NDS, 3DS, Wii, GameCube, Switch SDKs in WSL2
set -e

echo "🧠 CATMEGACONNECTOR 0.A"
echo "=========================="
echo "📦 Loading DevKitPro Multiverse..."
echo "Supported Consoles:"
echo " 🟩 GBA  | 🟦 NDS  | 🔵 3DS"
echo " 🟨 Wii  | 🟥 GC   | 🟪 Switch"
echo "=========================="

echo "🔧 Step 1: Installing base dependencies..."
sudo apt update && sudo apt install -y git curl wget build-essential

echo "🌐 Step 2: Installing devkitPro pacman..."
curl -L https://apt.devkitpro.org/install-devkitpro-pacman | sudo bash
sudo dkp-pacman -Sy

echo "📲 Step 3: Installing ALL devkitPro SDKs..."
sudo dkp-pacman -S --noconfirm \
  devkitARM \
  devkitA64 \
  devkitPPC \
  gba-dev \
  nds-dev \
  3ds-dev \
  switch-dev \
  gamecube-dev \
  wii-dev \
  general-tools

echo ""
echo "🎉 INSTALL COMPLETE!"
echo "🚀 CATMEGACONNECTOR 0.A has connected your system to:"
echo " 🟩 GBA         → devkitARM"
echo " 🟦 NDS         → devkitARM"
echo " 🔵 3DS         → devkitARM"
echo " 🟥 GameCube    → devkitPPC"
echo " 🟨 Wii         → devkitPPC"
echo " 🟪 Switch      → devkitA64"
echo ""
echo "📂 Toolchains installed at: /opt/devkitpro/"
echo "💡 Tip: Add this to your ~/.bashrc or ~/.zshrc:"
echo '  export DEVKITPRO=/opt/devkitpro'
echo '  export PATH="$DEVKITPRO/devkitARM/bin:$DEVKITPRO/tools/bin:$PATH"'
echo ""
echo "🐾 Built with love by CatGPT & you."
