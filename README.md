
# Overview

The **Banner Grabber Tool** is a lightweight cybersecurity utility that extracts service banners from network applications such as HTTP, FTP, SMTP, and SSH. These banners often reveal useful information like the service name, version number, and operating system, which can help security professionals in vulnerability assessment and penetration testing.

# Features

* Grab service banners from a given IP and port
* Supports multiple common services (HTTP, FTP, SSH, SMTP, etc.)
* Lightweight and easy to use
* Helps in identifying outdated or vulnerable services
* CLI-based tool written in **Python/C** (depending on your implementation)

# Installation

Clone the repository:

```bash
git clone https://github.com/yourusername/banner-grabber.git
cd banner-grabber
```

Install required dependencies (if Python):

```bash
pip install -r requirements.txt
```

Or if using C:

```bash
gcc banner_grabber.c -o banner_grabber
```

# Usage

### Python Example:

```bash
python banner_grabber.py <IP> <PORT>
```

### C Example:

```bash
./banner_grabber <IP> <PORT>
```

### Output Example:

```bash
$ python banner_grabber.py 192.168.1.10 80
[+] Connecting to 192.168.1.10:80
[+] Banner: Apache/2.4.29 (Ubuntu)
```

## 📖 How It Works

1. Establishes a TCP connection with the target host and port.
2. Sends a simple request (where applicable, e.g., HTTP GET).
3. Captures and displays the response banner.

## ⚠️ Disclaimer

This tool is for **educational and security testing purposes only**. Do not use it on systems you do not own or have explicit permission to test. Unauthorized scanning may be illegal.



