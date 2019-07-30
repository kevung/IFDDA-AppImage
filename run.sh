# download latest IFDDA version
clone(){
	git clone https://github.com/pchaumet/IF-DDA.git
}

# install
install(){
	cd IF-DDA
	qmake-qt4
	make
	make install
	cd ..
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
	./linuxdeploy-x86_64.AppImage --appdir=AppDir \
		-e IF-DDA/cdm/cdm \
		-d ./ifdda.desktop \
		-i ./postmanpat.png \
		--output appimage
}

clean(){
	rm -rf IF-DDA
	rm *.AppImage
}

###########
# clone
# install
# get_appimages
make_appimage
# clean
