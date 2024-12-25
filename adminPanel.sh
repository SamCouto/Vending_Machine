#!/bin/bash

: '

===========================================
| Author:            SamCouto             |
| Creation Date:     09.12.24             |
| Last Modification: 25.12.24             |
| Description:       Administration panel |
| Usage:             ./adminPanel         |
===========================================

About:

Here the administrator can check and manipulate the vending machine storage, and it can check and recieve the total profit made by the machine.

'

function adminMenu {
    echo "|==ADMINISTRATION==|"
    echo "| 0. Return        |"
    echo "| 1. Storage       |"
    echo "| 2. Profit        |"
    echo "|==================|"

    read -rp ">> " vIntOpt

    case $vIntOpt in

    0)
        clear

        # Get the home directory of the user that executed the script as sudo
        cUserHome=$(getent passwd "$SUDO_USER" | cut -d: -f6)
        sudo -u "$SUDO_USER" "$cUserHome/gitlab-projects/vending-machine/./vendingMachine.sh"
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
    cUserHome=$(getent passwd "$SUDO_USER" | cut -d: -f6)

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
        vStrGetChips=$(cat "$cUserHome/Documents/Database/chips.txt")
        vStrGetChocolate=$(cat "$cUserHome/Documents/Database/chocolate.txt")
        vStrGetLemonade=$(cat "$cUserHome/Documents/Database/lemonade.txt")
        vStrGetPopsicle=$(cat "$cUserHome/Documents/Database/popsicle.txt")
        vStrGetSoda=$(cat "$cUserHome/Documents/Database/soda.txt")
        vStrGetWater=$(cat "$cUserHome/Documents/Database/water.txt")

        echo "================="
        echo " Chips     | $vStrGetChips"
        echo " Chocolate | $vStrGetChocolate"
        echo " Lemonade  | $vStrGetLemonade"
        echo " Popsicle  | $vStrGetPopsicle"
        echo " Soda      | $vStrGetSoda"
        echo " Water     | $vStrGetWater"
        echo "================="
        echo ""

        storage
        ;;
    
    2)
        echo "|==============|"
        echo "| 1. Chips     |"
        echo "| 2. Chocolate |"
        echo "| 3. Lemonade  |"
        echo "| 4. Popsicle  |"
        echo "| 5. Soda      |"
        echo "| 6. Water     |"
        echo "|==============|"

        read -rp "Which product you want to restock? " vIntProduct

        case $vIntProduct in

        1)
            read -rp "How much you are going to restock? " vIntRestock
            vStrGetChips=$(cat "$cUserHome/Documents/Database/chips.txt")
            echo $((vStrGetChips + vIntRestock)) > "$cUserHome/Documents/Database/chips.txt"
            echo "Database updated succesfully"

            sleep 2
            clear
            storage
            ;;

        2)
            read -rp "How much you are going to restock? " vIntRestock
            vStrGetChocolate=$(cat "$cUserHome/Documents/Database/chocolate.txt")
            echo $((vStrGetChocolate + vIntRestock)) > "$cUserHome/Documents/Database/chocolate.txt"
            echo "Database updated succesfully"

            sleep 2
            clear
            storage
            ;;

        3)
            read -rp "How much you are going to restock? " vIntRestock
            vStrGetLemonade=$(cat "$cUserHome/Documents/Database/lemonade.txt")
            echo $((vStrGetLemonade + vIntRestock)) > "$cUserHome/Documents/Database/lemonade.txt"
            echo "Database updated succesfully"

            sleep 2
            clear
            storage
            ;;

        4)
            read -rp "How much you are going to restock? " vIntRestock
            vStrGetPopsicle=$(cat "$cUserHome/Documents/Database/popsicle.txt")
            echo $((vStrGetPopsicle + vIntRestock)) > "$cUserHome/Documents/Database/popsicle.txt"
            echo "Database updated succesfully"

            sleep 2
            clear
            storage
            ;;

        5)
            read -rp "How much you are going to restock? " vIntRestock
            vStrGetSoda=$(cat "$cUserHome/Documents/Database/soda.txt")
            echo $((vStrGetSoda + vIntRestock)) > "$cUserHome/Documents/Database/soda.txt"
            echo "Database updated succesfully"

            sleep 2
            clear
            storage
            ;;

        6)
            read -rp "How much you are going to restock? " vIntRestock
            vStrGetWater=$(cat "$cUserHome/Documents/Database/water.txt")
            echo $((vStrGetWater + vIntRestock)) > "$cUserHome/Documents/Database/water.txt"
            echo "Database updated succesfully"

            sleep 2
            clear
            storage
            ;;

        *)
            clear
            storage
            ;;

        esac
        ;;
    
    *)
        clear
        storage
        ;;
    
    esac
}

function accounting {
    cUserHome=$(getent passwd "$SUDO_USER" | cut -d: -f6)

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

        vIntAccounting=$(cat "$cUserHome"/Documents/Database/profit.txt)
        echo "Total profit: $vIntAccounting"
        
        sleep 2
        clear

        accounting
        ;;
    
    2)
        clear

        vIntRecieve=$(cat "$cUserHome"/Documents/Database/profit.txt)
        echo "You recieved: $vIntRecieve"
        echo 0 > "$cUserHome"/Documents/Database/profit.txt

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

# Check if user has sudo privileges
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with sudo privileges" 
   exit 1
fi

adminMenu