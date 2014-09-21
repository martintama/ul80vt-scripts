#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Por favor ejecute este comando como ROOT"
else
  cp touchpad-middle-button /etc/init.d
  update-rc.d touchpad-middle-button defaults
fi
