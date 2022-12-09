#make
read -t 2 -p "Install dependencies? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    #install dependencies
    #rust
    curl https://sh.rustup.rs -sSf | sh
    #gtk
    sudo apt install glib-compile-resources libsdl-pango-dev libgtk-3-dev
fi

mkdir -p popslice_1.0-1_amd64/usr/bin
mkdir -p popslice_1.0-1_amd64/usr/share/applications
mkdir -p popslice_1.0-1_amd64/usr/share/pixmaps

cp ./target/release/popsicle-gtk popslice_1.0-1_amd64/usr/bin
cp ./pack-files/com.system76.popsicle.desktop popslice_1.0-1_amd64/usr/share/applications
cp ./pack-files/pop-drac.svg popslice_1.0-1_amd64/usr/share/pixmaps

mkdir -p popslice_1.0-1_amd64/DEBIAN
filename="./popslice_1.0-1_amd64/DEBIAN/control"

rm -f $filename
touch popslice_1.0-1_amd64/DEBIAN/control

echo "Package: popslice-gtk" >>$filename
echo "Version: 1.3.0" >>$filename
echo "Architecture: amd64" >>$filename
echo "Maintainer: Jeremy Soller <jeremy@system76.com>" >>$filename
echo "Description: USB Flasher" >>$filename

dpkg-deb --build --root-owner-group popslice_1.0-1_amd64
dpkg-name popslice_1.0-1_amd64.deb
