# Alist_install_bash
本项目为适配了多架构Linux系统的Alist安装脚本（主要为玩客云开发）<br>
全部文件均来自Alist官方发布版本（Github Release）<br>
内置多个Github加速镜像源，支持自定义加速镜像源<br>
使用方式：SSH连接服务器后执行下面这一行<br>
bash <(curl -L https://ghp.ci/https://raw.githubusercontent.com/Zhang12334/Alist_install_bash/refs/heads/main/run.sh) <br>
| 架构               | 系统     | 测试设备   | 国家/地区           | 测试状态 |
|--------------------|----------|--------------|---------------------|----------|
| ArmV7L             | Armbian-23.02  | 玩客云       |    中国大陆                 | ✅       |
| Aarch64            | Ubuntu-20.04   | Oracle ARM64 |      加拿大               | ✅       |
| X86_64             | Debian-12.6   | E5-2680V4    |       中国大陆              | ✅       |
| 欢迎补充           |          |              |                     |          |

