## Introduction 
# Unified Android Tweaker
A unified module consist of 3 core scripts forked from modules: tytydraco's Ktweak, erenyeagarr's Thermal Killer and reiryuki's ZRAM Swap Configuration.
Re-modified and re-configured into one convenient package. 

Feature:
- Fine-tune system kernel parameters with best setting, this has done by experienced kernel developers.
- Locate, modified found configs files into different file extensions (ex: msm_thermal.bck) or relocate files to the folder of the installed module. This will force system to use thermal system in kernel as default. No harm done on system file, modified file will be reinstated to original after uninstall module.
- Module will configure and resize ZRAM to 100% of actual installed RAM size during device boot (Not fully because of hardware reserve). It swap memory on RAM, faster than swap memory on Storage/Disk.
- Module should work on any Android device (Tablets and Smartphones only. No Virtual because such this not take full potential powers on hardware performance) based on Linux Kernel along with Rooted (Magisk, KernelSU, etc).
- Non-intrusive and systemless.
- Open source.

## DISCLAMER
- USE THIS MODULE AT YOUR OWN RISKS.
- DEVELOPERS OF THIS MODULE ARE NOT TOOK RESPONSIBILITY FOR ANYHING THAT HAPPENS.

## REQUIREMENT
- 1Ghz+ of ANDROID Device Processor/APU.
- 1GBs+/4GBs+ of RAM/ROM.
- ANDROID 6 and above.
- UNLOCKED BOOTLOADER and Rooted (Magisk, KernelSU, etc).
- Minimum Linux Kernel: 3 ; Recommended Linux Kernel: 4 and above.
- A brains with a little knowledges about softwares and experiences.

## KNOW ISSUES AND FIXES
- On newest KernelSU manager (0.8.0+), module may failed to install after new KernelSU been reconstructed and use new spare image to store module - Fix by completely remove adb inside data folder of system root and reboot or clean install software/firmware/rom on device and update to newest KernelSU Manager.
- Some kernel parameters are unable to applied due to has been hardcode-locked by manufacturers or developer. This can be normal and not a serious problem.

## Install
1. Install in Magisk, KernelSU, etc.
2. Reboot and forget.
5. Have fun. :)

## CAUTION
- Do not install with any tweaks-relative modules as it can cause conflicts.

## TO BE INCLUDED
- None

## Credits and Notes
- [tytydrago](https://github.com/tytydraco/KTweak): Ktweak.
- [erenyeagarr](https://github.com/erenyeagarr/ThermalKiller-All-Devices-): Thermal Killer.
- [reiryuki](https://github.com/reiryuki/ZRAM-Swap-Configurator-Magisk-Module): ZRAM Swap Configurator.
- [topjohnwu](https://github.com/topjohnwu): Make Root (Magisk) with module-capable (with OverlayFS) possible.
- [tiann](https://github.com/tiann): Make kernel-based root with module-capable (with OverlayFS) possible.
- [osm0sis](https://github.com/osm0sis): AnyKernel, Flashable/Installable zips, scripts, bins, etc.


- If you do like my work, buy me a coffe or donate, I'll thank you later. :D
- You are free to fork my repo for your study or any other purposes, but MAKE SURE to add CREDITS or get rekt.
- I only accept reported issues with LOGCAT files, otherwise will be ignored and or closed.
