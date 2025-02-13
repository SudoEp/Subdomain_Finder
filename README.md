# Subdomain Finder 🔍  

A simple **Bash script** for subdomain enumeration using **Subfinder** and **Assetfinder**.  
This script automates the process of discovering subdomains for a given domain and outputs the results in a file.

## 🚀 Features
- Uses `subfinder` and `assetfinder` for subdomain discovery.
- Outputs unique subdomains to a text file.
- Color-coded terminal output for better readability.
- Checks for missing dependencies and alerts the user.
- Handles errors gracefully.

## 📌 Prerequisites
Ensure the following tools are installed before running the script:
- [Subfinder](https://github.com/projectdiscovery/subfinder)
- [Assetfinder](https://github.com/tomnomnom/assetfinder)

You can install them using:
```bash
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/tomnomnom/assetfinder@latest
```

## 🔧 Installation
- git clone https://github.com/SudoEp/subdomain-finder.git
- cd subdomain-finder
- chmod +x subdomain_finder.sh

## 🛠️ Usage
Run the script with a target domain:
```bash
./subdomain_finder.sh example.com
```
## 🤝 Contributions
Feel free to open an issue or submit a pull request for improvements.
