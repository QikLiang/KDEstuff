#!/bin/bash

#copy files to themes folder
mkdir /usr/share/sddm/themes/dollars
cp ./* /usr/share/sddm/themes/dollars

#change theme settings
if [ "$(grep --count Current /etc/sddm.conf)" -eq 1 ]; then
    #if setting already exist, change it
    sed -i 's/Current=.*$/Current=dollars$' /etc/sddm.conf
else #if setting doesn't exist yet, append to end of file
    echo '[Theme]' >> /etc/sddm.conf
    echo 'Current=dollars' >> /etc/sddm.conf
fi
