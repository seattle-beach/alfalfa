#!/bin/bash

export PATH="$HOME/.cargo/bin:$PATH"
rustup default nightly
rustup component add rust-src
cargo install cargo-update
cargo install racer
cargo install rustfmt-nightly
cargo install clippy
