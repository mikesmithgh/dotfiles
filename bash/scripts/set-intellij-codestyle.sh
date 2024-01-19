#!/usr/bin/env bash
intellij_dirname="$(/usr/libexec/PlistBuddy -c "print :JVMOptions:Properties:idea.paths.selector" /Applications/IntelliJ\ IDEA.app/Contents/Info.plist)"
intellij_codestyles_path="$HOME/Library/Application Support/JetBrains/$intellij_dirname/codestyles"
intellij_default_codestyle_file="$intellij_codestyles_path/Default.xml"
[[ -s "$intellij_default_codestyle_file" ]] && mv -f "$intellij_default_codestyle_file" "${intellij_default_codestyle_file}.bak"
ln -s "$HOME/repos/accumulus-core/configs/AccCodeStyle.xml" "$intellij_default_codestyle_file"
