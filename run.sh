# Build AppImage form IFDDA sources
# Function on x64 architectures
# BUG: hdf5 version does not work yet
# BUG2: adresse de la doc en dur donc pas incorporable
# ~BUG3: parametres par defauts a changer

# download latest IFDDA version

HDF5=0 #0->fftw 1->hdf5

clone(){
	git clone https://github.com/pchaumet/IF-DDA.git
}

# install
install(){
	cd IF-DDA
	if [[ $HDF5 == 1 ]]; then
		git checkout hdf5fftw
	else
		git checkout fftw
	fi;
	qmake-qt4
	make
	make install
	cd ..
}

# download AppImages tools
get_appimages(){
	wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
	wget https://github.com/linuxdeploy/linuxdeploy-plugin-appimage/releases/download/continuous/linuxdeploy-plugin-appimage-x86_64.AppImage
	# wget https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage
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
		--library /usr/lib/libicui18n.so.64 
	if [[ $HDF5 == 1 ]]; then
		./linuxdeploy-x86_64.AppImage --appdir=AppDir \
		-d ./ifdda.desktop \
		-i ./postmanpat.png \
			--library /usr/lib/libhdf5hl_fortran.so.100 
	fi;
	cp -r /usr/lib/qt4/plugins/sqldrivers \
		./AppDir/usr/bin
	./linuxdeploy-x86_64.AppImage --appdir=AppDir \
		-d ./ifdda.desktop \
		-i ./postmanpat.png \
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
