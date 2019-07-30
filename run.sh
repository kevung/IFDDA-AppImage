# download latest IFDDA version
clone(){
	git clone https://github.com/pchaumet/IF-DDA.git
}

# install
install(){
	qmake-qt4
	make
	make install
}

# download AppImages tools
get_appimages(){
	wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
		wget https://github.com/linuxdeploy/linuxdeploy-plugin-appimage/releases/download/continuous/linuxdeploy-plugin-appimage-x86_64.AppImage
		chmod +x linuxdeploy-x86_64.AppImage
		chmod +x linuxdeploy-plugin-appimage-x86_64.AppImage
}

# create IFDDA AppImage
make_appimage(){
	./linuxdeploy-x86_64.AppImage --appdir=AppDir -e cdm/cdm -d ./ifdda.desktop -i ./postmanpat.png --output appimage
}

###########
clone
install
get_appimages
make_appimage
