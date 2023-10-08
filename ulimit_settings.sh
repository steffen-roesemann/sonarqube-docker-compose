#!/bin/bash

echo "Setting ulimit settings..."
ulimit -n 131072
ulimit -u 8192
echo "Done!"