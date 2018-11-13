#!/bin/bash

# OS detection
osdetect=$(uname)
file_path="unknown"
if [[ "$osdetect" == 'Darwin' ]]; then
  file_path="/Library/Fonts/"
elif [[ "$osdetect" == 'Linux' ]]; then
  if [[ -d /usr/local/share/fonts/ ]]; then # Debian/Ubuntu and others.
    file_path="/usr/local/share/fonts/"
  elif [[ -d /usr/share/fonts/ ]]; then # OpenSUSE, Arch and other distros using this directory structure
    sudo mkdir -p /usr/share/fonts/google/
    file_path="/usr/share/fonts/google/"
  else # Fallback to installing fonts locally to the user, this is a safe bet, as several distros use this location.
    mkdir -p ~/.fonts
    file_path="~/.fonts/"
  fi
fi

clear
echo "Installing all Cadson Demak's (Google 13+1 Thai Fonts) onto your System"
echo "Downloading the fonts..."
mkdir -p tmp/download tmp/fonts
curl -q -o "./tmp/download/#1.zip" -LO https://github.com/cadsondemak/\{Charm,Bai-Jamjuree,Niramit,Srisakdi,Fah-Kwang,Chakra-Petch,Thasadith,Sarabun,Krub,Kodchasan,K2D,Koho,Mali,Charmonman\}/archive/master.zip 
echo "Extracting the fonts..."
find tmp/download -name '*.zip' -exec sh -c 'unzip -q -d `dirname {}` {} "*.ttf"' ';'
#find tmp/download -type f -name "*.ttf" -exec cp {} tmp/fonts \;
# Install to system
sudo find tmp/download -type f -name "*.ttf" -exec cp {} $file_path \;

# echo "Fonts installed; Cleaning up files..."
echo "Cleaning up files..."
rm -rf tmp/download
rm -rf tmp/fonts
echo "All done! All Google 13+1 Thai Fonts installed."