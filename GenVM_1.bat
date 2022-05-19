@echo off
set path="c:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

%path% createvm --name "%1" -register

echo Registering OS Type
%path% modifyvm "%1" --ostype Debian_64

echo Setting boot order
%path% modifyvm "%1" --boot1 disk

echo Disable usb...
%path% modifyvm "%1"  --usb off --usbehci off

echo Enabling audio...
%path% modifyvm "%1" --audio dsound --audiocontroller ac97

echo Enabling Remote Desktop Extension
%path% modifyvm "%1" --vrde on

echo Setting machine specs...
%path% modifyvm "%1" --memory "4096" --vram "128" --cpus "2" --acpi on --ioapic on

echo Creating HD Controller...
%path% storagectl "%1" --name "SATA Controller" --add sata --controller IntelAhci --portcount 1 --bootable on
%path% storageattach %1 --storagectl "SATA Controller" --device 0 --port 0 --type hdd --medium "C:\Users\admin\VirtualBox VMs\disk.vdi"


echo Creating IDE Controller...
%path% storagectl "%1" --name "IDE Controller" --add ide --controller piix4

echo Attaching Image...
set image="C:\Users\Admin\Documents\ISO\debian-11.3.0-amd64-DVD-1.iso"
%path% storageattach "%1" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium %image%

echo All Done...
pause





modifyvm "Debian64" --boot1 dvd --boot2 disk --boot3 none --boot4 none


%path% storagectl %MachineName% --name "IDE Controller" --add ide --controller PIIX4
%path% storageattach %MachineName% --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "C:\Users\Admin\Documents\ISO\debian-11.3.0-amd64-DVD-1.iso"
%path% startvm %MachineName% --type headless
if "%2"=="" goto getError_code_2

%path% unattended install "%MachineName%" --iso "C:\Users\Admin\Documents\ISO\ubuntu-20.04.4-desktop-amd64.iso" --user=user --full-user-name="Marc" --password "123456789" --country=EN --package-selection-adjustment=minimal --language=EN
