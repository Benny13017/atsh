#!/bin/bash

# 检测操作系统信息
function detect_os() {
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

# 检测CPU信息
function detect_cpu() {
    CPU_MODEL=$(cat /proc/cpuinfo | grep 'model name' | uniq | awk -F ': ' '{print $2}')
    CPU_CORES=$(grep -c '^processor' /proc/cpuinfo)
    echo "CPU型号：$CPU_MODEL"
    echo "CPU核心数：$CPU_CORES"
}

# 检测内存信息
function detect_memory() {
    TOTAL_MEMORY=$(free -m | awk '/Mem:/{print $2}')
    echo "总内存：$TOTAL_MEMORY MB"
}

# 检测磁盘空间信息
function detect_disk() {
    TOTAL_DISK=$(df -h | awk '$NF=="/"{print $2}')
    echo "总磁盘空间：$TOTAL_DISK"
}

echo "开始检测VPS信息..."
echo "======================"
echo "操作系统信息:" 
detect_os
echo "CPU信息:"
detect_cpu
echo "内存信息:"
detect_memory
echo "磁盘空间信息:"
detect_disk
echo "======================"
echo "VPS信息检测完成。"
