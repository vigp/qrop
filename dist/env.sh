#!/usr/bin/env bash

QROP_VERSION=$(git describe --tags)
QROP_COMMIT=$(git rev-parse HEAD)

EXE_VERSION=$(echo $QROP_VERSION | tr -d 'v')
EXE_BASENAME=Qrop-${EXE_VERSION}

APPIMAGE_NAME=${EXE_BASENAME}-x86_64.AppImage
APPIMAGE_FTP_FILE=${FTP_HOST}/httpdocs/snapshots/${APPIMAGE_NAME}
DMG_NAME=${EXE_BASENAME}.dmg
DMG_FTP_FILE=${FTP_HOST}/httpdocs/snapshots/${DMG_NAME}
WIN32_NAME=${EXE_BASENAME}-x86.exe
WIN64_NAME=${EXE_BASENAME}-x64.exe

HTTP_DIR=https://qrop.ouvaton.org/snapshots
APPIMAGE_URL=${HTTP_DIR}/${APPIMAGE_NAME}
DMG_URL=${HTTP_DIR}/${DMG_NAME}
WIN32_URL=${HTTP_DIR}/${WIN32_NAME}
WIN64_URL=${HTTP_DIR}/${WIN64_NAME}
