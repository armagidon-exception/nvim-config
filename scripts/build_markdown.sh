#!/bin/bash
if [ -z "$1" ]; then
    echo "Error: No file provided"
    exit 1
fi
INPUT_FILE="$1"
INPUT_FILE_NAME=$(basename -s .md "$INPUT_FILE")
INPUT_FILE_DIR=$(dirname $INPUT_FILE)
OUTPUT_FILE="$INPUT_FILE_DIR/$INPUT_FILE_NAME.pdf"
FONT="JetBrains Mono"

pandoc --from markdown+pipe_tables \
--pdf-engine=xelatex \
-V geometry:margin=1cm \
-V mainfont="$FONT" \
-i "$INPUT_FILE" \
-t pdf \
-o "$OUTPUT_FILE" || exit

echo "DONE."
