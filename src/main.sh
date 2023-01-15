#!/bin/bash

BOOTUSAGE=$(df -h | grep -E /boot$ | awk '{print $5}')
echo -e "Usage of /boot: $BOOTUSAGE\n"

read -p "Enter the number of kernels you want to leave installed (default:3) " AMOUNT

if [ -z "$AMOUNT" ]; then
    AMOUNT=3
fi

is_int () { test "$@" -eq "$@" 2> /dev/null; }
if ! is_int $AMOUNT; then
    echo "Please enter a number"
    exit 1
fi

KERNELLIST=$(dpkg -l linux-image-\* | grep -E '^ii\s+linux-image-[1-9]+' | awk '{print $2}' | sort -Vr)
echo -e "Kernels available:\n$KERNELLIST\n"
KERNELSTOUNINSTALL=$(echo -e "$KERNELLIST" | tail -n $AMOUNT)
echo -e "Kernels to uninstall:\n$KERNELSTOUNINSTALL\n"

read -p "Proceed? (yes/n)" PROCEED
if [ "$PROCEED" != "yes" ]; then
    echo "Aborting"
    exit 1
fi

apt-get purge $KERNELSTOUNINSTALL

BOOTUSAGE=$(df -h | grep -E /boot$ | awk '{print $5}')
echo -e "Usage of /boot after the uninstall: $BOOTUSAGE\n"

read -p "Do you want to execute auto-remove to clean the headers? (y/n)" PROCEED
if [ "$PROCEED" != "y" ]; then
    echo "Aborting"
    exit 2
fi

apt autoremove

echo -e "\nDone\n"
