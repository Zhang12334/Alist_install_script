#!/bin/bash

#安装版本设置为传参
download_VERSION=$3

#新增termux检测
is_termux=0
if [ -d "/data/data/com.termux" ]; then
   is_termux=1
fi


#固定安装路径

INSTALL_PATH='/opt/alist'

#颜色部分

RED_COLOR='\e[1;31m'
GREEN_COLOR='\e[1;32m'
YELLOW_COLOR='\e[1;33m'
BLUE_COLOR='\e[1;34m'
PINK_COLOR='\e[1;35m'
SHAN='\e[1;33;5m'
RES='\e[0m'

# 获取架构
if command -v arch >/dev/null 2>&1; then
  platform=$(arch)
else
  platform=$(uname -m)
fi

ARCH="UNKNOWN"

#架构判断

if [ "$platform" = "x86_64" ]; then
  ARCH=musl-amd64
elif [ "$platform" = "i386" ]; then
  ARCH=386
elif [ "$platform" = "i686" ]; then
  ARCH=386
elif [ "$platform" = "armv5" ]; then
  ARCH=armv5
elif [ "$platform" = "armv6" ]; then
  ARCH=armv6
elif [ "$platform" = "armv7" ]; then
  ARCH=armv7
elif [ "$platform" = "aarch64" ]; then
  ARCH=musl-arm64
elif [ "$platform" = "mips" ]; then
  ARCH=musl-mips
elif [ "$platform" = "mips64" ]; then
  ARCH=musl-mips64
elif [ "$platform" = "mips64le" ]; then
  ARCH=musl-mips64le
elif [ "$platform" = "mipsle" ]; then
  ARCH=musl-mipsle  
elif [ "$platform" = "ppc64le" ]; then
  ARCH=musl-ppc64le
elif [ "$platform" = "riscv64" ]; then
  ARCH=riscv64
elif [ "$platform" = "s390x" ]; then
  ARCH=musl-s390x
elif [ "$platform" = "arm" ]; then
  ARCH=musleabi-arm
elif [ "$platform" = "armel" ]; then
  ARCH=musleabi-armel
elif [ "$platform" = "armv5l" ]; then
  ARCH=musleabi-armv5l
elif [ "$platform" = "armv7m" ]; then
  ARCH=musleabi-armv7m
elif [ "$platform" = "armv7l" ]; then
  ARCH=musleabihf-armv7l
elif [ "$platform" = "armv7r" ]; then
  ARCH=musleabihf-armv7r
fi

GH_PROXY="$2"

#各种检查
if [ "$is_termux" -eq 1 ]; then
    INSTALL_PATH='/data/data/com.termux/files/home/alist_files'
else
	if [ "$(id -u)" != "0" ]; then
	  echo -e "\r\n${RED_COLOR}出错了，本脚本仅支持 root 权限执行\r\n请使用 root 权限重试！${RES}\r\n" 1>&2
	  exit 1
	elif [ "$ARCH" == "UNKNOWN" ]; then
	  echo -e "\r\n${RED_COLOR}出错了${RES}，一键安装目前仅支持主流Linux架构\r\n当前架构：$platform\r\n如确定为Alist存在发行版的架构请附带此截图提交Issue!\r\nGithub仓库地址：https://github.com/zhang12334/alist_install_bash\r\n" 1>&2
	  exit 1
	elif ! command -v systemctl >/dev/null 2>&1; then
	  echo -e "\r\n${RED_COLOR}出错了${RES}，你当前系统未安装systemctl，建议参考官网手动安装！r\n" 1>&2
	  exit 1
	else
	  if command -v netstat >/dev/null 2>&1; then
	    check_port=$(netstat -lnp | grep 5244 | awk '{print $7}' | awk -F/ '{print $1}')
	  else
	    echo -e "${GREEN_COLOR}端口检查 ...${RES}"
	    if command -v yum >/dev/null 2>&1; then
	      yum install net-tools -y >/dev/null 2>&1
	      check_port=$(netstat -lnp | grep 5244 | awk '{print $7}' | awk -F/ '{print $1}')
	    else
	      apt-get update >/dev/null 2>&1
	      apt-get install net-tools -y >/dev/null 2>&1
	      check_port=$(netstat -lnp | grep 5244 | awk '{print $7}' | awk -F/ '{print $1}')
	    fi
	  fi
	fi
fi

CHECK() {
  #存在alist程序
  if [ -f "$INSTALL_PATH/alist" ]; then
    echo "此位置已经安装，请选择其他位置，或使用更新命令"
    exit 0
  fi

  
  #有端口占用了
  if [ $check_port ]; then
    #提示用户是否kill
    echo -e "5244端口已占用，是否kill掉使用该端口的程序？"
    echo -e "kill请输入1，不kill并退出安装脚本请输入0"
    echo
    
    # 读取输入
    read kill_or_not_kill
    
    # 判断
    if [ "$kill_or_not_kill" -eq 1 ]; then
      kill -9 $check_port
      echo -e "已选择kill使用5244端口的程序"
    elif [ "$kill_or_not_kill" -eq 0 ]; then
      echo -e "已取消kill端口并退出脚本"
      exit 1
    else
      echo -e "输入无效，已取消kill端口并退出脚本"
      exit 1
    fi
  fi
  
  #不存在目录，创建一个
  if [ ! -d "$INSTALL_PATH/" ]; then
    mkdir -p $INSTALL_PATH
  else
    rm -rf $INSTALL_PATH && mkdir -p $INSTALL_PATH
  fi
  
  if [ ! -d "$INSTALL_PATH/downloadtmp" ]; then
    mkdir -p $INSTALL_PATH/downloadtmp
  else
    rm -rf $INSTALL_PATH/downloadtmp && mkdir -p $INSTALL_PATH/downloadtmp
  fi
}


#安装部分

INSTALL() {
  clear
  # 下载 Alist 程序
  if [ "$is_termux" -eq 1 ]; then
    echo "检测到正在Termux环境中运行，正在使用无需 root 权限的方式安装..."
  fi
  echo -e "${GREEN_COLOR}下载 Alist $download_VERSION ...${RES}"
  #新增支持自定义版本
  if [ "$download_VERSION" == "latest" ]; then
      curl -L -H 'Cache-Control: no-cache' ${GH_PROXY}https://github.com/alist-org/alist/releases/latest/download/alist-linux-${ARCH}.tar.gz -o $INSTALL_PATH/downloadtmp/alist.tar.gz $CURL_BAR
  else
      curl -L -H 'Cache-Control: no-cache' ${GH_PROXY}https://github.com/alist-org/alist/releases/download/v${download_VERSION}/alist-linux-${ARCH}.tar.gz -o $INSTALL_PATH/downloadtmp/alist.tar.gz $CURL_BAR
  fi
  tar zxf $INSTALL_PATH/downloadtmp/alist.tar.gz -C $INSTALL_PATH/
  if [ -f $INSTALL_PATH/alist ]; then
    echo -e "${GREEN_COLOR} alist-linux-$ARCH.tar.gz 下载成功 ${RES}"
  else
	if [ "$download_VERSION" == "latest" ]; then
		echo -e "${RED_COLOR} alist-linux-$ARCH.tar.gz 下载失败，请检查你的网络状况或尝试更换加速源！${RES}"
	else
		echo -e "${RED_COLOR} v${download_VERSION} 版 alist-linux-$ARCH.tar.gz 下载失败，请检查你的网络、尝试更换加速源或检查安装版本号是否有效！${RES}"
	fi
    exit 1
  fi
  # 删除下载缓存
  rm -f $INSTALL_PATH/downloadtmp/alist*
}

# 安装初始化部分
INIT() {
  if [ ! -f "$INSTALL_PATH/alist" ]; then
    echo -e "\r\n${RED_COLOR}出错了${RES}，当前系统未安装 Alist\r\n"
    exit 1
  else
    #删除database
    rm -f $INSTALL_PATH/alist.db
  fi

if [ "$is_termux" -eq 0 ]; then
#普通系统方法
# 创建 systemd
  cat >/etc/systemd/system/alist.service <<EOF
[Unit]
Description=Alist service
Wants=network.target
After=network.target network.service

[Service]
Type=simple
WorkingDirectory=$INSTALL_PATH
ExecStart=$INSTALL_PATH/alist server
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

  # 重载systemctl并添加开机启动
  systemctl daemon-reload
  systemctl enable alist >/dev/null 2>&1

else
  #termux方法
  # 创建启动脚本
  cat >/data/data/com.termux/files/home/start_alist.sh <<EOF
nohup $INSTALL_PATH/alist server &
EOF
  # 创建停止脚本
  cat >/data/data/com.termux/files/home/stop_alist.sh <<EOF
alist_pid=$(pgrep -f "alist")\n\nkill $alist_pid\n\necho "Alist 已停止！"
EOF
  chmod +x /data/data/com.termux/files/home/start_alist.sh
  chmod +x /data/data/com.termux/files/home/stop_alist.sh
fi
}

SUCCESS() {
  ipv6_address=$(ip -6 addr show | grep 'inet6' | awk '{print $2}' | cut -d'/' -f1 | grep -v '^::1$' | sort | head -n 1)
  ipv6_address_out=$(curl -6 -s 6.ipw.cn)
  ipv4_address=$(ip -4 addr show | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1 | grep -v '^127\.0\.0\.1$' | sort -V | head -n 1)
  ipv4_address_out=$(curl -4 -s 4.ipw.cn)
  cd $INSTALL_PATH
  adminpwd=$(< /dev/urandom tr -dc 'A-Za-z0-9!@#$%^&*()-_=+' | head -c 20)
  ./alist admin set $adminpwd > /dev/null 2>&1 &
  clear
  echo "Alist 安装成功！"
  echo
  echo -e "${GREEN_COLOR}IPV6访问地址（本机获取）：${GREEN_COLOR}http://[$ipv6_address]:5244/"
  echo -e "IPV4访问地址（本机获取）：${GREEN_COLOR}http://$ipv4_address:5244/"
  
  if [ -z "$ipv6_address_out" ]; then
    echo -e "IPV6访问地址（出口IP）：${GREEN_COLOR}本机不支持IPV6网络"
  else
    echo -e "IPV6访问地址（出口IP）：${GREEN_COLOR}http://[$ipv6_address_out]:5244/"
  fi
  if [ -z "$ipv4_address_out" ]; then
    echo -e "IPV4访问地址（出口IP）：${GREEN_COLOR}本机不支持IPV4网络"
  else
    echo -e "IPV4访问地址（出口IP）：${GREEN_COLOR}http://$ipv4_address_out:5244/"
  fi
  
  echo
  echo -e "配置文件路径：${GREEN_COLOR}$INSTALL_PATH/data/config.json${RES}"
  echo -e "-----------使用说明----------"
  echo -e "Alist账号名称：admin"
  echo -e "自动生成强密码：$adminpwd"
  echo -e "程序使用urandom生成20位强密码"
  echo -e "本密码仅显示一次，请妥善保存！"  
  echo -e "请勿泄漏本界面内容给任何人！！"  
  echo -e "---------密码更改方式--------"  
  echo -e "先cd到alist所在目录:"
  echo -e "${GREEN_COLOR}cd $INSTALL_PATH${RES}"
  echo -e "随机设置新密码:"
  echo -e "${GREEN_COLOR}./alist admin random${RES}"
  echo -e "或者手动设置新密码:"
  echo -e "${GREEN_COLOR}./alist admin set ${RES}${RED_COLOR}NEW_PASSWORD${RES}"
  echo -e "----------------------------"
  if [ "$is_termux" -eq 0 ]; then
  #普通Linux机器
    #重启Alist
    systemctl restart alist

    echo
    echo -e "查看状态：${GREEN_COLOR}systemctl status alist${RES}"
    echo -e "启动服务：${GREEN_COLOR}systemctl start alist${RES}"
    echo -e "重启服务：${GREEN_COLOR}systemctl restart alist${RES}"
    echo -e "停止服务：${GREEN_COLOR}systemctl stop alist${RES}"
  else
  #Termux内
    echo -e "${GREEN_COLOR}启动服务：在默认目录下执行 ./start_alist，随后 Alist 将在后台运行！${RES}"
    echo -e "${GREEN_COLOR}停止服务：在默认目录下执行 ./stop_alist"
    echo -e "由于Termux特殊环境问题，暂不支持自动启动！关闭或重启后需要手动开启服务！"
    echo
    echo -e "${GREEN_COLOR}Alist 正在启动中 ..."
    bash /data/data/com.termux/files/home/start_alist.sh
    echo -e "${GREEN_COLOR}Alist 启动完成！"
  fi
  echo -e "\r\n温馨提示：如果端口无法正常访问，请检查 \033[36m服务器安全组、本机防火墙、Alist状态\033[0m"
  echo
}

#卸载
UNINSTALL() {
  clear
  echo -e "${GREEN_COLOR}正在卸载 Alist ...${RES}\r\n"
  if [ "$is_termux" -eq 1 ]; then
    #termux执行指令
    #kill进程
    echo -e "${GREEN_COLOR}正在停止进程${RES}"
    alist_pid=$(pgrep -f "alist")
    kill -9 $alist_pid
    #删除目录
    echo -e "${GREEN_COLOR}正在清除文件${RES}"
    rm -rf $INSTALL_PATH
    rm -rf /data/data/com.termux/files/home/start_alist.sh
  else
    #普通linux执行指令
    echo -e "${GREEN_COLOR}正在关闭开机自启${RES}"
    systemctl disable alist >/dev/null 2>&1
    echo -e "${GREEN_COLOR}正在停止进程${RES}"
    systemctl stop alist >/dev/null 2>&1
    echo -e "${GREEN_COLOR}正在清除文件${RES}"
    rm -rf $INSTALL_PATH /etc/systemd/system/alist.service
    echo -e "${GREEN_COLOR}正在重载systemctl${RES}"
    systemctl daemon-reload
  fi
  echo -e "\r\n${GREEN_COLOR}Alist 已成功卸载！${RES}\r\n"
}

UPDATE() {
  
  clear
  if [ ! -f "$INSTALL_PATH/alist" ]; then
    echo -e "\r\n${RED_COLOR}出错了${RES}，当前系统未安装 Alist，请先安装再升级！\r\n"
    exit 1
  else
    config_content=$(cat $INSTALL_PATH/data/config.json)
    if [[ "${config_content}" == *"assets"* ]]; then
      echo -e "\r\n${RED_COLOR}出错了${RES}，V3与V2不兼容，请先手动卸载V2再使用本脚本安装V3！\r\n"
      exit 1
    fi
    echo
    echo -e "${GREEN_COLOR}停止 Alist 进程${RES}\r\n"
    systemctl stop alist
    # 备份 alist 二进制文件，供下载更新失败回退
    cp $INSTALL_PATH/alist /tmp/alist.bak
    echo -e "${GREEN_COLOR}下载 Alist $download_VERSION ...${RES}"
    #新增支持自定义版本
    if [ "$download_VERSION" == "latest" ]; then
        curl -L -H 'Cache-Control: no-cache' ${GH_PROXY}https://github.com/alist-org/alist/releases/latest/download/alist-linux-${ARCH}.tar.gz -o /tmp/alist.tar.gz $CURL_BAR
    else
        curl -L -H 'Cache-Control: no-cache' ${GH_PROXY}https://github.com/alist-org/alist/releases/download/v${download_VERSION}/alist-linux-${ARCH}.tar.gz -o /tmp/alist.tar.gz $CURL_BAR
    fi
    if [ -f /tmp/alist.tar.gz ]; then
      echo -e "${GREEN_COLOR} Alist ${download_VERSION} 下载成功 ${RES}"
    else
      echo -e "${RED_COLOR}下载 alist-linux-$ARCH.tar.gz 出错，更新失败！${RES}"
      echo "正在回退更改"
      mv /tmp/alist.bak $INSTALL_PATH/alist
      echo "正在启动Alist"      
      systemctl start alist
      echo "更新失败，请检查你的网络状况或在本仓库提交Issue!\r\nGithub仓库地址：https://github.com/zhang12334/alist_install_bash\r\n" 1>&2
      exit 1
    fi
    echo -e "\r\n${GREEN_COLOR}正在启动 Alist 进程${RES}"
    systemctl start alist
    echo -e "\r\n${GREEN_COLOR}Alist 已更新到最新稳定版！${RES}\r\n"
    # 删除临时文件
    rm -f /tmp/alist*
  fi
}

# CURL 进度显示
if curl --help | grep progress-bar >/dev/null 2>&1; then # $CURL_BAR
  CURL_BAR="--progress-bar"
fi

# The temp directory must exist
if [ ! -d "/tmp" ]; then
  mkdir -p /tmp
fi

# Fuck bt.cn (BT will use chattr to lock the php isolation config)
chattr -i -R $INSTALL_PATH >/dev/null 2>&1

if [ "$1" = "uninstall" ]; then
  UNINSTALL
elif [ "$1" = "update" ]; then
  UPDATE
elif [ "$1" = "install" ]; then
  CHECK
  INSTALL
  INIT
  if [ -f "$INSTALL_PATH/alist" ]; then
    SUCCESS
  else
    echo -e "${RED_COLOR} 安装失败${RES}"
  fi
else
  echo -e "${RED_COLOR} 错误的命令${RES}"
fi
