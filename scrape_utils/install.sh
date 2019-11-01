#!/bin/bash 

# Used for installing all dependencies
# Call with sudo

# install anaconda
curl -O https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
# might need to pipe 'yes' here...
bash Anaconda3-2019.03-Linux-x86_64.sh
# check if there is some user interaction needed...

# install python requirements from pip
pip install -r requirements.txt

# install R requirements
Rscript -e ./requirements_R.R

# install chrome
sudo curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
sudo echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
sudo apt-get -y update
sudo apt-get -y install google-chrome-stable

# get chromedriver
wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip
unzip chromedriver_linux64.zip

# move chromedriver to install path
mv chromedriver /usr/bin/chromedriver
chown root:root /usr/bin/chromedriver
chmod +x /usr/bin/chromedriver
