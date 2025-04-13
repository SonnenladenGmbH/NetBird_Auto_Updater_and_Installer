# NetBird Auto Updater & Installer
A simple Bash script that installs or updates [NetBird](https://github.com/netbirdio/netbird) to the latest release on Ubuntu/Debian-based systems, directly from GitHub.

This script detects your architecture (`amd64` or `arm64`), fetches the latest `.deb` release, installs required dependencies, and installs or updates NetBird with ease.

### ❇️ No Downtime!
This even works when connected using a NetBird direct connection to the corresponding peer you want to update — even though the NetBird connection is briefly dropped during the update, it will come back within seconds without interrupting the SSH session.  
**No need to connect via public IP!**

### 🔐 Settings Preserved
The script **does not reset or re-authenticate** your peer — all existing configuration and identity are preserved during the update.

### ⚠️ Important Notice
This script has been tested and works reliably, but you should **always verify that the updated NetBird version is functioning correctly.**  
Do not blindly rely on automation in production-critical systems. Always test in your environment first.

---

## ✅ Features

- 🧠 Auto-detects system architecture (`x86_64` or `ARM64`)
- 🔄 Installs or updates NetBird to the latest version
- 📦 Installs required tools: `curl`, `wget`, `jq`
- 💡 Clean logging and error handling

---

## ⚙️ Requirements

- Ubuntu/Debian-based system
- Root/sudo privileges
- Internet connection

---

## 📥 Usage

### 🧩 1. Download the Script via `wget`

```bash
wget https://raw.githubusercontent.com/SonnenladenGmbH/NetBird_Auto_Updater_and_Installer/main/netbird_auto_updater.sh
```

### 🔓 2. Make the Script Executable

```bash
chmod +x netbird_auto_updater.sh
```

### 🚀 3. Run It

```bash
sudo bash netbird_auto_updater.sh
```

> ▶️ During the initial installation, you need to set up NetBird and connect it to your server. This step is not required when updating.
> ```bash
> netbird up
> ```

---

## 🔁 Automatic Updates (Optional)

To update NetBird automatically (e.g. daily), set up a cron job:

```bash
sudo crontab -e
```

Add this line to run the updater every day at 3:00 AM:

```cron
0 3 * * * /path/to/netbird_auto_updater.sh >> /var/log/netbird-updater.log 2>&1
```

---

## ☀️ Get to know NetBird

They offer a great free self-hosted version and also paid cloud-plans:  
https://netbird.io/ | [@netbirdio](https://github.com/netbirdio)

---

## 👤 Author

**Leo Tiedt** – [@TipsTricksMore](https://github.com/TipsTricksMore)

Pull requests, issues, and stars are welcome!
