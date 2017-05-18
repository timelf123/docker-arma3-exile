FROM alpine:3.5

ENV BUILD_STAMP 2016-05-15T13:09:43+09:30
RUN apk update
RUN apk add --no-cache wget unzip build-base bash p7zip

ENV EXILE_SERVER_VERSION 1.0.2
ENV EXILE_SERVER_URL "http://www.exilemod.com/download-all-the-files/@ExileServer-${EXILE_SERVER_VERSION}.zip"
ENV EXILE_SERVER_FILENAME "@ExileServer-${EXILE_SERVER_VERSION}"

ENV EXILE_CLIENT_VERSION 1.0.2
ENV EXILE_CLIENT_URL "https://cdn.whocaresabout.de/exile/@Exile-${EXILE_CLIENT_VERSION}.zip"
ENV EXILE_CLIENT_FILENAME "@Exile-${EXILE_CLIENT_VERSION}"

ENV EXILE_EXT2DB_VERSION 71
ENV EXILE_EXT2DB_URL "https://github.com/AsYetUntitled/extDB2/releases/download/v${EXILE_EXT2DB_VERSION}/extDB2-v${EXILE_EXT2DB_VERSION}.7z"
ENV EXILE_EXT2DB_FILENAME "@extDB2"

RUN echo "Fetching Exile Server ${EXILE_SERVER_VERSION}"

ENV BUILD_STAMP 2017-05-15T13:47:06+09:30

RUN wget "${EXILE_SERVER_URL}" -O "/tmp/${EXILE_SERVER_FILENAME}.zip"
RUN unzip "/tmp/${EXILE_SERVER_FILENAME}.zip" -d "/tmp/" && rm -f "/tmp/${EXILE_SERVER_FILENAME}.zip"


ENV BUILD_STAMP 2016-05-15T14:10:26+09:30
RUN mkdir /arma3/keys -p
RUN mkdir /arma3/battleye -p
RUN mkdir /arma3/mpmissions -p

# WORKDIR /tmp/$EXILE_SERVER_FILENAME/Arma\ 3\ Server
WORKDIR /tmp/Arma\ 3\ Server/
RUN ls -la
RUN	mv ./@ExileServer /arma3/@exileserver && \
	mv ./battleye/* /arma3/battleye/ && \
	mv ./keys/* /arma3/keys/ && \
	mv ./mpmissions/* /arma3/mpmissions/ && \
	mv ./tbbmalloc.dll /arma3/;
RUN ls -la /arma3/keys

ENV BUILD_STAMP 2016-05-15T14:11:18+09:30
RUN mkdir /docker-entrypoint-initdb.d/
WORKDIR /tmp/MySQL
RUN mv ./exile.sql /docker-entrypoint-initdb.d/

# RUN rm -rf "/tmp/${EXILE_SERVER_FILENAME}"

# RUN echo "Fetching Exile Client ${EXILE_CLIENT_VERSION}"
# RUN wget "${EXILE_CLIENT_URL}" -O "/tmp/${EXILE_CLIENT_FILENAME}.zip"
# RUN unzip "/tmp/${EXILE_CLIENT_FILENAME}.zip" "/tmp/${EXILE_CLIENT_FILENAME}"
# RUN mv "/tmp/${EXILE_CLIENT_FILENAME}/\@Exile/" /arma3/\@exile/

ENV BUILD_STAMP 2016-06-19T13:16:36+09:30
RUN echo "Fetching Ext2DB ${EXILE_CLIENT_VERSION}"
RUN wget "${EXILE_EXT2DB_URL}" --no-check-certificate -O "/tmp/${EXILE_EXT2DB_FILENAME}.7z"
RUN 7z x -o"/tmp/${EXILE_EXT2DB_FILENAME}" "/tmp/${EXILE_EXT2DB_FILENAME}.7z" && \
	rm -f "/tmp/${EXILE_EXT2DB_FILENAME}.7z"

WORKDIR /tmp/$EXILE_EXT2DB_FILENAME/Linux/$EXILE_EXT2DB_FILENAME
RUN cp ./extDB2.so /arma3/\@exileserver/ && \
		rm -rf "/tmp/${EXILE_EXT2DB_FILENAME}"

WORKDIR /arma3

RUN rm -rf /tmp/*
