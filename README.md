
# WireGuard VPN

This repository contains diagrams, screenshots, and notes for building and testing WireGuard and IPsec VPNs.

Summary

The repository appears to include Packet Tracer diagrams (.pkt), a PDF implementation report, and several screenshots showing installation and verification steps performed on Alpine Linux and Linux Mint.

Detected files (at repo root)

- `Site-to-Site Ipsec.pkt` — network/Packet Tracer diagram
- `Wireguard Vpn.pkt` — network/Packet Tracer diagram
- `WireGuard VPN Implementation Report-1.pdf` — implementation report / notes
- `Alpine Wire-guard installtion.png` — Alpine install screenshot
- `Cle Genration on Alpine.png` — key generation on Alpine screenshot
- `5.Adding  wgo.conf to alpine.png` — adding wg0.conf on Alpine
- `Succesful connection Alpine Linux.png` — successful connection (Alpine)
- `Ping From Server to Client Suucessful.png` — ping test screenshot
- `Ping from Client to Server Succesful.png` — ping test screenshot
- `Wireguard installtion LinuxMint.png` — WireGuard installation on Linux Mint
- `KeyGeneration LinuxMint.png` — key generation on Linux Mint
- `Setting Wireguard permission Linux mint.png` — file permission steps on Linux Mint
- `Succesfull connetion linux mint.png` — successful connection (Linux Mint)
- `Vpn Shows Up.png`, `Vpn Icon.png` — UI/indicator screenshots
- `README.md` — this file

Note about OSes

I found screenshots and notes that indicate you used two operating systems for the walkthroughs: Alpine Linux and Linux Mint. The screenshots for each are included above and show installation, key generation, permission changes, and connectivity tests.

PSF / PSD / other sources

- I did not find any files with extensions `.psf` or `.psd` in the repository root. If you intended a different extension or a file in a subfolder, point me to it and I will add it to this list and the README.

Quick WireGuard setup (example)

1. Install WireGuard (examples):

   - Debian/Ubuntu / Linux Mint: `sudo apt install wireguard`
   - Alpine: `sudo apk add wireguard-tools`
   - Fedora: `sudo dnf install wireguard-tools`

1. Generate keys:

```bash
wg genkey | tee privatekey | wg pubkey > publickey
```

1. Example `wg0.conf` (replace with your values):

```ini
[Interface]
PrivateKey = <contents of privatekey>
Address = 10.0.0.1/24
ListenPort = 51820

[Peer]
PublicKey = <peer public key>
AllowedIPs = 10.0.0.2/32
Endpoint = peer.example.com:51820
PersistentKeepalive = 25
```

1. Bring up the interface:

```bash
sudo wg-quick up wg0
```

Troubleshooting hints

- Use `sudo wg` to check peer status.
- Use `ip a` and `ip route` to verify addresses and routes.
- On Alpine use `sudo apk` and ensure the kernel supports WireGuard (modern Alpine usually does).
- Ensure firewalls allow UDP on the WireGuard port (default 51820).

Next steps you might want

- Confirm whether you want the screenshots moved into an `images/` directory and referenced inline in this README.
- Tell me if there are additional config files (e.g., exported `.conf`) that should be included here.
- If you want, I can add the README to git, commit, and push to `main`.

Created: October 20, 2025

