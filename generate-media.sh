#!/bin/bash

set -eum
IFS=$'\n\t'

rm media/* -rf
mkdir media/png

clear

CMD='
    export PS1="\$ "
    sleep 1
    echo "$ node test/tap-output.js | tap-report" | pv -qL 15
    sleep 2
    node test/tap-output.js | tap-report
    sleep 4
    printf ""
'

# Simulate typing
asciinema rec -c "$CMD" --max-wait 4 --title tap-report --quiet media/output.json &
fg %1

# Convert to gif
docker run --rm -v "$PWD":/data asciinema/asciicast2gif media/output.json media/output.gif

# Generate png's from gif
convert -verbose -coalesce media/output.gif media/png/output.png

# Remove all png's except last sequence
find media/png/*.png | sort -n -t "-" -k 2 | head -n -1 | xargs rm

mv media/png/*.png media/output.png
rm media/png -r
