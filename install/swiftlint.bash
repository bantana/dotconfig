#!/usr/bin/env bash
cd ~/tmp/
git clone --depth=1 git@github.com:realm/SwiftLint.git
cd SwiftLint/
swift build -c release --static-swift-stdlib
sudo mv .build/release/swiftlint /usr/local/bin/
