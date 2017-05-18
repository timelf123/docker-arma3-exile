#!/usr/bin/env bash
set -e
EXILE_SERVER_VERSION=1.0.2
EXILE_SERVER_URL="http://www.exilemod.com/download-all-the-files/@ExileServer-${EXILE_SERVER_VERSION}.zip"
EXILE_SERVER_FILENAME="@ExileServer-${EXILE_SERVER_VERSION}"
EXILE_CLIENT_VERSION=1.0.2
EXILE_CLIENT_URL="https://cdn.whocaresabout.de/exile/@Exile-${EXILE_CLIENT_VERSION}.zip"
EXILE_CLIENT_FILENAME="@Exile-${EXILE_CLIENT_VERSION}"
EXILE_EXT2DB_VERSION=71
EXILE_EXT2DB_URL="https://github.com/AsYetUntitled/extDB2/releases/download/v${EXILE_EXT2DB_VERSION}/extDB2-v${EXILE_EXT2DB_VERSION}.7z"
EXILE_EXT2DB_FILENAME="@extDB2"
SOURCE_PATH=$PWD
BUILD_PATH=$PWD/arma3
echo "clearing out old server files and blasting your BUILD_PATH, this is terrible"
rm -rf /tmp/Arma\ 3\ Server/ && rm -rf /tmp/MySQL && rm -rf $BUILD_PATH
echo "Fetching Exile Server ${EXILE_SERVER_VERSION}"
wget "${EXILE_SERVER_URL}" -O "/tmp/${EXILE_SERVER_FILENAME}.zip"
unzip "/tmp/${EXILE_SERVER_FILENAME}.zip" -d "/tmp/" && rm -f "/tmp/${EXILE_SERVER_FILENAME}.zip"
mkdir $BUILD_PATH/keys -p
mkdir $BUILD_PATH/battleye -p
mkdir $BUILD_PATH/mpmissions -p
cd /tmp/Arma\ 3\ Server/
echo "Transferring files Exile Server ${EXILE_SERVER_VERSION}"
mv ./@ExileServer/ $BUILD_PATH/@exileserver/ && \
	mv ./battleye/* $BUILD_PATH/battleye/ && \
	mv ./keys/* $BUILD_PATH/keys/ && \
	mv ./mpmissions/* $BUILD_PATH/mpmissions/ && \
	mv ./tbbmalloc.dll $BUILD_PATH/;
echo "Making SQL directories"
mkdir $BUILD_PATH/docker-entrypoint-initdb.d/ -p
cd /tmp/MySQL
mv ./exile.sql $BUILD_PATH/docker-entrypoint-initdb.d/
rm -rf "/tmp/${EXILE_SERVER_FILENAME}"
echo "Fetching Exile Client ${EXILE_CLIENT_VERSION}"
wget "${EXILE_CLIENT_URL}" -O "/tmp/${EXILE_CLIENT_FILENAME}.zip"
unzip "/tmp/${EXILE_CLIENT_FILENAME}.zip" -d "/tmp/${EXILE_CLIENT_FILENAME}"
mv "/tmp/${EXILE_CLIENT_FILENAME}/@Exile/" "$BUILD_PATH/@exile/"
echo "Fetching Ext2DB ${EXILE_CLIENT_VERSION}"
wget "${EXILE_EXT2DB_URL}" --no-check-certificate -O "/tmp/${EXILE_EXT2DB_FILENAME}.7z"
7z x -o"/tmp/${EXILE_EXT2DB_FILENAME}" "/tmp/${EXILE_EXT2DB_FILENAME}.7z" && \
	rm -f "/tmp/${EXILE_EXT2DB_FILENAME}.7z"
cd /tmp/$EXILE_EXT2DB_FILENAME/Linux/$EXILE_EXT2DB_FILENAME
cp ./extDB2.so $BUILD_PATH/@exileserver/ && rm -rf "/tmp/${EXILE_EXT2DB_FILENAME}"

# echo
# echo "Recreating the build directory $BUILD_PATH..."
# rm -rf $BUILD_PATH && mkdir -p $BUILD_PATH
# echo
# echo "Transferring the source: $SOURCE_PATH -> $BUILD_PATH. Please wait..."
# cd $BUILD_PATH && cp -rp $SOURCE_PATH . && cd src
# echo
# echo "Compiling PhantomJS..." && sleep 1
# python build.py --confirm --release --qt-config="-no-pkg-config" --git-clean-qtbase --git-clean-qtwebkit
# echo
echo "Finished."
