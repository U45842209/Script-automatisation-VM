@echo off
set path="c:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set sys="C:\Windows\System32"
set MachineName=%2%
cls
title VBoxManagement

if "%1"=="" goto getError_code

if "%1"=="-L" goto getList

if "%1"=="-N" if not "%2%"=="" goto getChecked

if "%1"=="-S" if not "%2%"=="" goto getDelete

if "%1"=="-D" if not "%2%"=="" goto getStart

if "%1"=="-A" if not "%2%"=="" goto getStop

if "%1"=="--help" goto getRead

goto skip


:getRead
Type "README.md"
echo.
echo Press q to exit...
pause>nul
exit /b 0


:getError_code
cls
echo Errorlevel: %errorlevel%
echo No first argument
exit /b 0


:getChecked
echo ==================Checking process==================
%path% list vms > "C:\Users\admin\VirtualBox VMs\list.txt"
%sys%\find "%MachineName%" "C:\Users\admin\VirtualBox VMs\list.txt" && (
echo "VM was found."
call :getDelete
call :getCreate
goto getFinish
) || (
echo "VM was NOT found."
call :getCreate
)
exit /b 0


:getDelete
echo ==================Deleting process==================  
echo Deleting VM %MachineName%...
%path% unregistervm "%MachineName%" --delete
del "C:\Users\admin\.VirtualBox\TFTP\%MachineName%.pxe"
exit /b 0


:getList
cls
==================Liste==================  
%path% list vms
exit /b 0


:getCreate
echo ==================Creating process================== 
%path% createvm --name %MachineName% --register
echo Registering OS Type...
%path% modifyvm %MachineName% --ostype Ubuntu_64
echo Setting boot order...
%path% modifyvm %MachineName% --boot1 net --boot2 disk --boot3 none --boot4 none --nicbootprio1 1
echo Enabling audio...
%path% modifyvm %MachineName% --audio dsound --audiocontroller ac97
echo Enabling Remote Desktop Extension
%path% modifyvm %MachineName% --vrde on
echo Setting machine specs...
%path% modifyvm %MachineName% --memory "4096" --vram "128" --cpus "2" --acpi on --ioapic on --nic1 nat
echo Creating Disk File...
%path% createhd --filename "C:\Users\admin\VirtualBox VMs\%MachineName%\%MachineName%_DISK.vdi" --size "65536"
echo Setting up the Disks...
%path% storagectl %MachineName% --name "SATA Controller" --add sata --controller IntelAhci
%path% storageattach %MachineName% --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "C:\Users\admin\VirtualBox VMs\%MachineName%\%MachineName%_DISK.vdi"
%path% storagectl %MachineName% --name "IDE Controller" --add ide --controller PIIX4
copy "C:\Users\admin\.VirtualBox\TFTP\base.pxe" "C:\Users\admin\.VirtualBox\TFTP\%MachineName%.pxe"
exit /b 0

:skip
echo Done
