#!/bin/bash


#----------------------SDDM theme-----------------------
#copy files to themes folder
cp -r dollars-sddm-theme /usr/share/sddm/theme/dollars

#change theme settings
if [ "$(grep --count Current /etc/sddm.conf)" -eq 1 ]; then
    #if setting already exist, change it
    sed -i 's/Current=.*$/Current=dollars$' /etc/sddm.conf
else #if setting doesn't exist yet, append to end of file
    echo '[Theme]' >> /etc/sddm.conf
    echo 'Current=dollars' >> /etc/sddm.conf
fi

#----------KDE plasma lock screen and splash------------

#zip folder into plasma package
zip -r dollars.plasma dollars.desktop > /dev/null
#install plasma package
plasmapkg2 -t lookandfeel -i dollars.plasma

#change lock screen settings
if [ "$(grep --count Theme ~/.config/kscreenlockerrc)" -eq 1 ]; then
    #if setting already exist, change it
    sed -i 's/Theme=.*$/Theme=drrr$' ~/.config/kscreenlockerrc
else #if setting doesn't exist yet, append to end of file
    echo '[Theme]' >> ~/.config/kscreenlockerrc
    echo 'Theme=drrr' >> ~/.config/kscreenlockerrc
fi
