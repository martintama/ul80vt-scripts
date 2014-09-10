#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Por favor ejecute este comando como ROOT"
else
  echo "** Compilando modulo:"
  make

  echo "** Copiando modulo a sistema"
  cp asus_nvidia.ko /lib/modules/`uname -r`/kernel

  echo "** Aplicando cambio"
  depmod
  
  echo "** Cargando modulo"
  modprobe asus_nvidia
  
  echo "** Seteando inicio automático de módulo"
  echo asus_nvidia >> /etc/modules-load.d/asus_nvidia.conf

  echo "** Blacklisteando modulo nvidia"
  echo nvidia >> /etc/modprobe.d/blacklist-nvidia.conf

  echo "Fin"
fi
