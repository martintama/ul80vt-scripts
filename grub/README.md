copiar esta linea a /etc/default/grub

GRUB_CMDLINE_LINUX="video.use_native_backlight=1 acpi_osi='!Windows 2012' acpi_osi=Linux intel_pstate=disable"

y luego correr

$ sudo update-grub
