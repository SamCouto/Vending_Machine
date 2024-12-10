#!/usr/bin/bash

: '

=============================================
| Author:            SamCouto               |
| Creation Date:     03.12.24               |
| Last Modification: 09.12.24               |
| Description:       Simple vending program |
| Usage:             ./vendingMachine       |
=============================================

About:

This program is a remake of a preveious program that I have made some years ago that simulates a vending machine.

Although the first version was written in python, this code written in bash have a lot of improvments, different ways to execute some functionalities and other stuff.

'
function main {
    echo "|===VENDING-MACHINE===|"
    echo "| 0. Exit             |"
    echo "| 1. Buy something    |"
    echo "| 2. Administration   |"
    echo "|=====================|"

    read -rp ">> " vIntOpt

    case $vIntOpt in

    0)
        clear
        exit
        ;;

    1)
        clear

        echo "|======================|"
        echo "| 1. Chips     | $ 5.0 |"
        echo "| 2. Chocolate | $ 8.0 |"
        echo "| 3. Lemonade  | $ 2.3 |"
        echo "| 4. Popsicle  | $ 1.0 |"
        echo "| 5. Soda      | $ 3.5 |"
        echo "| 6. Water     | $ 4.0 |"
        echo "|======================|"

        read -rp ">> " vIntVendOpt

        if [[ $vIntVendOpt -gt 0 ]] && [[ $vIntVendOpt -le 6 ]]; then
            paymentMethod $vIntVendOpt
        else
            clear
            echo "Invalid argument..."
            main
        fi
        ;;

    2) 
        clear
        sudo "$HOME/codingProjects/ShellScripts/Bash/vendingMachine/./adminPanel.sh"
        ;;

    *)
        clear
        main
        ;;

    esac
}

function paymentMethod {
    if [[ $1 = 1 ]]; then
        echo "test"
        vIntChips=$(cat "$HOME/Documents/Database/chips.txt" 2> "$HOME/Documents/Database/errors.txt")
        if [[ $vIntChips -gt 0 ]]; then
            read -rp 'Insert $5 >> ' vFltPayment
            if [[ $vFltPayment -eq 5 ]]; then
                ((vFltPayment - 5)) > "$HOME/Documents/Database/chips.txt"
                echo "Thank you!"
                sleep 2
                clear
                main
            elif [[ $vFltPayment -gt 5 ]]; then
                ((vFltPayment - 5)) > "$HOME/Documents/Database/chips.txt"
                echo "Thank you!"
                echo "Returning $vFltPayment"
                sleep 2

                clear
                main
            else
                echo "PAY CORRECTLY!"
                sleep 2

                clear
                main

                exit 0
            fi
        fi
    fi
}

# Finish later...
function adminPanel {
    echo "|==ADMINISTRATION==|"
    echo "| 0. Main Menu     |"
    echo "| 1. Storage       |"
    echo "| 2. Total Profit  |"
    echo "|==================|"

    read -rp ">> " vIntAdmOpt

    case $vIntAdmOpt in

    0)
        clear
        main
        ;;

    1)
        clear
        storage
        ;;

    2)
        # Fix tomorrow
        clear
        vFltAccounting=$(cat "$HOME/Documents/Database/profit.txt")
        echo "Total profit: $vFltAccounting"
        adminPanel
        ;;

    *)
        clear
        adminPanel
        exit 0
        ;;
    esac
}

# Checks if the database file exists
if [[ -d $HOME/Documents/Database/ ]]
then
    main
else
    echo "Crating the database..."

    mkdir "$HOME"/Documents/Database/
    touch "$HOME"/Documents/Database/chips.txt
    touch "$HOME"/Documents/Database/chocolate.txt
    touch "$HOME"/Documents/Database/lemonade.txt
    touch "$HOME"/Documents/Database/popsicle.txt
    touch "$HOME"/Documents/Database/soda.txt
    touch "$HOME"/Documents/Database/water.txt
    touch "$HOME"/Documents/Database/profit.txt

    echo "The database is ready!"

    main
    exit 0
fi