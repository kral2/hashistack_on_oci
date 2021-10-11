#!/usr/bin/env bash

set -e

# Terminal rapid start.
# Only works on macOS
[ `uname -s` != "Darwin" ] && return

# open additional terminal shells
open -a iTerm "build" && tree -L 1
open -a iTerm "provision"
open -a iTerm "run"
open -a iTerm "run"