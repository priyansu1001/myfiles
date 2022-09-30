# my alias.

alias update='sudo apt-get update && sudo apt-get full-upgrade'
alias lofi='mpv https://youtu.be/jfKfPfyJRdk'
alias sakuralofi='cd Desktop/raja\ games/videos/ 
mpv cherry\ blossom\ lofi\ jazzhop\ chill\ mix_1080p.mp4 '
alias rm='rm -rf'
alias dhammapada='cd Desktop/raja\ games/books/
mpv The\ Dhammapada\ -\ Full\ Audiobook.mp3'
alias nlon='gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true'
alias nloff='gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false'
alias buddha1='cd Desktop/raja\ games/videos/folder/
mpv buddha.mp4 --loop --no-audio'
alias reboot='sudo systemctl reboot'
alias nvmaxpowermizer='nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=1''
alias buddha1='cd ~/Desktop/raja\ games/videos/folder/
mpv buddha.mp4 --loop --no-audio'
alias buddhalife='cd ~/Desktop/raja\ games/videos
mpv Buddha\ life.webm'
alias cpumaxpower='sudo cpupower frequency-set -g powersave -d 2.5G -u 3.1G && sudo cpupower frequency-set -g performance'
alias publicip='curl https://ipinfo.io/ip'

#for flashing iso by cmd 
#sudo dd bs=4M if=Downloads/debian-live-11.4.0-amd64-gnome+nonfree.iso of=/dev/sdd oflag=sync status=progress


#alias spotify='spotify --no-zygote'
#alias myspotify='LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify'
#alias minimize,maximize,close='gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close,' '
