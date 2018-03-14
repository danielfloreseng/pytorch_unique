#!/bin/sh

echo "Compiling kernel..."

if [ -z "$1" ]; then TORCH=$(python -c "import os; import torch; print(os.path.dirname(torch.__file__))"); else TORCH="$1"; fi
SRC_DIR=torch_unique/kernel
BUILD_DIR=torch_unique/build

mkdir -p $BUILD_DIR
$(which nvcc) -c -o "$BUILD_DIR/kernel.so" "$SRC_DIR/kernel.cu" -arch=sm_35 -Xcompiler -fPIC -shared "-I$1/lib/include/TH" "-I$1/lib/include/THC" "-I$SRC_DIR"
