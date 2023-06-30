#!/bin/bash

# 获取脚本所在目录路径
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
config_file="$script_dir/config.txt"

# 源用户数据目录和目标用户数据目录
source_user_data_dir="$HOME/Library/Application Support/Google/Chrome/Default"


# 检查配置文件是否存在
if [[ ! -f "$config_file" ]]; then
  echo "配置文件 $config_file 不存在或无法访问"
  exit 1
fi

# 读取目标用户数据目录列表
target_user_data_dirs=()
while IFS= read -r line; do
  if [[ "$line" ]]; then
    target_user_data_dirs+=("$HOME/Library/Application Support/Google/Chrome/$line")
  fi
done < "$config_file"

# 源插件目录
extensions_dir="$source_user_data_dir/Extensions"

# 复制插件到每个目标用户数据目录
for target_user_data_dir in "${target_user_data_dirs[@]}"; do
  target_extensions_dir="$target_user_data_dir/Extensions"

  # 创建目标用户数据目录
  mkdir -p "$target_user_data_dir"

  # 复制插件目录
  cp -r "$extensions_dir" "$target_extensions_dir"

  echo "插件已成功复制到目标用户数据目录：$target_user_data_dir"

  # 可选：修复目标插件目录的权限
  chmod -R 700 "$target_extensions_dir"
done
