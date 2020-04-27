#!/usr/bin/env bash
# git clone https://github.com/rust-analyzer/rust-analyzer.git ~/tmp/rust-analyzer && cd ~/tmp/rust-analyzer && cargo xtask install
cargo install cargo-watch
cargo install evcxr_repl
cargo install fd-find
cargo install ripgrep

#cargo install crowbook
mkdir -p ~/.local/share/bash-completion/completions
rustup completions bash > ~/.local/share/bash-completion/completions/rustup

rustup toolchain add nightly
cargo +nightly install papyrus
cargo +nightly install racer

