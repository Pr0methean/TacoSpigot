#!/bin/bash

git submodule update --recursive --init && \
# echo "Updating Paper..." && \
cd Paper && \
# git checkout ver/1.12.2 && \
echo "Updating BuildData..." && \
cd work/BuildData && \
git checkout 351106b6336fc52f6acf94aabd34ac54fc772432 && \
echo "Updating Bukkit..." && \
cd ../Bukkit && \
git checkout 23c1a2ba03b96b52f69a93e07706f9ccc33fd683 && \
echo "Updating CraftBukkit..." && \
cd ../CraftBukkit && \
git checkout 162bda93ff76fe96a6138a14176807f21a6ddef4 && \
cd ../Spigot && \
git checkout fe3ab0d858960183da1da1b1378c363c3da94bbb && \
# echo "Updating Paperclip..." && \
# cd ../Paperclip && \
# git checkout ver/1.12.2 && \
cd ../../.. && \
./remap.sh && ./decompile.sh && ./init.sh && ./applyPatches.sh || exit 1

# Generate paperclip jar in this stage
mkdir -p work/Paperclip
PAPERCLIP_JAR=paperclip.jar

if [ ! -f work/Paperclip/$PAPERCLIP_JAR ]; then
    if [ ! -d Paperclip ]; then
        echo "Paperclip not found"
        exit 1;
    fi
    echo "Generating Paperclip Jar"
    pushd Paperclip
    mvn -P '!generate' clean install
    if [ ! -f target/paperclip*.jar ]; then
        echo "Couldn't generate paperclip jar"
        exit;
    fi;
    popd
    cp Paperclip/target/paperclip*.jar work/Paperclip/$PAPERCLIP_JAR
fi;
