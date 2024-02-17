#!/bin/bash
INPUT_FILE=$(mktemp -u)
pandoc --from markdown+pipe_tables --pdf-engine=xelatex -V geometry:margin=1cm -V mainfont="JetBrains Mono" -i "$1" -t pdf -o "$INPUT_FILE" && atril "$INPUT_FILE"
