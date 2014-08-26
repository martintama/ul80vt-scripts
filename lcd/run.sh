#!/bin/bash
echo "*******************"
echo "** Editar /etc/default/grub y agregar \"acpi_backlight=vendor\" en GRUB_CMDLINE_LINUX"
echo "** Luego ejecutar update-grub"
echo "*******************"
echo ""
echo "* Copiando archivos de control de brillo"
echo "* /etc/acpi/asus-lcd-brightness.sh"
sudo cp ./acpi/asus-lcd-brightness.sh /etc/acpi

echo "* /etc/acpi/events/asus-lcd-brightness-up"
sudo cp ./acpi/events/asus-lcd-brightness-up /etc/acpi/events

echo "* /etc/acpi/events/asus-lcd-brightness-down"
sudo cp ./acpi/events/asus-lcd-brightness-down /etc/acpi/events

echo "* Reinciando acpid"
sudo /etc/init.d/acpid restart
