## INTRODUCTIONS
# Unified-Android-Tweaker
- An Android All-In-One, Universal, Customized Mods and Tweaks Root Module. Install, Reboot and Forget.
- Feature:
- Fine-tune Android System/User/Kernel Settings, Tunables and Parameters.
- Configurable ZRAM Swap Virtual Memory (Improve system performance and system multitaskings in some cases).
- Developed and designed for user-configurables.
- Non-intrusive and systemless.
- Open-Source complilance.

# System-Thermal-Modification
- Force System to use OS Kernel-Based Thermal Managements System while maintain device hardware safety.

## REQUIREMENTS/COMPATIBILITY
- Android 7 and/or Above.
- Linux Kernel 3 and/or Above.
- UNLOCKED BOOTLOADER and Installed ROOT (Magisk - Version 20 and Above, KernelSU, etc).
- Zygisk or similar supports if its better (Optional).
- Knowledges of technologies and experiences.
- Should work and only on any Android platforms/devices.

## DISCLAMERS
- USE THE ROOT MODULE AT YOUR OWN RISKS.
- DEVELOPERS ARE NOT TOOK RESPONSIBILITY FOR WHAT HAPPENED ONLY IF IS YOUR FAULTS.

## INSTALLATIONS
1. Install in Magisk, KernelSU, etc.
2. Reboot.
5. Have fun. :)

## CAUTIONS
- Don't install with any tweaks or mods relative root modules as it can cause conflicts.

## TROUBLESHOOTS - IF PROBLEMS OCCURED:
- Uninstall the Root Module within the given time before it boot service (120 seconds).
### Hardware Buttons Methods:
- Turn off the device, keep holding power button until it bootup twice and all Root Module will be automatically removed by Root (Magisk, KernelSU, etc).
### By ADB and Fastboot Commands:
1. Get the stock "boot.img" that right for your Android devices with it's Custom ROM OS.
2. Reboot to Fastboot/Bootloader Mode and do "fastboot flash boot <the boot.img> to "Boot" partition, or use Recovery Mode that allow to install it.
3. Reboot and to Setting, enable Developers Option, USB Debugging and Rooted Debugging.
4. Open and use Linux Terminal or any shell command with ADB capability.
5. Type and enter "adb root" and "adb shell"
6. Type and enter "cd /data/adb"
7. Type and enter "ls" (Not Is)
8. Type and enter "rm -r <enter_the_module_folder_if_it's_there> to execute the removal of that designated folders, including items in it. (Be caution with this).
9. Reboot to Fastboot/Bootloader or Recovery Mode and reflash the Root Tool then reboot and see the result.

## NOTES
- If you want Root Module not to modify any user system settings except others, unpack the Root Module and delete "system_settings.sh". Then save it and repack it before installations.
- I only accept reported issues with logcats files and other similar if is better, otherwise will be ignored and/or closed.
- I will try to keep module up-to-date as possible and you can support if you want, but yet I'm doing all this just for free and I'm being paid for it.
- I do not and never publish repositories and releases to any other websites such as Androidacy.
- If you do like my work, buy me a coffee or donate and I'll thank you later. :D
- You are free to fork the repository, but please MAKE SURE to add CREDITS or get rekt and don't forget to extract any archives that may necessary.

## Credits
- [tytydrago](https://github.com/tytydraco): KTweak.
- [reiryuki](https://github.com/reiryuki): ZRAM Swap Configurator.
- [topjohnwu](https://github.com/topjohnwu): MagiskROOT, Zygisk, Root Module Platforms, SuperUser and MagiskBOOT.
- [tiann](https://github.com/tiann): KernelSU ROOT and other features from Magisk.
- [osm0sis](https://github.com/osm0sis): Installable ZIPs and other stuffs.
- And to some unknows, Chinese guys or whoever it is for the "thermal-power" source codes and files.

- Since 8/30/2024