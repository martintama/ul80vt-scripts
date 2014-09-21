#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Por favor ejecute este comando como ROOT"
else
  echo "** Bajando paquetes necesarios"
  aptitude install linux-headers-`uname -r` build-essential

  echo "** Compilando modulo:"
  make

  echo "** Creando certificados para firmar el modulo creado..."
  if [ ! -f /root/x509.genkey ]; then
    cp x509.genkey /root
  fi

  if [ ! -f /root/signing_key.x509 ]; then
    if [ ! -f /root/signing_key.prov ]; then
      openssl req -new -nodes -utf8 -sha512 -days 36500 -batch -x509 -config /root/x509.genkey -outform DER -out /root/signing_key.x509 -keyout /root/signing_key.priv
    fi
  fi

  echo "** Firmando modulo"
  perl /usr/src/linux-headers-`uname -r`/scripts/sign-file sha512 /root/signing_key.priv /root/signing_key.x509 asus_nvidia.ko 

  echo "** Copiando modulo a sistema"
  cp asus_nvidia.ko /lib/modules/`uname -r`/kernel

  echo "** Aplicando cambio"
  depmod
  
  echo "** Cargando modulo"
  modprobe asus_nvidia
  
  echo "** Seteando inicio automático de módulo"
  echo asus_nvidia > /etc/modules-load.d/asus_nvidia.conf

  echo "** Blacklisteando modulo nvidia"
  echo "blacklist nvidia" >> /etc/modprobe.d/blacklist-nvidia.conf

  echo "Fin"
fi
