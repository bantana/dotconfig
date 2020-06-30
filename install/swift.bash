#!/usr/bin/env bash
if [[ -d /usr/share/swift ]]; then
    echo "/usr/share/swift directory already exits, remove before continue..." && return 1
fi
if [[ ! -d /usr/share/swift ]]; then
    sudo mkdir -p /usr/share/swift
fi
cd /var/tmp
curl -s https://swift.org/download/#releases|grep -w "RELEASE-ubuntu$(lsb_release -rs)" | head -1|awk -F "\"" '{print "wget -r --tries=10 -c https://swift.org/"$2" -O swift.tar.gz"}      '|bash -E && sudo tar xzvf swift.tar.gz --strip 1 -C /usr/share/swift
