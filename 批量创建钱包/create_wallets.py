import os

from eth_account import Account
from pathlib import Path


def create_wallets(num_wallets=10, file_name="wallets.txt"):
    wallets = []
    Account.enable_unaudited_hdwallet_features()
    if language == 1:
        lang = "english"
    elif language == 2:
        lang = "chinese_simplified"
    elif language == 3:
        lang = "chinese_traditional"
    elif language == 4:
        lang = "spanish"
    elif language == 5:
        lang = "french"
    else:
        lang = "english"
    for i in range(num_wallets):
        account, mnemonic = Account.create_with_mnemonic(
            language=lang)
        wallet = {
            "address": account.address,
            "private_key": account._private_key.hex(),
            "mnemonic": mnemonic,
            "index": i,
        }
        wallets.append(wallet)
    abs_file_path = os.path.abspath(
        os.path.join(os.path.dirname(__file__), file_name))
    with open(abs_file_path, "w") as f:
        for wallet in wallets:
            f.write(f"地址: {wallet['address']}\n")
            f.write(f"私钥: {wallet['private_key']}\n")
            # 是否导出助记词
            if export_mnemonic.lower() in ["y", "yes"]:
                f.write(f"助记词: {wallet['mnemonic']}\n")
            f.write(f"Index: {wallet['index']}\n\n")

    print(f"创建了{num_wallets}个钱包，数据保存在{file_name}")


if __name__ == "__main__":
    # 获取用户输入
    num_wallets = int(input("请输入要创建的钱包数量(默认10): ") or "10")
    file_name = input("请输入要保存的文件名（默认为wallets.txt）：") or "wallets.txt"
    language = int(input("请选择助记词语言，1.英语 2.中文简体 3.中文繁体 4.西班牙语 5.法语: ") or "1")
    export_mnemonic = input("是否需要导出助记词(y/n): ") or "y"

    create_wallets(num_wallets=num_wallets, file_name=file_name)
