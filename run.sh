#!/bin/bash

# 获取最新版本信息
response=$(curl -s https://api.github.com/repos/Zhang12334/Alist_install_bash/releases/latest)
version=$(echo "$response" | grep 'tag_name' | cut -d'"' -f4 | awk '{print substr($0, 2, length($0) - 1)}')

# 下载地址
#download_url="https://github.com/Zhang12334/Alist_install_bash/releases/download/v$version/install.sh"

download_url="https://raw.githubusercontent.com/Zhang12334/Alist_install_bash/refs/heads/main/install.sh"

# 清屏
clear
echo "请选择是否使用Github加速地址"
echo "1. 使用 https://ghp.ci/"
echo "2. 使用 https://ghproxy.net/"
echo "3. 使用 https://ghproxy.cn/"
echo "4. 使用 https://github.moeyy.xyz/"
echo "5. 使用 https://gh.llkk.cc/"
echo "6. 不使用加速地址"
echo
read -p "请输入你的选择: " choice1

# 根据用户选择设置代理
case "$choice1" in
    1) useproxy="https://ghp.ci/" ;;
    2) useproxy="https://ghproxy.net/" ;;
    3) useproxy="https://ghproxy.cn/" ;;
    4) useproxy="https://github.moeyy.xyz/" ;;
    5) useproxy="https://gh.llkk.cc/" ;;
    6) useproxy="" ;;
    *) 
        echo "无效的选择，默认使用不加速地址"
        useproxy="" 
        ;;
esac

# 清屏
clear
echo "请选择操作："
echo "1. 安装"
echo "2. 卸载"
echo "3. 升级"
echo -n "请输入你的选择: "
read choice

# 执行相应操作
case "$choice" in
    1) 
        echo "正在安装..."
        curl -fsSL -L -H "Cache-Control: no-cache" "https://ghp.ci/$download_url" | bash -s install "$useproxy"
        ;;
    2) 
        echo "正在卸载..."
        curl -fsSL -L -H "Cache-Control: no-cache" "https://ghp.ci/$download_url" | bash -s uninstall
        ;;
    3) 
        echo "正在升级..."
        curl -fsSL -L -H "Cache-Control: no-cache" "https://ghp.ci/$download_url" | bash -s update "$useproxy"
        ;;
    *) 
        echo "无效的选择，请输入1-3的数字"
        exit 1 
        ;;
esac

# 脚本结束
