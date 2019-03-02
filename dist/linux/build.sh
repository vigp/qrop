##!/usr/bin/env bash

BUILD_DIR=$PWD
cmake . -DCMAKE_BUILD_TYPE=Release 
make -j$(nproc);
mkdir -p deploy/usr/bin deploy/usr/lib deploy/usr/share;
mkdir deploy/usr/share/applications;
find . \( -name "moc_*" -or -name "*.o" -or -name "qrc_*" -or -name "Makefile*" -or -name "*.a" \) -exec rm {} \;
cp -R core/* qrop deploy/usr/bin
cp logo.png deploy/qrop.png
cp dist/Qrop.desktop deploy/usr/share/applications
wget -c "https://github.com/probonopd/linuxdeployqt/releases/download/5/linuxdeployqt-5-x86_64.AppImage"
chmod a+x linuxdeployqt*.AppImage;
unset QTDIR; unset QT_PLUGIN_PATH ; unset LD_LIBRARY_PATH;
./linuxdeployqt*.AppImage --appimage-extract 
./squashfs-root/AppRun deploy/usr/share/applications/Qrop.desktop -qmake=/opt/qt512/bin/qmake -verbose=2 -qmldir=desktop/qml -bundle-non-qt-libs -extra-plugins=sqldrivers -exclude-libs=libqsqlmysql,libqsqlibase,libqsqlodbc,libqsqlpsql,libqsqltds -appimage
find . | grep AppImage;
