response=$(curl -s https://api.github.com/repos/Zhang12334/Alist_install_bash/releases/latest)
version=$(echo "$response" | grep 'tag_name' | cut -d'"' -f4 | awk '{print substr($0, 2, length($0) - 1)'})
download_url=https://github.com/Zhang12334/Alist_install_bash/releases/download/v$version/install.sh


download_url=https://raw.githubusercontent.com/Zhang12334/Alist_install_bash/refs/heads/main/install.sh


clear
echo "请选择是否使用Github加速地址"
echo "1. 使用 https://ghp.ci/"
echo "2. 使用 https://ghproxy.net/"
echo "3. 使用 https://ghproxy.cn/"
echo "4. 使用 https://github.moeyy.xyz/"
echo "5. 使用 https://gh.llkk.cc/"
echo "6. 不使用加速地址"
echo
echo -n "请输入你的选择: "
read choice1
if [ "$choice1" -eq 1 ]; then
    useproxy="https://ghp.ci/"
elif [ "$choice1" -eq 2 ]; then
    useproxy="https://ghproxy.net/"
elif [ "$choice1" -eq 3 ]; then
    useproxy="https://ghproxy.cn/"    
elif [ "$choice1" -eq 4 ]; then
    useproxy="https://github.moeyy.xyz/"
elif [ "$choice1" -eq 5 ]; then
    useproxy="https://gh.llkk.cc/"    
elif [ "$choice1" -eq 6 ]; then
    useproxy=""
fi
clear
echo "请选择操作："
echo "1. 安装"
echo "2. 卸载"
echo "3. 升级"
echo -n "请输入你的选择: "
read choice
if [ "$choice" -eq 1 ]; then
    curl -fsSL -L -H "Cache-Control: no-cache" "$useproxy$download_url" | bash -s install $useproxy
elif [ "$choice" -eq 2 ]; then
    curl -fsSL -L -H "Cache-Control: no-cache" "$useproxy$download_url" | bash -s uninstall
elif [ "$choice" -eq 3 ]; then
    curl -fsSL -L -H "Cache-Control: no-cache" "$useproxy$download_url" | bash -s update $useproxy
else
    echo "无效的选择，请输入1-3的数字"
    exit 1
fi
#部分借鉴于：https://www.cnblogs.com/dingshaohua/p/17551097.html
