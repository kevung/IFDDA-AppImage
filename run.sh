# Build AppImage form IFDDA sources
# Function on x64 architectures
# BUG: hdf5 version does not work yet
# BUG2: adresse de la doc en dur donc pas incorporable
# ~BUG3: parametres par defauts a changer

# download latest IFDDA version

HDF5=1 #0->fftw 1->hdf5
LIBPATH=/usr/lib

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

# pour debuger, LD_DEBUG=libs ./IFDDA.AppImage et
# sudo strace -f ./IFDDA.AppImage
# create IFDDA AppImage
make_appimage(){
	./linuxdeploy-x86_64.AppImage --appdir=AppDir \
		-e IF-DDA/cdm/cdm \
		-d ./ifdda.desktop \
		-i ./postmanpat.png \
		--library $LIBPATH/libm.so.6 \
		--library $LIBPATH/gtk-2.0/modules/libcanberra-gtk-module.so \
		--library $LIBPATH/libicui18n.so.64 
	if [[ $HDF5 == 1 ]]; then
		./linuxdeploy-x86_64.AppImage --appdir=AppDir \
		-d ./ifdda.desktop \
		-i ./postmanpat.png \
			--library $LIBPATH/libdl.so.2 \
			--library $LIBPATH/libpthread.so.0 \
			--library $LIBPATH/libz.so.1 \
			--library $LIBPATH/libc.so.6 \
			--library $LIBPATH/libfuse.so.2 \
			--library $LIBPATH/libfreetype.so.6 \
			--library $LIBPATH/libGLU.so.1 \
			--library $LIBPATH/libGL.so.1 \
			--library $LIBPATH/libstdc++.so.6 \
			--library $LIBPATH/libgcc_s.so.1 \
			--library $LIBPATH/libGLX.so.0 \
			--library $LIBPATH/libGLdispatch.so.0 \
			--library $LIBPATH/libX11.so.6 \
			--library $LIBPATH/libglib-2.0.so.0 \
			--library $LIBPATH/libgobject-2.0.so.0 \
			--library $LIBPATH/libSM.so.6 \
			--library $LIBPATH/libICE.so.6 \
			--library $LIBPATH/libfontconfig.so.1 \
			--library $LIBPATH/librt.so.1 \
			--library $LIBPATH/libutil.so.1 \
			--library $LIBPATH/libharfbuzz.so.0 \
			--library $LIBPATH/libxcb.so.1 \
			--library $LIBPATH/libpcre.so.1 \
			--library $LIBPATH/libffi.so.6 \
			--library $LIBPATH/libuuid.so.1 \
			--library $LIBPATH/libbsd.so.0 \
			--library $LIBPATH/libexpat.so.1 \
			--library $LIBPATH/libgraphite2.so.3 \
			--library $LIBPATH/libXau.so.6 \
			--library $LIBPATH/libXdmcp.so.6 \
			--library $LIBPATH/libhdf5hl_fortran.so.100 
	fi;
	cp -r $LIBPATH/qt4/plugins/sqldrivers \
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
# clean
# clone
# install
# get_appimages
make_appimage
