#!/bin/sh
# -----------------------------------------------
# WireGuard Auto Setup Script for Alpine Linux
# Author: Fouenang Miguel Bruce 😉
# -----------------------------------------------

echo "🚀 Starting WireGuard installation on Alpine..."

# 1️⃣ Install required packages
apk add --no-cache wireguard-tools sudo

# 2️⃣ Enable the WireGuard kernel module
modprobe wireguard

# 3️⃣ Create working directory
mkdir -p /etc/wireguard
cd /etc/wireguard || exit

# 4️⃣ Generate keys
echo "🔑 Generating private and public keys..."
wg genkey | tee privatekey | wg pubkey > publickey

SERVER_IP=$(hostname -I | awk '{print $1}')

echo "✅ Keys generated successfully!"
echo "--------------------------------------"
echo "Server IP: $SERVER_IP"
echo "Private key stored in /etc/wireguard/privatekey"
echo "Public key stored in /etc/wireguard/publickey"
echo "--------------------------------------"

# 5️⃣ Ask user for mode
echo "Choose mode to configure (server/client): "
read -r MODE

if [ "$MODE" = "server" ]; then
    echo "🔧 Setting up WireGuard as SERVER..."

    cat > /etc/wireguard/wg0.conf <<EOF
[Interface]
Address = 10.0.0.1/24
PrivateKey = $(cat privatekey)
ListenPort = 51820

# Add your client public key below
# Example:
# [Peer]
# PublicKey = <CLIENT_PUBLIC_KEY>
# AllowedIPs = 10.0.0.2/32
EOF

    echo "✅ Server configuration created at /etc/wireguard/wg0.conf"

elif [ "$MODE" = "client" ]; then
    echo "🔧 Setting up WireGuard as CLIENT..."

    echo "Enter your SERVER public key:"
    read -r SERVER_PUBKEY
    echo "Enter your SERVER IP address:"
    read -r SERVER_PUBLIC_IP

    cat > /etc/wireguard/wg0.conf <<EOF
[Interface]
Address = 10.0.0.2/24
PrivateKey = $(cat privatekey)

[Peer]
PublicKey = $SERVER_PUBKEY
Endpoint = $SERVER_PUBLIC_IP:51820
AllowedIPs = 10.0.0.0/24
PersistentKeepalive = 25
EOF

    echo "✅ Client configuration created at /etc/wireguard/wg0.conf"
else
    echo "❌ Invalid mode. Please rerun and choose 'server' or 'client'."
    exit 1
fi

# 6️⃣ Secure permissions
chmod 600 /etc/wireguard/*

# 7️⃣ Start VPN
echo "🔥 Starting WireGuard..."
wg-quick up wg0

# 8️⃣ Display status
wg

echo "✅ WireGuard setup complete!"

