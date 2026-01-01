#!/usr/bin/env bash
set -e

if [ "$#" -ne 2 ]; then
    echo "usage: $0 <num_files> <heat_depth>"
    exit 1
fi

NUM_FILES="$1"
DEPTH="$2"

if ! [[ "$NUM_FILES" =~ ^[0-9]+$ ]] || ! [[ "$DEPTH" =~ ^[0-9]+$ ]]; then
    echo "error: arguments must be positive integers"
    exit 1
fi

for i in $(seq 1 "$NUM_FILES"); do
    cat > "heat$i.cpp" <<EOF
#include "heat.hpp"

Heater<$DEPTH> h$i;
EOF
done

echo "generated $NUM_FILES heat files with depth $DEPTH"

