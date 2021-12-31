# VSCode Android

A simple batch script that installs and runs VSCode in your non-rooted Android phone in Termux

## Overview

As we all know, VSCode runs only in Mac, Windows, and Linux computers, excluding Android. But actually you can run VSCode in Android without rooting or jailbreaking your phone. How can this be possible?

You can host a VSCode-like software ported into a server by using the open-source project code-server, which supports many platforms.

In Android, the tool Termux makes us run Linux shell. We can run code-server in termux but we need to install a proot-compatible os, so that no weird errors may come-up when running VSCode.

This bash script will help you install VSCode in Termux.

## Requirements / Things to Do Before Installation

### I. Termux First Setup
(Skip this part you already installed and setup Termux)

#### 1. Make sure your device has Termux app installed, from F-Droid Store.

  PlayStore version no longer receives future updates from Termux devs.

#### 2. Update the termux repositories first by:

  ```sh
  pkg update && pkg upgrade -y
  ```
  
#### 3. (Optional) Allow Termux to access your phone storage
If you want to read, edit, modify files from your sdcard in vscode, you have to grant termux storage access by:

  ```sh
  termux-setup-storage
  ```
  
#### 4. (Optional) Allow Termux to run in background
In order to make vscode instance to at last longer, you have to enable wake-lock.

Note: Every time you want run vscode, you have to set this first.

  ```sh
  termux-wake-lock
  ```
  
### II. Installing Chroot-based Distro
(Skip this part if you already have proot-distro utility or if you have chroot-based distros from apps like AnLinux or if you want to use your own chroot-based distro)

There are 3 options available:

1. Install and manage your distro using proot-distro utility (RECOMMENDED) (EASY)
2. Install distro manually by commands provided by apps like AnLinux (BIT DIFFICULT)
3. Install your own custom chroot-based distro on your own (DIFFICULT)

This guide follows installation of proot-distro utility, as it is very easy and less hassle.


#### 1. Install Proot Utilities
```sh
pkg install proot proot-distro -y
```

Once done, a new command, proot-distro is now available. Try `proot-distro help` in command line.

#### 2. Install a Distro
Now, it depends your personal choice. You can install Ubuntu, Debian and any other distro.

In this guide, install Ubuntu (RECOMMENDED):
```sh
proot-distro install ubuntu
```

Once done, you can login with your distro by `proot-distro login ubuntu`.

#### 3. Update your distro
Once login, enter command:
```sh
apt update && apt upgrade -y
``` 

#### 4. Install missing useful utilities
The distro may not be fully complete. You have to install it manually. It may be missing with like `wget` utility.

## Installing code-server

#### 1. Login to your distro
```sh
proot-distro login ubuntu
```

#### 2. Download the installer.sh in this repository
  ```sh
  wget https://github.com/JavesBastatas/android-vscode-installer/vscode-installer.sh
  ```

#### 3. Give executable permission to the script
```sh
chmod +x ./vscode-installer.sh
```
#### 4. Run it
```sh
./vscode-installer.sh
```

#### 5. Test it out!
```sh
code-server
```

By default, a server in port 8080 will be available to localhost/127.0.0.1. 
