FROM scratch
MAINTAINER Denys Vitali <denys@denv.it>
ADD ArchLinuxARM.tar.xz /
COPY qemu-aarch64-static /usr/bin/qemu-aarch64-static
RUN pacman -Syu --needed --noconfirm lightdm \
lightdm-gtk-greeter \
xf86-video-fbdev \
binutils \
make \
noto-fonts \
sudo \
git \
gcc \
xorg-xinit \
xorg-server \
onboard \
bluez \
bluez-tools \
bluez-utils \
openbox \
sudo \
kitty \
netctl \
wpa_supplicant \
dhcpcd \
dialog \
networkmanager
RUN systemctl enable NetworkManager
RUN systemctl enable lightdm
RUN systemctl enable bluetooth
RUN systemctl enable dhcpcd
RUN sed -i 's/#keyboard=/keyboard=onboard/' /etc/lightdm/lightdm-gtk-greeter.conf
RUN mkdir -p /etc/NetworkManager/system-connection/
COPY conf/networkmanager/connection/1.conf /etc/NetworkManager/system-connection/wifi-conn-1
COPY conf/systemd/services/btkbd.service /etc/systemd/system/btkbd.service
COPY conf/alarm/xinitrc /home/alarm/.xinitrc
RUN systemctl enable btkbd
