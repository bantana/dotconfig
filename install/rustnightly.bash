#!/usr/bin/env bash
rustup toolchain add nightly
cargo +nightly install papyrus
cargo +nightly install racer
