# Build AppImage form IFDDA sources
# Function on x64 architectures
# BUG: hdf5 version does not work yet
# BUG2: adresse de la doc en dur donc pas incorporable
# ~BUG3: parametres par defauts a changer

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
	cp -r /usr/lib/qt4/plugins/sqldrivers \
		./AppDir/usr/bin
	./linuxdeploy-x86_64.AppImage --appdir=AppDir \
		--output appimage
		# --library /usr/lib/libz.so.1 \
		# --library /usr/lib/librt.so.1 \
		# --library /usr/lib/libresolv.so.2 \
		# --library /usr/lib/libharfbuzz.so.0 \
		# --library /usr/lib/libfribidi.so.0 \
		# --library /usr/lib/libthai.so.0 \
		# --library /usr/lib/libexpat.so.1 \
		# --library /usr/lib/libuuid.so.1 \
		# --library /usr/lib/libstdc++.so.6 \
		# --library /usr/lib/libgcc_s.so.1 \
		# --library /usr/lib/libcom_err.so.2 \
		# --library /usr/lib/libkeyutils.so.1 \
		# --library /usr/lib/libGL.so.1 \
		# --library /usr/lib64/ld-linux-x86-64.so.2 \
		# --library /usr/lib/libSM.so.6 \
		# --library /usr/lib/libICE.so.6 \
		# --library /usr/lib/libgobject-2.0.so.0 \
		# --library /usr/lib/libglib-2.0.so.0 \
		# --library /usr/lib/libc.so.6 \
		# --library /usr/lib/libX11.so.6 \
		# --library /usr/lib/libpthread.so.0 \
		# --library /usr/lib/libpangocairo-1.0.so.0 \
		# --library /usr/lib/libgdk_pixbuf-2.0.so.0 \
		# --library /usr/lib/libgio-2.0.so.0 \
		# --library /usr/lib/libpangoft2-1.0.so.0 \
		# --library /usr/lib/libpango-1.0.so.0 \
		# --library /usr/lib/libfontconfig.so.1 \
		# --library /usr/lib/libxcb.so.1 \
		# --library /usr/lib/libdl.so.2 \
		# --library /usr/lib/libfreetype.so.6 \
}

# create IFDDA AppImage
make_appimage_hdf5(){
	./linuxdeploy-x86_64.AppImage --appdir=AppDir \
		-e IF-DDA/cdm/cdm \
		-d ./ifdda.desktop \
		-i ./postmanpat.png \
		--library /usr/lib/libm.so.6 \
		--library /usr/lib/gtk-2.0/modules/libcanberra-gtk-module.so \
		--library /usr/lib/libicui18n.so.64 \
		--library /usr/lib/libhdf5hl_fortran.so.100 
	cp -r /usr/lib/qt4/plugins/sqldrivers \
		./AppDir/usr/bin
	./linuxdeploy-x86_64.AppImage --appdir=AppDir \
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
# make_appimage
make_appimage_hdf5
