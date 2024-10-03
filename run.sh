# 使用GitHub API获取最新的发行版信息（里边有最新的版本号标识）
response=$(curl -s https://api.github.com/repos/Zhang12334/Alist_install_bash/releases/latest)

# 提取下载链接 （tag_name属性即为版本号属性 cut命令获取版本号属性的值 awk命令把版本号中的v字符删除）
version=$(echo "$response" | grep 'tag_name' | cut -d'"' -f4 | awk '{print substr($0, 2, length($0) - 1)'})

# 拼接下载连接
download_url=https://github.com/Zhang12334/Alist_install_bash/releases/download/v$version/install.sh

# 使用curl下载最新release脚本
curl -fsSL -L "$download_url" | bash -s install

#借鉴于：https://www.cnblogs.com/dingshaohua/p/17551097.html
