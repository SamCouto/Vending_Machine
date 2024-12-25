#!/usr/bin/bash

: '

=============================================
| Author:            SamCouto               |
| Creation Date:     03.12.24               |
| Last Modification: 25.12.24               |
| Description:       Simple vending program |
| Usage:             ./vendingMachine       |
=============================================

'

function createDatabase {
    echo "Crating the database..."

    # Creates the database directory
    mkdir "$HOME/Documents/Database/"

    # Creates the database files
    echo 10 > "$HOME/Documents/Database/chips.txt"
    echo 10 > "$HOME/Documents/Database/chocolate.txt"
    echo 10 > "$HOME/Documents/Database/lemonade.txt"
    echo 10 > "$HOME/Documents/Database/popsicle.txt"
    echo 10 > "$HOME/Documents/Database/soda.txt"
    echo 10 > "$HOME/Documents/Database/water.txt"
    echo 0 > "$HOME/Documents/Database/profit.txt"

    echo "The database is ready!"

    main
    exit 0
}

function checkDatabase {
    echo "Verifying database files..."

    if [[ -z $(ls -A "$HOME/Documents/Database/") ]]; then
        echo "The database is empty!"
        sleep 2

        createDatabase
    elif [[ $(find "$HOME/Documents/Database/" -type f | wc -l) -lt 7 ]]; then
        echo "Some file is missing, verify it please!"
        sleep 2

        exit
    else
        echo "Checking finished!"
        sleep 2

        clear
        main

        exit 0
    fi
}

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
        echo "| 3. Lemonade  | $ 2.0 |"
        echo "| 4. Popsicle  | $ 1.0 |"
        echo "| 5. Soda      | $ 3.0 |"
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
        sudo "$HOME/gitlab-projects/vending-machine/./adminPanel.sh"
        ;;

    *)
        clear
        main
        ;;

    esac
}

function paymentMethod {
    # Declaring the quantity of products to further validations
    vIntChips=$(cat "$HOME/Documents/Database/chips.txt")
    vIntChocolate=$(cat "$HOME/Documents/Database/chocolate.txt")
    vIntLemonade=$(cat "$HOME/Documents/Database/lemonade.txt")
    vIntPopsicle=$(cat "$HOME/Documents/Database/popsicle.txt")
    vIntSoda=$(cat "$HOME/Documents/Database/soda.txt")
    vIntWater=$(cat "$HOME/Documents/Database/water.txt")
    vIntProfit=$(cat "$HOME/Documents/Database/profit.txt")


    case $1 in

    1)
        if [[ $vIntChips -gt 0 ]]; then
            read -rp 'Insert $5 >> ' vIntPayment
            if [[ $vIntPayment -eq 5 ]]; then
                echo $((vIntProfit + 5)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/chips.txt"
                
                echo "Thank you!"
                sleep 2

                clear
                main
            elif [[ $vIntPayment -gt 5 ]]; then                
                echo $((vIntProfit + 5)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/chips.txt"
                
                vIntReturn=$((vIntPayment - 5))

                echo "Returning $vIntReturn"
                echo "Thank you!"
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
        else
            echo "There's no longer chips in this machine!"
            echo "Talk to the administrator please."
        fi
        ;;

    2)
        if [[ $vIntChocolate -gt 0 ]]; then
            read -rp 'Insert $8 >> ' vIntPayment
            if [[ $vIntPayment -eq 8 ]]; then
                echo $((vIntProfit + 8)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/chocolate.txt"
                
                echo "Thank you!"
                sleep 2

                clear
                main
            elif [[ $vIntPayment -gt 8 ]]; then
                echo $((vIntProfit + 8)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/chocolate.txt"

                vIntReturn=$((vIntPayment - 8))

                echo "Returning $vIntReturn"
                echo "Thank you!"
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
        else
            echo "There's no longer chocolate in this machine!"
            echo "Talk to the administrator please."
        fi
        ;;

    3)
        if [[ $vIntLemonade -gt 0 ]]; then
            read -rp 'Insert $ >> ' vIntPayment
            if [[ $vIntPayment -eq 2 ]]; then
                echo $((vIntProfit + 2)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/lemonade.txt"
                
                echo "Thank you!"
                sleep 2

                clear
                main
            elif [[ $vIntPayment -gt 2 ]]; then
                echo $((vIntProfit + 2)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/lemonade.txt"

                vIntReturn=$((vIntPayment - 2))

                echo "Returning $vIntReturn"
                echo "Thank you!"
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
        else
            echo "There's no longer lemonade in this machine!"
            echo "Talk to the administrator please."
        fi
        ;;

    4)
        if [[ $vIntPopsicle -gt 0 ]]; then
            read -rp 'Insert $1 >> ' vIntPayment
            if [[ $vIntPayment -eq 1 ]]; then
                echo $((vIntProfit + 1)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/popsicle.txt"
                
                echo "Thank you!"
                sleep 2

                clear
                main
            elif [[ $vIntPayment -gt 1 ]]; then
                echo $((vIntProfit + 1)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/popsicle.txt"

                vIntReturn=$((vIntPayment - 1))

                echo "Returning $vIntReturn"
                echo "Thank you!"
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
        else
            echo "There's no longer popsicle in this machine!"
            echo "Talk to the administrator please."
        fi
        ;;

    5)
        if [[ $vIntSoda -gt 0 ]]; then
            read -rp 'Insert $3 >> ' vIntPayment
            if [[ $vIntPayment -eq 3 ]]; then
                echo $((vIntProfit + 3)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/soda.txt"
                
                echo "Thank you!"
                sleep 2

                clear
                main
            elif [[ $vIntPayment -gt 3 ]]; then
                echo $((vIntProfit + 3)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/soda.txt"

                vIntReturn=$((vIntPayment - 3))

                echo "Returning $vIntReturn"
                echo "Thank you!"
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
        else
            echo "There's no longer soda in this machine!"
            echo "Talk to the administrator please."
        fi
        ;;

    6)
        if [[ $vIntWater -gt 0 ]]; then
            read -rp 'Insert $4 >> ' vIntPayment
            if [[ $vIntPayment -eq 4 ]]; then
                echo $((vIntProfit + 4)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/water.txt"
                
                echo "Thank you!"
                sleep 2

                clear
                main
            elif [[ $vIntPayment -gt 4 ]]; then
                echo $((vIntProfit + 4)) > "$HOME/Documents/Database/profit.txt"
                echo $((vIntChips - 1)) > "$HOME/Documents/Database/water.txt"

                vIntReturn=$((vIntPayment - 4))

                echo "Returning $vIntReturn"
                echo "Thank you!"
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
        else
            echo "There's no longer water in this machine!"
            echo "Talk to the administrator please."
        fi
        ;;

    *)
        echo "Invalid option!"
        
        clear
        main
        ;;

    esac
}

# Checks if the database folder exists
echo "Starting database check..."
sleep 2

if [[ -d $HOME/Documents/Database/ ]]
then
    checkDatabase
else
    createDatabase
fi