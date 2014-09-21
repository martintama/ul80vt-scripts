Sacado de http://linux-hybrid-graphics.blogspot.com.ar/2009_12_01_archive.html

To compile it, simply run:

user@machine ~ $ make

To install it, run as root:
root@machine ~ # cp asus_nvidia.ko /lib/modules/`uname -r`/kernel/
root@machine ~ # depmod

To try it out, run as root:

root@machine ~ # modprobe asus_nvidia

To load it on each reboot on Ubuntu, run as root:

root@machine ~ # echo asus_nvidia >>/etc/modules

Agregar tambien 

nouveau.blacklist=1 a GRUB_CMDLINE_LINUX_DEFAULT en /etc/default/grub
y luego correr sudo update-grub
