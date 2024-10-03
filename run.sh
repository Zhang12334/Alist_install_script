response=$(curl -s https://api.github.com/repos/Zhang12334/Alist_install_bash/releases/latest)
version=$(echo "$response" | grep 'tag_name' | cut -d'"' -f4 | awk '{print substr($0, 2, length($0) - 1)'})
download_url=https://github.com/Zhang12334/Alist_install_bash/releases/download/v$version/install.sh

clear
echo "请选择操作："
echo "1. 安装"
echo "2. 卸载"
echo "3. 升级"
echo -n "请输入你的选择: "
read choice
if [ "$choice" -eq 1 ]; then
    curl -fsSL -L "$download_url" | bash -s install
elif [ "$choice" -eq 2 ]; then
    curl -fsSL -L "$download_url" | bash -s uninstall
elif [ "$choice" -eq 3 ]; then
    curl -fsSL -L "$download_url" | bash -s update
else
    echo "无效的选择，请输入1-3的数字"
fi
#部分借鉴于：https://www.cnblogs.com/dingshaohua/p/17551097.html
