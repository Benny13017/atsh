#!/bin/bash
function VPS_System(){
        if [ -f /etc/os-release ]; then
        source /etc/os-release
        OS="$NAME"
        VERSION="$VERSION"
    elif [ -f /etc/lsb-release ]; then
        OS=$(lsb_release -si)
        VERSION=$(lsb_release -sr)
    elif [ -f /etc/redhat-release ]; then
        OS="Red Hat Enterprise Linux"
        VERSION=$(cat /etc/redhat-release | grep -oP '(?<=release )\d+')
    else
        OS=$(uname -s)
        VERSION=$(uname -r)
    fi
    echo "操作系统：$OS $VERSION"
}
function VPS_CPU(){
        CPU_MODEL=$(cat /proc/cpuinfo | grep 'model name' | uniq | awk -F ': ' '{print $2}')    
       echo "CPU型号：$CPU_MODEL"
}
function VPS_Core(){
       CPU_CORES=$(grep -c '^processor' /proc/cpuinfo)
       echo "CPU核心数：$CPU_CORES"
}
function VPS_Memory(){
       TOTAL_MEMORY=$(free -m | awk '/Mem:/{print $2}')
       echo "总内存：$TOTAL_MEMORY MB"
}
function VPS_Disk(){
          TOTAL_DISK=$(df -h | awk '$NF=="/"{print $2}')
          echo "总磁盘空间：$TOTAL_DISK"
}
while true ; do
       echo " ____"
       echo "| __ )  ___ _ __  _ __  _   _"
       echo "|  _ \ / _ \ '_ \| '_ \| | | |"
       echo "| |_) |  __/ | | | | | | |_| |"
       echo "|____/ \___|_| |_|_| |_|\__, |"
       echo "                        |___/"
       echo "Benny 一键脚本工具"
       echo "-------------------------------------------"
       echo "1.查询VPS的系统版本"
       echo "2.查询VPS的CPU"
       echo "3.查询VPS的核心数"
       echo "4.查询VPS的内存"
       echo "5.查询VPS的硬盘"
       read -p "请输入你的选择" choice
      case $choice in
      1)
      Clear
      VPS_System
      ;;
      2)
      Clear
      VPS_CPU
      ;;
      3)
      Clear
      VPS_Core
      ;;
      4)
      Clear
      VPS_Memory
      ;;
      5)
      Clear
      VPS_Disk
      ;;
      q|Q)
      exist
      ;;
      *)
      echo "unvariable input"
      
      esac
done
