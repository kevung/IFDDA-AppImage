# Build AppImage form IFDDA sources
# Function on x64 architectures

# download latest IFDDA version
clone(){
	git clone https://github.com/pchaumet/IF-DDA.git
}

# install
install(){
	cd IF-DDA
	git checkout fftw
	# git checkout hdf5fftw
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
		--library /usr/lib/libm.so.6 \
		--library /usr/lib/gtk-2.0/modules/libcanberra-gtk-module.so \
		--library /usr/lib/libicui18n.so.64 \
		--output appimage
}

# create IFDDA AppImage
make_appimage_hdf5(){
	./linuxdeploy-x86_64.AppImage --appdir=AppDir \
		-e IF-DDA/cdm/cdm \
		-d ./ifdda.desktop \
		-i ./postmanpat.png \
		--library /usr/lib/libc.so.6 \ #causes segmentation fault
		--library /usr/lib/libm.so.6 \
		--library /usr/lib/gtk-2.0/modules/libcanberra-gtk-module.so \
		--library /usr/lib/libicui18n.so.64 \
		--output appimage
}

clean(){
	rm -rf IF-DDA
	rm *.AppImage
	rm -rf AppDir
}

###########
clean
clone
install
get_appimages
make_appimage
# make_appimage_hdf5
