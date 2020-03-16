#!/usr/bin/env bash
# swift path
swift_bin_path="/usr/share/swift/usr/bin"
if [[ -d "${swift_bin_path}" ]]; then
    addToPATH "${swift_bin_path}"
fi
unset swift_bin_path
echo "debug swift"
