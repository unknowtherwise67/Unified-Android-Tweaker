## Introduction 
# Unified Android Tweaker
A unified module consist of 3 core scripts forked from modules: tytydraco Ktweak, Thermal Killer and ZRAM Swap Configuration.
Re-modified and re-configured into one convenient package.

Feature:
- Fine-tune system kernel parameters with best setting, this has done by experienced kernel developers.
- Locate, modified found configs files into .bck (ex: msm_thermal.bck) or relocate files to the folder of the installed module. This will force system to use thermal system in kernel as default. No harm done on system file, modified file will be reinstated to original after uninstall module.
- Module will configure and resize ZRAM to 100% of actual installed RAM size during device boot. It swap memory on RAM, faster than swap memory on Storage/Disk.
- Module should work on any Android device (Tablets and Smartphones only) based on Linux Kernel along with installed root with module capablity.

## DISCLAMER
- USE THIS MODULE AT YOUR OWN RISKS
- DEVELOPERS OF THIS MODULE ARE NOT TOOK RESPONSIBILITY FOR ANYHING THAT HAPPENS

## REQUIREMENT

- 1Ghz of ANDROID Device Processor/APU
- 1GBs of RAM, 4GBs of STORAGE/ROM
- UNLOCKED BOOTLOADER, any installed root with module capablity
- Minimum Linux Kernel: 3+ ; Recommended Linux Kernel: 4+
- A brains with a little knowledges about softwares and experiences

## KNOW ISSUES

- On newest KernelSU manager (0.8.0+), module may failed to install after new KernelSU been reconstructed and use new spare image to store module. User may stop updating and stay on old manager version for now until new solution is found.

- Some tweak paramter may failed to apply, this may because some of them is hardcode-locked by developers or manufacturers.

## Install

1. Install in any installed root manager with module capablity.
2. Reboot and forget.
5. Have fun. :)

## CAUTION

- Do not install with any tweaks-relative modules as it cause some conflicts.

## TO BE INCLUDED

- Will add support for update throught root module manager soon.

## Credits 

- [tytydrago](https://github.com/tytydraco/KTweak): For the original Ktweak.
- [erenyeagarr](https://github.com/erenyeagarr/ThermalKiller-All-Devices-): Thermal Killer.
- [reiryuki](https://github.com/reiryuki/ZRAM-Swap-Configurator-Magisk-Module): ZRAM Swap Configurator.
- [topjohnwu](https://github.com/topjohnwu): Make new Root (Magisk) with module possible.
- [tiann](https://github.com/tiann): Make new kernel-based root with module-capable possible.
- [osm0sis](https://github.com/osm0sis): For AnyKernel.

- If you do like my work, buy me a coffe or donate, I'll thank you later. :D
