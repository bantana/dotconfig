#!/usr/bin/env bash
cargo install cargo-watch
cargo install evcxr_repl
git clone https://github.com/rust-analyzer/rust-analyzer.git ~/tmp/rust-analyzer && cd ~/tmp/rust-analyzer && cargo xtask install

