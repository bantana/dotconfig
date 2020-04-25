#!/usr/bin/env bash
if [[ $(uname -s) == "Linux" ]]; then
    echo "curl -sL https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-linux -o ~/.cargo/bin/rust-analyzer"
    curl -sL https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-linux -o ~/.cargo/bin/rust-analyzer
fi
if [[ $(uname -s) == "Darwin" ]]; then
    echo "curl -sL https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-mac -o ~/.cargo/bin/rust-analyzer"
    curl -sL https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-mac -o ~/.cargo/bin/rust-analyzer
fi
if [[ $? -ne 0 ]]; then
    echo "ERROR>>> error code: $?"
    exit 1
fi
chmod +x ~/.cargo/bin/rust-analyzer
echo "success!"
