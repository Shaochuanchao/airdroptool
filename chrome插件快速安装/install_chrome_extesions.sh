#!/bin/bash

chrome_path="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
extension_crx_dir="$script_dir/extensions"
config_file="$script_dir/config.txt"

# 读取配置文件中的用户数据目录
read_user_data_dirs() {
  if [[ -f "$config_file" ]]; then
    user_data_dirs=()
    while IFS= read -r line; do
      if [[ "$line" ]]; then
        echo "$line"
        user_data_dirs+=("$line")
      fi
    done < "$config_file"
  else
    echo "配置文件 $config_file 不存在或无法访问"
    exit 1
  fi
}

# 安装插件
install_extension() {
  local profile="$1"
  local user_data_dir="$HOME/Library/Application Support/Google/Chrome/$profile"
  for extension_crx in "$extension_crx_dir"/*.crx; do
    echo "安装插件："
    echo "  用户目录：$user_data_dir"
    echo "  插件路径：$extension_crx"
    "${chrome_path}" --user-data-dir="$user_data_dir" --install-extension "$extension_crx"
  done
}

# 主函数
main() {
  echo "开始读取用户配置$config_file..."
  read_user_data_dirs
  echo "用户配置读取完成 $user_data_dir"

  for user_data_dir in "${user_data_dirs[@]}"; do
    echo "开始安装插件到用户：$profile"
    install_extension "$user_data_dir"
    echo "完成安装插件到用户：$profile"
  done
}

# 执行主函数
main
