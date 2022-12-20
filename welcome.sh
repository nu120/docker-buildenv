#!/bin/sh

BANNER=$(cat << "EOF"

 ----------------------------------------------------------------------

   Build command:

       echo 8 | source ./buildroot/build/setenv.sh
       make

   Build artifact:

       output/mesonaxg_s420_32_release/images/aml_upgrade_package.img

 ----------------------------------------------------------------------
EOF
)

echo "$BANNER"
echo

exec "$@"
