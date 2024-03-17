#!/bin/bash
if [ -z "$1" ]; then
    echo "Error: No file provided"
    exit 1
fi

INPUT_FILE="$1"
INPUT_FILE_NAME=$(basename -s .md "$INPUT_FILE")
INPUT_FILE_DIR=$(dirname "$INPUT_FILE")
OUTPUT_FILE="$INPUT_FILE_DIR/$INPUT_FILE_NAME.pdf"
MAIN_FONT="Noto Sans"
MONO_FONT="Iosevka Semibold Italic"

echo $FILE
echo $INPUT_FILE
echo $INPUT_FILE_NAME
echo $INPUT_FILE_DIR
echo $OUTPUT_FILE

pandoc --from markdown+pipe_tables \
--pdf-engine=xelatex \
-V geometry:margin=1cm \
-V mainfont="$MAIN_FONT" \
-V monofont="$MONO_FONT" \
-i "$INPUT_FILE" \
-t pdf \
-o "$OUTPUT_FILE" || exit

echo "DONE."
