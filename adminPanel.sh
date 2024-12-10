#!/bin/bash

: '

===========================================
| Author:            SamCouto             |
| Creation Date:     09.12.24             |
| Last Modification: 09.12.24             |
| Description:       Administration panel |
| Usage:             ./adminPanel         |
===========================================

About:

This program executes the adiministration functionalities of the first script.

Only the admin can use this program, that means, the sudo user.

Here the administrator can check and manipulate the vending machine storage, and it can check and recieve the total profit made by the machine.

'

function adminMenu {
    echo "|==ADMINISTRATION==|"
    echo "| 0. Return        |"
    echo "| 1. Storage       |"
    echo "| 2. Profit        |"
    echo "|==-=-=-=--=-=-=-==|"

    read -rp ">> " vIntOpt

    case $vIntOpt in

    0)
        clear

        # Get the home directory of the user that executed the script as sudo
        cUserHome=$(getent passwd "$SUDO_USER" | cut -d: -f6)
        sudo -u "$SUDO_USER" "$cUserHome/codingProjects/ShellScripts/Bash/vendingMachine/./vendingMachine.sh"
        ;;


    1)
        clear
        storage
        ;;

    2)
        clear
        accounting
        ;;

    *)
        clear
        adminMenu
        ;;

    esac
}

function storage {
    echo "|=-=STORAGE=-=|"
    echo "| 0. Return   |"
    echo "| 1. Check    |"
    echo "| 2. Restock  |"
    echo "|=-=-=-=-=-=-=|"

    read -rp ">> " vIntOpt

    case $vIntOpt in

    0)
        clear
        adminMenu
        ;;
    
    1)
        # Check storage
        ;;
    
    2)
        # Restock
        ;;
    
    *)
        clear
        storage
        ;;
    
    esac
}

function accounting {
    echo "|=-=ACCOUNTING=-=|"
    echo "| 0. Return      |"
    echo "| 1. Check total |"
    echo "| 2. Recieve     |"
    echo "|=-=-=-=-=-=-=-=-|"

    read -rp ">> " vIntOpt

    case $vIntOpt in

    0)
        clear
        adminMenu
        ;;
    
    1)
        clear

        vFltAccounting=$(cat "$HOME"/Documents/Database/profit.txt)
        echo "Total profit: $vFltAccounting"
        
        sleep 2
        clear

        accounting
        ;;
    
    2)
        clear

        vFltRecieve=$(cat "$HOME"/Documents/Database/profit.txt)
        echo "You recieved: $vFltRecieve"
        echo 0 > "$HOME"/Documents/Database/profit.txt

        sleep 2
        clear

        accounting
        ;;

    *)
        clear
        accounting
        ;;

    esac
}

#!/bin/bash

# Check if user has sudo privileges
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with sudo privileges" 
   exit 1
fi

adminMenu