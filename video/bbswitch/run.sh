#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Por favor ejecute este comando como ROOT"
else
  echo "Instalando bbswitch"
  aptitude update && sudo aptitude install bbswitch-dkms
  
  if [ -f ./bbswitch.conf ]; then
  echo "Configurando bbswitch para iniciarse automaticamente"
  cp bbswitch.conf /etc/modules-load.d
  else
    echo "Debe correr el script desde el directorio que contiene el archivo bbswitch.conf"
    exit -1
  fi
  echo "bbswitch instalado y configurado exitosamente"
 fi


#blacklistear nouveau


