# Alist_install_bash
本项目为适配了多架构Linux系统的Alist安装脚本<br>
全部文件均来自Alist官方发布版本（Github Release）<br>
内置多个Github加速镜像源，支持自定义加速镜像源<br>
安装后自动使用urandom生成20位强密码并设置为Alist admin密码<br>
支持多架构、多Linux版本<br>
使用方式：SSH连接服务器后执行下方命令<br>
bash <(curl -L https://ghp.ci/https://raw.githubusercontent.com/Zhang12334/Alist_install_bash/refs/heads/main/run.sh) <br>
| 架构      | 系统           | 测试设备    | 国家/地区     |安装功能|卸载功能|升级功能|测试状态|机器提供者|
|-----------|----------------|--------------|---------------|-------|-------|--------|-------|----------|
| ArmV7L    | Armbian-23.02  | 玩客云       | 中国大陆      | ✅    | ✅    | ✅    | ✅    | Zhang   |
| Aarch64   | Ubuntu-20.04   | Oracle ARM64 | 加拿大        | ✅    | ✅    | ✅    | ✅    | Zhang   |
| X86_64    | Debian-12.6    | E5-2680V4    | 中国大陆      | ✅    | ✅    | ✅    | ✅    | Zhang   |
| X86_64    | Debian-10.13   | i7-8700      | 卢森堡        | ✅    | ✅    | ✅    | ✅    | Zhang   |
| X86_64    | Debian-10      | E3-1245V2    | 法国          | ✅    | ✅    | ✅    | ✅    | Zhang   |
| X86_64    | ArchLinux      | G4400        | 中国大陆      | ✅    | ✅    | ✅    | ✅    | 听风    |
| 欢迎补充  |                |              |               |        |       |        |       |         |
| 欢迎补充  |                |              |               |        |       |        |       |         |
