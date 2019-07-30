# Build AppImage form IFDDA sources
# Function on x64 architectures
# BUG: hdf5 version does not work yet

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
		--library /usr/lib/libm.so.6 \
		--library /usr/lib/libc.so.6 \ #cause segmentation fault
		--library /usr/lib/gtk-2.0/modules/libcanberra-gtk-module.so \
		--library /usr/lib/libicui18n.so.64 \
		--output appimage
		# --library /usr/lib/libGL.so.1 \
		# --library /usr/lib/libstdc++.so.6 \
		# --library /usr/lib/libgcc_s.so.1 \
		# --library /usr/lib64/ld-linux-x86-64.so.2 \
		# --library /usr/lib/libpthread.so.0 \
		# --library /usr/lib/libX11.so.6 \
		# --library /usr/lib/libdl.so.2 \
		# --library /usr/lib/libz.so.1 \
		# --library /usr/lib/libfreetype.so.6 \
		# --library /usr/lib/libglib-2.0.so.0 \
		# --library /usr/lib/libgobject-2.0.so.0 \
		# --library /usr/lib/libSM.so.6 \
		# --library /usr/lib/libICE.so.6 \
		# --library /usr/lib/libfontconfig.so.1 \
		# --library /usr/lib/librt.so.1 \
		# --library /usr/lib/libxcb.so.1 \
		# --library /usr/lib/libharfbuzz.so.0 \
		# --library /usr/lib/libuuid.so.1 \
		# --library /usr/lib/libexpat.so.1 \
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
