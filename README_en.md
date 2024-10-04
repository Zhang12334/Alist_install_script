# Alist_install_bash
[中文版](https://github.com/Zhang12334/Alist_install_bash/blob/main/README.md)<br>
This project is an Alist installation script adapted for multi-architecture Linux kernel systems<br>
All files are from the official Alist release version (GitHub Release)<br>
Built-in with multiple GitHub acceleration mirror sources, supports custom acceleration mirror sources<br>
After installation, a 20-character strong password is automatically generated using urandom and set as the Alist admin password<br>
Supports multiple architectures and Linux kernel systems (even Android!)<br>
# How to use?
SSH connect to your server or Termux openssh device, then run this command (currently only available in the Chinese version)<br>
```bash
bash <(curl -L https://ghp.ci/https://raw.githubusercontent.com/Zhang12334/Alist_install_bash/refs/heads/main/run.sh)
```
# CPU Architecture Usability Testing
Thank you to all the friends who participated in the testing and provided Linux machines with different architectures!
| Architecture | System           | Test Device  | Country/Region        | Install | Uninstall | Upgrade | Test Status | Provided by |
|--------------|------------------|--------------|-----------------------|---------|-----------|---------|-------------|-------------|
| ArmV7L       | Armbian-23.02     | Wankeyun     | Mainland China        | ✅      | ✅        | ✅      | ✅          | Zhang       |
| Aarch64      | Ubuntu-20.04      | Oracle ARM64 | Canada                | ✅      | ✅        | ✅      | ✅          | Zhang       |
| Aarch64      | Termux-MIUI10<br>(Android6.0) | VIVO Y67     | Mainland China        | ✅      | ✅        | ✅      | ✅          | Zhang       |
| X86_64       | Debian-12.6       | E5-2680V4    | Mainland China        | ✅      | ✅        | ✅      | ✅          | Zhang       |
| X86_64       | Debian-10.13      | i7-8700      | Luxembourg            | ✅      | ✅        | ✅      | ✅          | Zhang       |
| X86_64       | Debian-10         | E3-1245V2    | France                | ✅      | ✅        | ✅      | ✅          | Zhang       |
| X86_64       | ArchLinux         | G4400        | Mainland China        | ✅      | ✅        | ✅      | ✅          | Tingfeng    |
| x86_64       | Debian WSL2       | i5-9400F     | Mainland China (HK VPN)| ✅        |    ✅       |      ✅   |      ✅      | ZeroWolf    |
| More to come |                  |              |                       |         |           |         |             |             |
