#!/bin/bash

echo "Setting vm.max_map_count and fs.file-max..."

if [ "$EUID" -eq 0 ]
then
    sysctl -w vm.max_map_count=262144
    sysctl -w fs.file-max=131072
    echo "Done!"
else
    echo "Not running as root, can not set vm.max_map_count and fs.file-max via sysctl."
fi