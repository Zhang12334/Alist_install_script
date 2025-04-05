# Alist Install Script
[English Version](https://github.com/Zhang12334/Alist_install_bash/blob/main/README_en.md)

本项目是一个适配了多架构、多Linux内核版本的Linux Alist安装脚本

全部文件均来自Alist官方发布版本（Github Release）

内置多个Github加速镜像源，支持自定义加速镜像源

支持使用Android Termux在无root权限的情况下进行安装

安装后自动使用urandom生成20位强密码并设置为Alist admin密码

支持多架构、多Linux内核版本、多系统运行（甚至Android也能跑!）

# 使用方式
SSH连接服务器后执行下方命令<br>
```bash
bash <(curl -L https://raw.githubusercontent.com/Zhang12334/Alist_install_bash/refs/heads/main/run.sh)
```

# 可用性测试
感谢所有参与测试、提供不同架构系统Linux机器的朋友！
| 架构      | 系统           | 测试设备    | 国家/地区     |安装功能|卸载功能|升级功能|测试状态|机器提供者|
|-----------|----------------|--------------|---------------|-------|-------|--------|-------|----------|
| ArmV7L    | Armbian-23.02  | 玩客云       | 中国大陆       | ✅    | ✅    | ✅    | ✅    | Zhang   |
| Aarch64   | Ubuntu-20.04   | Oracle ARM64 | 加拿大        | ✅    | ✅    | ✅    | ✅    | Zhang   |
| Aarch64   |Termux-MIUI10<br>(Android6.0)|VIVO Y67| 中国大陆| ✅   | ✅    | ✅    | ✅    | Zhang   |
| X86_64    | Debian-12.6    | E5-2680V4    | 中国大陆      | ✅    | ✅    | ✅    | ✅    | Zhang   |
| X86_64    | Debian-10.13   | i7-8700      | 卢森堡        | ✅    | ✅    | ✅    | ✅    | Zhang   |
| X86_64    | Debian-10      | E3-1245V2    | 法国          | ✅    | ✅    | ✅    | ✅    | Zhang   |
| X86_64    | ArchLinux      | G4400        | 中国大陆      | ✅    | ✅    | ✅    | ✅    | 听风    |
| x86_64    | Debian WSL2    | i5-9400F     |中国大陆       | ✅    | ✅    | ✅    | ✅    | ZeroWolf|
| 欢迎补充  |                |              |               |        |       |        |       |         |

## Stargazers over time
[![Stargazers over time](https://starchart.cc/Zhang12334/Alist_install_script.svg?variant=adaptive)](https://starchart.cc/Zhang12334/Alist_install_script)
