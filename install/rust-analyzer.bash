#!/usr/bin/env bash
if [[ $(uname -s) == "Linux" ]]; then
    curl -sL https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-linux -o ~/.cargo/bin/rust-analyzer
fi
if [[ $(uname -s) == "Darwin" ]]; then
    curl -sL https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-mac -o ~/.cargo/bin/rust-analyzer
fi
