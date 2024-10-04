# Alist Install Script
[中文版](https://github.com/Zhang12334/Alist_install_bash/blob/main/README.md)

This project is an Alist installation script adapted for multiple architectures and various Linux kernel versions.

All files are from the official Alist release version (GitHub Release).

It comes with multiple built-in GitHub acceleration mirror sources and supports custom mirror sources.

Supports installation on Android Termux without root permissions.

After installation, a 20-character strong password is automatically generated using urandom and set as the Alist admin password.

Supports multiple architectures, various Linux kernel versions, and multiple systems (even runs on Android!).

# How to use?
SSH connect to your server or Termux openssh device, then run this command (currently only available in the Chinese version)<br>

```bash
bash <(curl -L https://ghp.ci/https://raw.githubusercontent.com/Zhang12334/Alist_install_bash/refs/heads/main/run.sh)
```

# CPU Architecture Usability Testing
Thank you to all the friends who participated in the testing and provided Linux machines with different architectures!
| Architecture | System           | Test Device  | Country/Region       | Install | Uninstall | Upgrade | Test Status | Provided by |
|--------------|------------------|--------------|----------------------|---------|-----------|---------|-------------|-------------|
| ArmV7L       | Armbian-23.02    | Onecloud     | Chinese mainland     | ✅      | ✅       | ✅      | ✅         | Zhang       |
| Aarch64      | Ubuntu-20.04     | Oracle ARM64 | Canada               | ✅      | ✅       | ✅      | ✅         | Zhang       |
| Aarch64      | Termux-MIUI10<br>(Android6.0) | VIVO Y67| Chinese mainland | ✅   | ✅      | ✅      | ✅         | Zhang       |
| X86_64       | Debian-12.6      | E5-2680V4    | Chinese mainland     | ✅      | ✅       | ✅      | ✅         | Zhang       |
| X86_64       | Debian-10.13     | i7-8700      | Luxembourg           | ✅      | ✅       | ✅      | ✅         | Zhang       |
| X86_64       | Debian-10        | E3-1245V2    | France               | ✅      | ✅       | ✅      | ✅         | Zhang       |
| X86_64       | ArchLinux        | G4400        | Chinese mainland     | ✅      | ✅       | ✅      | ✅         | Tingfeng    |
| x86_64       | Debian WSL2      | i5-9400F     | Chinese mainland     | ✅      | ✅       | ✅      | ✅         | ZeroWolf    |
| More to come |                  |              |                      |          |          |          |            |             |
