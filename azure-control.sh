#!/bin/bash
# interactive menu for common read-only azure cli queries

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'

if ! command -v az &> /dev/null; then
    echo -e "${RED}Azure CLI is not installed. Please install it first.${NC}"
    exit 1
fi

if ! az account show &> /dev/null; then
    echo -e "${RED}Not signed in. Run 'az login' first.${NC}"
    exit 1
fi

while true; do
    clear
    echo -e "${BLUE}========= AZURE CLI CONTROL PANEL =========${NC}"
    echo -e "${YELLOW} 1)${NC} Show active subscription"
    echo -e "${YELLOW} 2)${NC} List all subscriptions"
    echo -e "${YELLOW} 3)${NC} List Azure regions"
    echo -e "${YELLOW} 4)${NC} List resource groups"
    echo -e "${YELLOW} 5)${NC} Show resource group details"
    echo -e "${YELLOW} 6)${NC} List resources in a resource group"
    echo -e "${YELLOW} 7)${NC} List all resources"
    echo -e "${YELLOW} 8)${NC} List role assignments"
    echo -e "${YELLOW} 9)${NC} Show tags of a resource"
    echo -e "${YELLOW}10)${NC} Export all resources (JSON)"
    echo -e "${YELLOW}11)${NC} List storage accounts"
    echo -e "${YELLOW} 0)${NC} Exit"
    echo -e "${BLUE}===========================================${NC}"
    read -r -p "Choose an option [0-11]: " opt

    case $opt in
        1)
            echo -e "${CYAN}Active subscription:${NC}"
            az account show -o table
            ;;
        2)
            echo -e "${CYAN}All subscriptions:${NC}"
            az account list -o table
            ;;
        3)
            echo -e "${CYAN}Available Azure regions:${NC}"
            az account list-locations -o table
            ;;
        4)
            echo -e "${CYAN}All resource groups:${NC}"
            az group list -o table
            ;;
        5)
            read -r -p "Resource group name: " rgname
            echo -e "${CYAN}Details of resource group ${rgname}:${NC}"
            az group show --name "$rgname" -o table
            ;;
        6)
            read -r -p "Resource group name: " rgname
            echo -e "${CYAN}Resources in ${rgname}:${NC}"
            az resource list --resource-group "$rgname" -o table
            ;;
        7)
            echo -e "${CYAN}All resources:${NC}"
            az resource list -o table
            ;;
        8)
            echo -e "${CYAN}Role assignments:${NC}"
            az role assignment list --all -o table
            ;;
        9)
            read -r -p "Resource ID (/subscriptions/...): " resid
            echo -e "${CYAN}Tags:${NC}"
            az resource show --ids "$resid" --query tags -o json
            ;;
        10)
            echo -e "${CYAN}Exporting resources to 'resources.json'...${NC}"
            az resource list -o json > resources.json && echo -e "${GREEN}Export complete.${NC}"
            ;;
        11)
            echo -e "${CYAN}All storage accounts:${NC}"
            az storage account list --query "[].{Name:name, ResourceGroup:resourceGroup, Location:primaryLocation}" -o table
            ;;
        0)
            echo -e "${GREEN}Bye.${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option.${NC}"
            ;;
    esac

    echo ""
    read -r -p "Press [Enter] to continue..."
done
