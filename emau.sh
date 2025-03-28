#!/bin/bash
# 🧙 CatTest 1.0 - Console DevKit Setup Wizard (Atari to PS5)
# Author: Catsan 🐾

set -e
clear

echo "🐾 Welcome to CatTest 1.0 – Your DevKit Wizard for:"
echo "🕹️ Atari → PS5 | Powered by WSL2 Linux"
echo "-----------------------------------------"

declare -A consoles
consoles=(
    ["Atari"]="Atari VCS (Linux)"
    ["NES"]="Nintendo Entertainment System"
    ["SNES"]="Super Nintendo"
    ["N64"]="Nintendo 64"
    ["GBA"]="Game Boy Advance"
    ["NDS"]="Nintendo DS"
    ["3DS"]="Nintendo 3DS"
    ["Switch"]="Nintendo Switch (homebrew)"
    ["PS1"]="PlayStation 1"
    ["PS2"]="PlayStation 2"
    ["PSP"]="PlayStation Portable"
    ["PSVita"]="PlayStation Vita"
    ["PS3"]="PlayStation 3 (limited)"
    ["PS4"]="PlayStation 4 (modded only)"
    ["PS5"]="PlayStation 5 (restricted access)"
)

echo "Select consoles to install (space-separated, or type 'all'):"
for c in "${!consoles[@]}"; do echo " - $c : ${consoles[$c]}"; done

read -p "🎮 Your selection: " selection

if [[ "$selection" == "all" ]]; then
    targets=("${!consoles[@]}")
else
    read -a targets <<< "$selection"
fi

echo "📦 Installing required base packages..."
sudo apt update
sudo apt install -y build-essential git curl wget cmake python3-pip \
    libsdl2-dev libgl1-mesa-dev gcc-multilib clang unzip zip pkg-config

for target in "${targets[@]}"; do
    echo "🛠️ Setting up for $target..."

    case $target in
        Atari)
            mkdir -p ~/dev/atari
            echo "✅ Atari is Linux-native. You’re good to go!"
            ;;

        NES)
            git clone https://github.com/pinobatch/nesdev-toolchain.git ~/dev/nes
            cd ~/dev/nes && make
            echo "✅ NES dev tools installed (asm6, ca65)"
            ;;

        SNES)
            git clone https://github.com/snesdev/snesdev.git ~/dev/snes
            cd ~/dev/snes && make
            echo "✅ SNES dev tools installed"
            ;;

        N64)
            git clone https://github.com/DragonMinded/libdragon.git ~/dev/n64
            cd ~/dev/n64 && make
            echo "✅ N64 dev with libdragon ready"
            ;;

        GBA|NDS|3DS|Switch)
            echo "📦 Installing DevKitPro for $target..."
            curl https://apt.devkitpro.org/install-devkitpro-pacman -O
            sudo bash install-devkitpro-pacman
            sudo dkp-pacman -Sy
            if [[ $target == "GBA" ]]; then
                sudo dkp-pacman -S gba-dev
            elif [[ $target == "NDS" ]]; then
                sudo dkp-pacman -S nds-dev
            elif [[ $target == "3DS" ]]; then
                sudo dkp-pacman -S 3ds-dev
            elif [[ $target == "Switch" ]]; then
                sudo dkp-pacman -S switch-dev
            fi
            ;;

        PS1)
            git clone https://github.com/Lameguy64/PSn00bSDK.git ~/dev/ps1
            cd ~/dev/ps1 && ./toolchain.sh
            echo "✅ PS1 toolchain installed (PSn00bSDK)"
            ;;

        PS2)
            git clone --recursive https://github.com/ps2dev/ps2dev ~/dev/ps2
            cd ~/dev/ps2 && ./install.sh
            echo "✅ PS2 SDK installed"
            ;;

        PSP)
            git clone https://github.com/pspdev/psptoolchain.git ~/dev/psp
            cd ~/dev/psp && ./toolchain.sh
            echo "✅ PSP toolchain installed"
            ;;

        PSVita)
            git clone https://github.com/vitasdk/vdpm.git ~/dev/vita
            cd ~/dev/vita && ./bootstrap-vitasdk.sh
            echo "✅ Vita SDK installed"
            ;;

        PS3)
            echo "⚠️ PS3 toolchain not fully supported. Check ps3toolchain on GitHub."
            ;;

        PS4|PS5)
            echo "🔐 $target requires official Sony SDK access or jailbroken devkit. Skipping..."
            ;;

        *)
            echo "❓ Unknown console: $target"
            ;;
    esac
done

echo ""
echo "✨ CatTest 1.0 complete! Console dev environments installed:"
for t in "${targets[@]}"; do echo " ✅ $t"; done
echo ""
echo "🐾 Have fun coding across time. – CatTest 1.0"
