#!/bin/bash
if [ -z "$1" ]; then
    echo "Error: No file provided"
    exit 1
fi
INPUT_FILE="$1"
OUTPUT_FILE=$(mktemp -u)
MAIN_FONT="Noto Sans"
MONO_FONT="Iosevka Semibold Italic"

pandoc --from markdown+pipe_tables \
--pdf-engine=xelatex \
-V geometry:margin=1cm \
-V mainfont="$MAIN_FONT" \
-V monofont="$MONO_FONT" \
-i "$INPUT_FILE" \
-t pdf \
-o "$OUTPUT_FILE" || exit

atril "$OUTPUT_FILE"
