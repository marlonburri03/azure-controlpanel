#!/bin/bash

# Farben
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # Kein Color

# Prüfe ob Azure CLI installiert ist
if ! command -v az &> /dev/null; then
    echo -e "${RED}Azure CLI ist nicht installiert. Bitte installiere es zuerst.${NC}"
    exit 1
fi

while true; do
    clear
    echo -e "${BLUE}========= AZURE CLI CONTROL PANEL =========${NC}"
    echo -e "${YELLOW} 1)${NC} Aktive Subscription anzeigen"
    echo -e "${YELLOW} 2)${NC} Alle Subscriptions anzeigen"
    echo -e "${YELLOW} 3)${NC} Azure Regionen anzeigen"
    echo -e "${YELLOW} 4)${NC} Alle Resource Groups anzeigen"
    echo -e "${YELLOW} 5)${NC} Details einer Resource Group anzeigen"
    echo -e "${YELLOW} 6)${NC} Ressourcen in einer Resource Group anzeigen"
    echo -e "${YELLOW} 7)${NC} Alle Ressourcen anzeigen"
    echo -e "${YELLOW} 8)${NC} Rollen-Zuweisungen anzeigen"
    echo -e "${YELLOW} 9)${NC} Tags einer Ressource anzeigen"
    echo -e "${YELLOW}10)${NC} Ressourcen exportieren (JSON)"
    echo -e "${YELLOW}11)${NC} Beenden"
    echo -e "${YELLOW}12)${NC} Alle Storage Accounts anzeigen"
    echo -e "${BLUE}===========================================${NC}"
    read -p "Option wählen [1-12]: " opt

    case $opt in
        1)
            echo -e "${CYAN}Aktive Subscription:${NC}"
            az account show -o table
            ;;
        2)
            echo -e "${CYAN}Alle Subscriptions:${NC}"
            az account list -o table
            ;;
        3)
            echo -e "${CYAN}Verfügbare Azure Regionen:${NC}"
            az account list-locations -o table
            ;;
        4)
            echo -e "${CYAN}Alle Resource Groups:${NC}"
            az group list -o table
            ;;
        5)
            read -p "Resource Group Name: " rgname
            echo -e "${CYAN}Details der Resource Group ${rgname}:${NC}"
            az group show --name "$rgname" -o table
            ;;
        6)
            read -p "Resource Group Name: " rgname
            echo -e "${CYAN}Ressourcen in ${rgname}:${NC}"
            az resource list --resource-group "$rgname" -o table
            ;;
        7)
            echo -e "${CYAN}Alle Ressourcen:${NC}"
            az resource list -o table
            ;;
        8)
            echo -e "${CYAN}Rollen-Zuweisungen:${NC}"
            az role assignment list -o table
            ;;
        9)
            read -p "Ressourcen-ID oder Name (z.B. VM, RG): " resname
            echo -e "${CYAN}Tags der Ressource:${NC}"
            az resource show --name "$resname" --query tags -o json
            ;;
        10)
            echo -e "${CYAN}Ressourcen werden exportiert in 'resources.json'...${NC}"
            az resource list -o json > resources.json
            echo -e "${GREEN}Export erfolgreich.${NC}"
            ;;
        11)
            echo -e "${GREEN}Beende...${NC}"
            exit 0
            ;;
        12)
            echo -e "${CYAN}Alle Storage Accounts:${NC}"
            az storage account list --query "[].{Name:name, ResourceGroup:resourceGroup, Location:primaryLocation}" -o table
            ;;
        *)
            echo -e "${RED}Ungültige Eingabe!${NC}"
            ;;
    esac

    echo ""
    read -p "Drücke [Enter] zum Fortfahren..."
done