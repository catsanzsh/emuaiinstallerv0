#!/bin/bash
# CATMEGACONNECTOR 0.A - The Ultimate devkitPro Installer
# Author: Catsan 🐾
# Installs GBA, NDS, 3DS, Wii, GameCube, and Switch SDKs in WSL2

set -e

echo "🧠 CATMEGACONNECTOR 0.A"
echo "=========================="
echo "📦 Loading DevKitPro Multiverse..."
echo "Supported Consoles:"
echo " 🟩 GBA  | 🟦 NDS  | 🔵 3DS"
echo " 🟨 Wii  | 🟥 GC   | 🟪 Switch"
echo "=========================="

# Step 1: Install base dependencies
echo "🔧 Step 1: Installing base dependencies..."
sudo apt update && sudo apt install -y git curl wget build-essential

# Step 2: Install devkitPro pacman
echo "🌐 Step 2: Installing devkitPro pacman..."
wget https://apt.devkitpro.org/install-devkitpro-pacman
chmod +x ./install-devkitpro-pacman
sudo ./install-devkitpro-pacman

# Step 3: Install all desired devkitPro packages
echo "📲 Step 3: Installing ALL devkitPro SDKs..."
sudo dkp-pacman -Sy
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

# Step 4: Set environment variables
echo "🛠️ Step 4: Setting environment variables..."
echo 'export DEVKITPRO=/opt/devkitpro' | sudo tee -a /etc/profile.d/devkitpro.sh
echo 'export PATH="$DEVKITPRO/devkitARM/bin:$DEVKITPRO/devkitA64/bin:$DEVKITPRO/devkitPPC/bin:$DEVKITPRO/tools/bin:$PATH"' | sudo tee -a /etc/profile.d/devkitpro.sh
source /etc/profile.d/devkitpro.sh

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
echo "💡 Environment variables have been set in /etc/profile.d/devkitpro.sh."
echo "   They will be sourced automatically in new shell sessions."
echo ""
echo "🐾 Built with love by Catsan & you."
