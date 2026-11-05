# Azure Control Panel

**A small interactive Bash menu for the Azure CLI queries I use most: subscriptions, regions, resource groups, resources, role assignments, tags and storage accounts, without remembering the exact commands.**

![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat-square&logo=gnubash&logoColor=white)
![Azure CLI](https://img.shields.io/badge/Azure%20CLI-0078D4?style=flat-square&logo=microsoftazure&logoColor=white)

## Requirements

- Bash (Linux, macOS, WSL or Git Bash)
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli), signed in with `az login`

## Usage

```bash
git clone https://github.com/marlonburri03/azure-controlpanel.git
cd azure-controlpanel
chmod +x azure-control.sh
./azure-control.sh
```

The script checks that the Azure CLI is installed and signed in, then shows the menu until you choose `0`.

## Menu

| Option | Action | Azure CLI command |
|---|---|---|
| 1 | Show active subscription | `az account show` |
| 2 | List all subscriptions | `az account list` |
| 3 | List Azure regions | `az account list-locations` |
| 4 | List resource groups | `az group list` |
| 5 | Show resource group details | `az group show --name <rg>` |
| 6 | List resources in a resource group | `az resource list --resource-group <rg>` |
| 7 | List all resources | `az resource list` |
| 8 | List role assignments | `az role assignment list --all` |
| 9 | Show tags of a resource | `az resource show --ids <id> --query tags` |
| 10 | Export all resources | `az resource list -o json > resources.json` |
| 11 | List storage accounts | `az storage account list` |
| 0 | Exit | |

All options only read data, except option 10, which writes `resources.json` to the current folder. The results reflect the active subscription; switch it with `az account set --subscription <id>`.

## Author

Marlon Burri, [github.com/marlonburri03](https://github.com/marlonburri03)
