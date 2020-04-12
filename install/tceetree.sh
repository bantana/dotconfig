#!/usr/bin/env bash

tceetree_dir='tceetree'
bin_dir="$HOME/.local/bin"
if [[ ! -d "$HOME"/tmp ]]; then
   mkdir -p "$HOME"/tmp 
fi
if [[ ! -d "${bin_dir}" ]]; then
    mkdir -p "${bin_dir}"
fi
git clone --depth 1 git@github.com:mihais/tceetree.git "$HOME"/tmp/${tceetree_dir}
cd  "$HOME/tmp/${tceetree_dir}"  &&
cc -o "${bin_dir}"/tceetree tceetree.c gettree.c  outgraphviz.c  outtree.c  rbtree.c  slib.c  symtree.c
