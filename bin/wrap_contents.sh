#! /usr/bin/bash
# automate wrapping content
# takes 3 arguments:
# name of file to be wrapped ($1)
# name used to specify the header and footer ($2)
# name of resulting file ($3)
# use cat to concatenate files, > to move into a new file

cat "${2}"_header.html "$1" "${2}"_footer.html > "$3"
