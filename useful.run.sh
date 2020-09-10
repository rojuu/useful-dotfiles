#!/bin/bash

#
# Exampe run.sh file with optional arguments
#

args=(
  arg1
  arg2 # some comment
  arg3
  # arg4_optional
  arg5
)
# gdb --args \
  ./main ${args[@]}
