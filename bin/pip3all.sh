#!/usr/bin/env bash
# pip3 list |awk 'NR>2 {print "pip3 install --upgrade --user "$1}'|bash -
pip3 list |awk 'NR>2 {print "pip3 install --upgrade "$1}'|bash -
