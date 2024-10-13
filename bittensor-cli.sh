############ Install Bittensor SDK & BTCLI ############

### Dependencies
clear
    echo "
░██████╗░█████╗░██████╗░██╗██████╗░████████╗  ░█████╗░██╗░░░██╗████████╗░█████╗░ ██╗███╗░░██╗░██████╗████████╗░█████╗░██╗░░░░░██╗░░░░░
██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝  ██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗ ██║████╗░██║██╔════╝╚══██╔══╝██╔══██╗██║░░░░░██║░░░░░
╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░  ███████║██║░░░██║░░░██║░░░██║░░██║ ██║██╔██╗██║╚█████╗░░░░██║░░░███████║██║░░░░░██║░░░░░
░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░  ██╔══██║██║░░░██║░░░██║░░░██║░░██║ ██║██║╚████║░╚═══██╗░░░██║░░░██╔══██║██║░░░░░██║░░░░░
██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░  ██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝ ██║██║░╚███║██████╔╝░░░██║░░░██║░░██║███████╗███████╗
╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░  ╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░ ╚═╝╚═╝░░╚══╝╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚══════╝

██████╗░██╗████████╗████████╗███████╗███╗░░██╗░██████╗░█████╗░██████╗░  ░█████╗░██╗░░░░░██╗
██╔══██╗██║╚══██╔══╝╚══██╔══╝██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗  ██╔══██╗██║░░░░░██║
██████╦╝██║░░░██║░░░░░░██║░░░█████╗░░██╔██╗██║╚█████╗░██║░░██║██████╔╝  ██║░░╚═╝██║░░░░░██║
██╔══██╗██║░░░██║░░░░░░██║░░░██╔══╝░░██║╚████║░╚═══██╗██║░░██║██╔══██╗  ██║░░██╗██║░░░░░██║
██████╦╝██║░░░██║░░░░░░██║░░░███████╗██║░╚███║██████╔╝╚█████╔╝██║░░██║  ╚█████╔╝███████╗██║
╚═════╝░╚═╝░░░╚═╝░░░░░░╚═╝░░░╚══════╝╚═╝░░╚══╝╚═════╝░░╚════╝░╚═╝░░╚═╝  ░╚════╝░╚══════╝╚═╝

██████╗░██╗░░░██╗  ██████╗░███████╗███╗░░██╗███╗░░██╗███████╗░█████╗░███╗░░██╗███████╗
██╔══██╗╚██╗░██╔╝  ██╔══██╗██╔════╝████╗░██║████╗░██║╚════██║██╔══██╗████╗░██║██╔════╝
██████╦╝░╚████╔╝░  ██████╔╝█████╗░░██╔██╗██║██╔██╗██║░░███╔═╝██║░░██║██╔██╗██║█████╗░░
██╔══██╗░░╚██╔╝░░  ██╔══██╗██╔══╝░░██║╚████║██║╚████║██╔══╝░░██║░░██║██║╚████║██╔══╝░░
██████╦╝░░░██║░░░  ██║░░██║███████╗██║░╚███║██║░╚███║███████╗╚█████╔╝██║░╚███║███████╗
╚═════╝░░░░╚═╝░░░  ╚═╝░░╚═╝╚══════╝╚═╝░░╚══╝╚═╝░░╚══╝╚══════╝░╚════╝░╚═╝░░╚══╝╚══════╝"
    sleep 10

sudo apt update && sudo apt upgrade -y

### Install Bittensor SDK
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/opentensor/bittensor/master/scripts/install.sh)"

### Install Python Environment
apt install python3.10-venv -y
python3 -m venv btsdk_venv
source btsdk_venv/bin/activate

### Install BTCLI
git clone https://github.com/opentensor/btcli.git
cd btcli
pip3 install .
clear

### Setup Wallet
while true; do
    echo "Setup Wallet"
    echo "Pilih opsi untuk coldkey:"
    echo "1. Buat Coldkey baru"
    echo "2. Regenerate Coldkey dari mnemonic"
    read -p "Masukkan pilihan (1 atau 2): " coldkey_choice

    if [[ $coldkey_choice == "1" ]]; then
        read -p "Masukkan nama cold wallet (atau tekan Enter untuk 'default'): " coldkey_name
        coldkey_name=${coldkey_name:-default}  # Gunakan 'default' jika tidak ada input
        btcli wallet new_coldkey --wallet.name $coldkey_name
        echo "Simpan mnemonic yang ada! Proses akan lanjut dalam 7 detik. "
        sleep 7
        break
    elif [[ $coldkey_choice == "2" ]]; then
        read -p "Masukkan mnemonic untuk regenerate coldkey: " mnemonic_coldkey
        btcli w regen_coldkey --mnemonic "$mnemonic_coldkey"
        break
    else
        echo "Pilihan tidak valid. Silakan coba lagi."
    fi
done

### Setup Hotkey
while true; do
    echo "Pilih opsi untuk hotkey:"
    echo "1. Buat Hotkey baru"
    echo "2. Regenerate Hotkey dari mnemonic"
    read -p "Masukkan pilihan (1 atau 2): " hotkey_choice

    if [[ $hotkey_choice == "1" ]]; then
        read -p "Masukkan nama cold wallet (untuk hotkey): " coldkey_name
        read -p "Masukkan nama hotkey (atau tekan Enter untuk 'default'): " hotkey_name
        hotkey_name=${hotkey_name:-default}  # Gunakan 'default' jika tidak ada input
        btcli wallet new_hotkey --wallet.name $coldkey_name --wallet.hotkey $hotkey_name
        echo "Simpan mnemonic yang ada! Proses akan lanjut dalam 7 detik. "
        sleep 7
        break
    elif [[ $hotkey_choice == "2" ]]; then
        read -p "Masukkan mnemonic untuk regenerate hotkey: " mnemonic_hotkey
        btcli w regen_hotkey --mnemonic "$mnemonic_hotkey"
        break
    else
        echo "Pilihan tidak valid. Silakan coba lagi."
    fi
done

### Done
clear

echo "Instalasi Bittensor SDK dan BTCLI sudah selesai."
read -p "Apakah Anda ingin menginstall Local Subtensor Node? (y/n): " install_subtensor_choice

if [[ $install_subtensor_choice == "y" || $install_subtensor_choice == "Y" ]]; then
    echo "Instalasi Local Subtensor akan dimulai..."
    sleep 2

    ############ Install Local Subtensor ############

    ### Install basic packages
    sudo apt-get update 
    sudo apt install -y build-essential clang curl git make libssl-dev llvm libudev-dev protobuf-compiler

    ### Install Rust
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source ~/.cargo/env

    # install Rust toolchain
    rustup default stable
    rustup update
    rustup target add wasm32-unknown-unknown
    rustup toolchain install nightly
    rustup target add --toolchain nightly wasm32-unknown-unknown

    ### Compile subtensor code
    git clone https://github.com/opentensor/subtensor.git
    cd subtensor
    git checkout main
    rm -rf /tmp/blockchain 
    cargo build -p node-subtensor --profile=production --features=runtime-benchmarks

    ### Run Subtensor Node
while true; do
    echo "Pilih opsi untuk menjalankan Subtensor Node:"
    echo "1. Lite Node on Mainchain"
    echo "2. Lite Node on Testchain"
    read -p "Masukkan pilihan (1 atau 2): " node_choice

    if [[ $node_choice == "1" ]]; then
        ./target/production/node-subtensor --chain raw_spec_finney.json --base-path /tmp/blockchain --sync=warp --port 30333 --max-runtime-instances 32 --rpc-max-response-size 2048 --rpc-cors all --rpc-port 9944 --bootnodes /dns/bootnode.finney.chain.opentensor.ai/tcp/30333/ws/p2p/12D3KooWRwbMb85RWnT8DSXSYMWQtuDwh4LJzndoRrTDotTR5gDC --no-mdns --in-peers 8000 --out-peers 8000 --prometheus-external --rpc-external
        break
    elif [[ $node_choice == "2" ]]; then
        ./target/production/node-subtensor --chain raw_spec_testfinney.json --base-path /tmp/blockchain --sync=warp --port 30333 --max-runtime-instances 32 --rpc-max-response-size 2048 --rpc-cors all --rpc-port 9944 --bootnodes /dns/bootnode.test.finney.opentensor.ai/tcp/30333/p2p/12D3KooWPM4mLcKJGtyVtkggqdG84zWrd7Rij6PGQDoijh1X86Vr --no-mdns --in-peers 8000 --out-peers 8000 --prometheus-external --rpc-external
        break
    else
        echo "Pilihan tidak valid. Silakan coba lagi."
    fi
    
    echo "Instalasi Local Subtensor sudah selesai."
else
    echo "Instalasi Local Subtensor dibatalkan."
fi
