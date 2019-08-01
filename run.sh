# Build AppImage form IFDDA sources
# Function on x64 architectures
# BUG: hdf5 version does not work yet
# BUG2: adresse de la doc en dur donc pas incorporable
# ~BUG3: parametres par defauts a changer

# download latest IFDDA version

HDF5=1 #0->fftw 1->hdf5

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
		--library /usr/lib/libm.so.6 \
		--library /usr/lib/gtk-2.0/modules/libcanberra-gtk-module.so \
		--library /usr/lib/libicui18n.so.64 
	if [[ $HDF5 == 1 ]]; then
		./linuxdeploy-x86_64.AppImage --appdir=AppDir \
		-d ./ifdda.desktop \
		-i ./postmanpat.png \
			--library /usr/lib/libdl.so.2 \
			--library /usr/lib/libpthread.so.0 \
			--library /usr/lib/libz.so.1 \
			--library /usr/lib/libc.so.6 \
			--library /usr/lib/libfuse.so.2 \
			--library /usr/lib/libfreetype.so.6 \
			--library /usr/lib/libGLU.so.1 \
			--library /usr/lib/libGL.so.1 \
			--library /usr/lib/libstdc++.so.6 \
			--library /usr/lib/libgcc_s.so.1 \
			--library /usr/lib/libGLX.so.0 \
			--library /usr/lib/libGLdispatch.so.0 \
			--library /usr/lib/libX11.so.6 \
			--library /usr/lib/libglib-2.0.so.0 \
			--library /usr/lib/libgobject-2.0.so.0 \
			--library /usr/lib/libSM.so.6 \
			--library /usr/lib/libICE.so.6 \
			--library /usr/lib/libfontconfig.so.1 \
			--library /usr/lib/librt.so.1 \
			--library /usr/lib/libutil.so.1 \
			--library /usr/lib/libharfbuzz.so.0 \
			--library /usr/lib/libxcb.so.1 \
			--library /usr/lib/libpcre.so.1 \
			--library /usr/lib/libffi.so.6 \
			--library /usr/lib/libuuid.so.1 \
			--library /usr/lib/libbsd.so.0 \
			--library /usr/lib/libexpat.so.1 \
			--library /usr/lib/libgraphite2.so.3 \
			--library /usr/lib/libXau.so.6 \
			--library /usr/lib/libXdmcp.so.6 \
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
# clean
# clone
# install
# get_appimages
make_appimage
