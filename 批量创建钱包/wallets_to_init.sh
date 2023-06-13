#!/bin/bash

# 获取文件全路径
echo "请输入文件的全路径："
read filepath

# 获取目录路径和文件名
dir=$(dirname "$filepath")
filename=$(basename "$filepath")

# 定义变量
index=0

# 读取文件
while IFS= read -r line; do
  if [[ "$line" == "助记词:"* ]]; then
    # 提取助记词
    seed=$(echo $line | cut -d ':' -f 2- | xargs)
    rand_num=$(openssl rand -hex 4)
    # 生成对应的 ini 文件
    cat << EOF > "${dir}/wallet_${index}.ini"
[wallet]
SEED_PHRASE = $seed
PWD = Auto@$rand_num
EOF
    index=$((index+1))
  fi
done < "$filepath"

