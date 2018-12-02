#!/bin/bash

#zip folder into plasma package
zip -r dollars.plasma . > /dev/null
#install plasma package
plasmapkg2 -t lookandfeel -i dollars.plasma

#change lock screen settings
if [ -f ~/.config/kscreenlockerrc ] && [ "$(grep --count Theme ~/.config/kscreenlockerrc)" -eq 1 ]; then
    #if setting already exist, change it
    sed -i 's/Theme=.*$/Theme=drrr$/' ~/.config/kscreenlockerrc
else #if setting doesn't exist yet, append to end of file
    echo "" >> ~/.config/kscreenlockerrc
    echo '[Theme]' >> ~/.config/kscreenlockerrc
    echo 'Theme=drrr' >> ~/.config/kscreenlockerrc
fi

#change splash screen settings
if [ -f ~/.config/ksplashrc ] && [ "$(grep --count Theme ~/.config/ksplashrc)" -eq 1 ]; then
    #if setting already exist, change it
    sed -i 's/Theme=.*$/Theme=drrr$/' ~/.config/ksplashrc
else #if setting doesn't exist yet, append to end of file
    echo '[KSplash]' >> ~/.config/ksplashrc
    echo 'Engine=KSplashQML' >> ~/.config/ksplashrc
    echo 'Theme=drrr' >> ~/.config/ksplashrc
fi
