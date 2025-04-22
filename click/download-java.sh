#!/bin/bash
set -Eeou pipefail

case $ARCH in
amd64)
  JAVA_ARCH=x64
  ;;
arm64)
  JAVA_ARCH=aarch64
  ;;
*)
  echo "Architecture $ARCH not supported."
  exit 1
  ;;
esac

JDK_VERSION=17.0.2
OPENJDK_NAME=openjdk-${JDK_VERSION}_linux-${JAVA_ARCH}_bin
JDK_PATH=${BUILD_DIR}/jdk-${JDK_VERSION}
LINK=https://download.java.net/java/GA/jdk${JDK_VERSION}/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/${OPENJDK_NAME}.tar.gz

if [ -d ${JDK_PATH} ]; then
  echo "Skipping download, because files already exist..."
else
  echo "Downloading Java..."
  wget -qO- ${LINK} | tar xvz -C ${BUILD_DIR}
fi

echo "Copying files into place..."
cp -r ${JDK_PATH} ${INSTALL_DIR}/
