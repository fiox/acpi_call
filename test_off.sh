#!/bin/bash

if lsmod | grep -q acpi_call; then
    methods="
    \_SB.PCI0.P0P1.VGA._OFF
    \_SB_.PCI0.OVGA.ATPX
    \_SB_.PCI0.OVGA.XTPX
    \_SB.PCI0.P0P2.PEGP._OFF
    \_SB.PCI0.MXR0.MXM0._OFF
    \_SB.PCI0.PEG1.GFX0._OFF
    \_SB.PCI0.PEG1.GFX0.DOFF
    \_SB.PCI0.XVR0.Z01I.DGOF
    \_SB.PCI0.PEGR.GFX0._OFF
    "

    for m in $methods; do
        echo -n "Trying $m: "
        echo $m > /proc/acpi/call
        result=$(cat /proc/acpi/call)
        if [ $result = "ok" ]; then
            echo "works!"
            break
        elif [ $result = "failed" ]; then
            echo "failed"
        fi
    done
else
    echo 'The acpi_call module is not loaded'
    exit 1
fi
