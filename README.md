## Introduction 
# KTWEAK X FKBTS X ZRAM
A no-bullsheet, fine-tuned kernel tweaks forked from tytydraco's original Ktweak, with force default kernel-based thermal system and configure ZRAM to 100% of actual RAM size.

> As called KTWEAK X FKBTS X ZRAM by combine Ktweak and 2 other intergrated scripts.

> Ktweaks: When install module, it will config, fine-tune, and made adjustments to available parameters in system kernel (like Android Kernel) to the best settings without messing other stuffs, this has done by the experienced kernel developers.

> FKBTS: If you don't know, some operating system had 2 thermal function system, one is on configs stored on (ex: thermal_config.cfg) which is system use it to excecute and management from it. Other is thermal system stored on kernel (ex: MSM Thermal, ThermalDriver), operating system will use kernel-based thermal system if configs are not available, or user changed power mode on the device.
By the FKBTS scripts, it will locate and rewrite to a new diffirent file name extensions or relocate files to the folder of the installed module. And yet, no harm done on system files. When uninstall module and reboot, all files will be back into origin

> ZRAM: Virtual Memory, a crucial part of operating system, used to store vital processes and temporaries, thus also prevent system crashes that may damage hardware when there's a lot of processes running on the device.
By the ZRAM scripts in module, it will configure ZRAM to 100% of actual RAM size, but not fully because of hardware reserved.

## CAUTION

- Do not install any tweaks relative, especially the sketchy, snake oil and harmful one.

## REQUIREMENT

- 1Ghz of Device Processor/APU
- 1GBs of RAM
- UNLOCKED BOOTLOADER, any installed root with module capablity
- Minimum Linux Kernel: 3+ ; Recommended Linux Kernel: 4+
- A brains with a little knowledges about softwares and experiences

## KNOW ISSUES

- On newest KernelSU manager (0.8.0+), module may failed to install due to KernelSU been reconstructed and use new spare image to store module. User may stop updating and stay on old manager version for now until new solution is found.

## Install

1. Install in any installed root manager with module capablity
2. Reboot and Forget
5. Have fun! :)

## Credits 

- [tytydrago]
- [erenyeagarr(ZyCromerZ)]
- [topjohnwu]
- [tiann]
- [osm0sis]
