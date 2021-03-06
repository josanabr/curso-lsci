#!/bin/bash
#
# Script reciba 3 parametros
# $1 -> nombre maquina
# $2 -> tamano memoria
# $3 -> tipo de sistema operativo
VM=$1
MEM=$2
TYOS=$3
VBoxManage createhd --filename $VM.vdi --size 32768
VBoxManage createvm --name $VM --ostype "$TYOS" --register
VBoxManage storagectl $VM --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach $VM --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VM.vdi
VBoxManage storagectl $VM --name "IDE Controller" --add ide
VBoxManage storageattach $VM --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium /Users/john/Downloads/ubuntu-14.04.4-desktop-amd64.iso
VBoxManage modifyvm $VM --ioapic on
VBoxManage modifyvm $VM --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm $VM --memory $MEM --vram 128
