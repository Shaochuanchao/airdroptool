#!/bin/bash

# 从文件中读取选项
options_file="$(dirname "$0")/chrome_profiles.txt"
if [ ! -f "$options_file" ]; then
    echo "配置文件 $options_file 不存在."
    exit 1
fi
options=($(cat "$options_file"))

# 获取传递的参数，如果没有传递参数，则提示用户选择一个选项
if [ $# -eq 0 ]; then
    echo "请选择一个选项:"
    select profile in "${options[@]}"; do
        if [[ " ${options[@]} " =~ " ${profile} " ]]; then
            break
        else
            echo "请选择一个有效选项."
        fi
    done
else
    profile=$1
fi

# 检查目录是否存在，如果不存在则创建
dir="$HOME/Library/Application Support/Google/Chrome/$profile"
if [ ! -d "$dir" ]; then
    echo "目录 $dir 不存在，将创建."
    mkdir -p "$dir"
fi

# 打开Chrome浏览器并指定目录
echo "正在打开Chrome浏览器，用户数据目录为 $dir"
open -na "Google Chrome" --args --user-data-dir="$dir"
