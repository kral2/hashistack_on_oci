#!/usr/bin/env bash

set -e

# Terminal rapid start.
# Only works on macOS with iTerm and VSCode installed. Sorry, but not sorry ¯\_(ツ)_/¯
[ `uname -s` != "Darwin" ] && return

# open additional terminal shells
open -a iTerm "build" && tree -L 1 && code .
open -a iTerm "provision"
open -a iTerm "run"
open -a iTerm "run"