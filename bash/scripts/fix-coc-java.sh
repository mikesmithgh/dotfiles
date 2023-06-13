#!/bin/bash
# see https://github.com/neoclide/coc-java/issues/99#issuecomment-663856695
# requires java 11 and this executable for some reason

rm -rf ~/.config/coc/extensions/coc-java-data/server
mkdir ~/.config/coc/extensions/coc-java-data/server
cd ~/.config/coc/extensions/coc-java-data/server
curl -O https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz
tar -xvf jdt-language-server-0.57.0-202006172108.tar.gz
