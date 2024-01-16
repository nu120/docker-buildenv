#!/bin/sh

BANNER=$(cat << "EOF"

 ----------------------------------------------------------------------

   Build command:

       source ./buildroot/build/setenv.sh axg_s420_a6432_k54_release
       make

   Build artifact:

       output/axg_s420_a6432_k54_release/images/aml_upgrade_package.img

 ----------------------------------------------------------------------
EOF
)

echo "$BANNER"
echo

exec "$@"
