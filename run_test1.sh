#!/bin/bash
#本版本为未经测试的beta版本，非必要请勿使用
#本脚本链接:    bash <(curl -L https://ghp.ci/https://raw.githubusercontent.com/Zhang12334/Alist_install_bash/refs/heads/main/run_test.sh)
# 下载地址
# download_url="Zhang12334/Alist_install_bash/releases/latest/download/install.sh"
download_url="https://raw.githubusercontent.com/Zhang12334/Alist_install_bash/refs/heads/main/install_test.sh"
#测试文件地址
test_file_url="https://github.com/Zhang12334/test_ghmirror/releases/latest/download/test.txt"

# 清屏
clear
echo "请选择要使用的Github加速地址"
echo "1. 使用 ghp.ci [ 推荐 ]"
echo "2. 使用 ghproxy.net"
echo "3. 使用 ghproxy.cn"
echo "4. 使用 github.moeyy.xyz"
echo "5. 使用 gh.llkk.cc [ 推荐 ]"
echo "6. 自定义加速地址"
echo "7. 不使用加速地址"
echo
read -p "请输入你的选择: " choice1

# 根据用户选择设置代理
case $choice1 in
    1) useproxy="https://ghp.ci/" ;;
    2) useproxy="https://ghproxy.net/" ;;
    3) useproxy="https://ghproxy.cn/" ;;
    4) useproxy="https://github.moeyy.xyz/" ;;
    5) useproxy="https://gh.llkk.cc/" ;;
    6) 
        read -p "请输入自定义加速地址（例：https://ghp.ci/）: " custom_proxy
        # 验证自定义加速地址是否有效
        if curl -fsSL "${custom_proxy}${test_file_url}" | grep -q "114514"; then
            rm -f test.txt
            useproxy="${custom_proxy}"
            echo "已选择自定义加速地址: $custom_proxy"
        else
            rm -f test.txt
            echo "自定义加速地址无效，自动使用ghp.ci加速地址"
            useproxy="https://ghp.ci/" 
        fi
        ;;
    7) useproxy="" ;;
    *) 
        echo "无效的选择，默认使用ghp.ci加速地址"
        useproxy="https://ghp.ci/" 
        ;;
esac
echo
echo "请选择操作："
echo "1. 安装"
echo "2. 卸载"
echo "3. 升级"
echo -n "请输入你的选择: "
read choice
case "$choice" in
    1) 
        read -p "请输入要安装的版本，留空默认安装最新版（例: 3.2.0）：" version
        version=${version:-latest}
        MIN_VERSION="3.0.0"
        CURRENT_VERSION=$version
        # 检查是否为 *.*.* 格式
        is_valid_version_format() {
          [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] && return 0 || return 1
        }        
        # 比较版本号
        version_ge() {
          # 将版本号的每个部分用 '.' 分割并逐个比较
          [[ "$1" == "$2" ]] && return 0
          local IFS=.
          local i ver1=($1) ver2=($2)
          for ((i=0; i<${#ver1[@]}; i++)); do
            [[ ${ver1[i]} -gt ${ver2[i]} ]] && return 0
            [[ ${ver1[i]} -lt ${ver2[i]} ]] && return 1
          done
          return 0
        }
        if [[ "$CURRENT_VERSION" == "latest" ]]; then
          echo "未输入内容，将安装最新版"
        elif ! is_valid_version_format "$CURRENT_VERSION"; then
          echo "无效版本号格式，必须为 *.*.* 形式（例如 3.2.0）"
          exit 1
        elif ! version_ge "$CURRENT_VERSION" "$MIN_VERSION"; then
          echo "无效版本号，必须大于等于 $MIN_VERSION"
          exit 1
        fi
        echo "正在下载安装脚本..."
        curl -fsSL -L "${useproxy}${download_url}" | bash -s install $useproxy $version
        ;;
    2) 
        echo "正在下载卸载脚本..."
        curl -fsSL -L "${useproxy}${download_url}" | bash -s uninstall
        ;;
    3) 
        echo "请输入要升级到的版本，留空默认升级最新版"
        echo "理论可通过本选项进行降级，降级操作前请先备份数据！"
        read -p "请输入（例: 3.2.0）：" version
        version=${version:-latest}
        MIN_VERSION="3.0.0"
        CURRENT_VERSION=$version
        # 检查是否为 *.*.* 格式
        is_valid_version_format() {
          [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] && return 0 || return 1
        }
        # 比较版本号
        version_ge() {
          # 将版本号的每个部分用 '.' 分割并逐个比较
          [[ "$1" == "$2" ]] && return 0
          local IFS=.
          local i ver1=($1) ver2=($2)
          for ((i=0; i<${#ver1[@]}; i++)); do
            [[ ${ver1[i]} -gt ${ver2[i]} ]] && return 0
            [[ ${ver1[i]} -lt ${ver2[i]} ]] && return 1
          done
          return 0
        }
        if [[ "$CURRENT_VERSION" == "latest" ]]; then
          echo "未输入内容，将升级为最新版"
        elif ! is_valid_version_format "$CURRENT_VERSION"; then
          echo "无效版本号格式，必须为 *.*.* 形式（例如 3.2.0）"
          exit 1
        elif ! version_ge "$CURRENT_VERSION" "$MIN_VERSION"; then
          echo "无效版本号，必须大于等于 $MIN_VERSION"
          exit 1
        fi
        echo "正在下载升级脚本..."
        curl -fsSL -L "${useproxy}${download_url}" | bash -s update $useproxy $version
        ;;
    *) 
        echo "无效的选择，请输入1-3的数字"
        exit 1 
        ;;
esac
