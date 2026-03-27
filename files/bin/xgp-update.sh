#!/bin/bash
# 自动检测并升级固件
REPO="qsyssr/immortalwrt-xgp-auto-build"
FIRMWARE_NAME="immortalwrt-xgp-v3"

# 获取最新 Tag
RELEASE_DATA=$(wget -qO- -t1 -T5 "https://api.github.com/repos/$REPO/releases/latest")
NEW_TAG=$(echo "$RELEASE_DATA" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')

# 自动匹配引导模式 (EFI 或 Combined)
[ -d /sys/firmware/efi ] && BOOT="uefi" || BOOT="combined"
IMG_FILE=$(echo "$RELEASE_DATA" | grep -oE "${FIRMWARE_NAME}[^?]*${BOOT}[^?]*\.img\.gz" | head -n 1)

if [ -n "$IMG_FILE" ]; then
    mkdir -p /tmp/upgrade && cd /tmp/upgrade
    echo "正在下载最新固件..."
    wget "https://github.com/$REPO/releases/download/$NEW_TAG/$IMG_FILE" -O "upgrade.img.gz"
    if [ $? -eq 0 ]; then
        # 写入版本标识
        echo "$NEW_TAG" > /etc/lenyu_version
        sysupgrade "upgrade.img.gz"
    fi
fi
