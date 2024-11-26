#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo -e "\033[1;31mYou should run this script with root!\033[0m"
    echo "Use sudo -i to change user to root"
    exit 1
fi
echo "installing ufw..."
    sleep 1s

    # Ensure ufw is installed
    if ! dpkg -l | grep -q ufw; then
        apt update
        apt install -y ufw
    fi
function isp_blocker {
    while true; do
        clear
        echo -e "\033[1;34m--------------------------------------\033[0m"
        echo -e "\033[1;32m           IR ISP MANAGEMENT           \033[0m"
        echo -e "\033[1;36m fork of github.com/Kiya6955/IR-ISP-Blocker   \033[0m"
        echo -e "\033[1;34m--------------------------------------\033[0m"
        echo -e "\033[1;32m1. \033[0mHamrah Aval"
        echo -e "\033[1;32m2. \033[0mIrancell"
        echo -e "\033[1;32m3. \033[0mMokhaberat"
        echo -e "\033[1;32m4. \033[0mRightel"
        echo -e "\033[1;32m5. \033[0mShatel"
        echo -e "\033[1;32m6. \033[0mAsiaTech"
        echo -e "\033[1;32m7. \033[0mPishgaman"
        echo -e "\033[1;32m8. \033[0mMobinNet"
        echo -e "\033[1;32m9. \033[0mParsOnline"
        echo -e "\033[1;32m10. \033[0mReset and delete all rules"
        echo -e "\033[1;32m11. \033[0mAll ISP"
        echo -e "\033[1;31m0. \033[0mReturn"
        echo -e "\033[1;34m--------------------------------------\033[0m"
        read -p "Enter your choice: " isp

        case $isp in
            1) isp="MCI" blocking_menu ;;
            2) isp="MTN" blocking_menu ;;
            3) isp="TCI" blocking_menu ;;
            4) isp="Rightel" blocking_menu ;;
            5) isp="Shatel" blocking_menu ;;
            6) isp="AsiaTech" blocking_menu ;;
            7) isp="Pishgaman" blocking_menu ;;
            8) isp="MobinNet" blocking_menu ;;
            9) isp="ParsOnline" blocking_menu ;;
            10) unblocker ;;
            11) isp="All-IRAN-IPs" blocking_menu ;;
            12) ufw_menu ;;
            0) echo "Returning to the main menu..."; break ;;
            *) echo -e "\033[1;31mInvalid option. Please try again.\033[0m"; sleep 2 ;;
        esac
    done
}

function blocking_menu {
    

    

    case $isp in
        "MCI") IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/mci-ips.ipv4') ;;
        "MTN") IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/mtn-ips.ipv4') ;;
        "TCI") IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/tci-ips.ipv4') ;;
        "Rightel") IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/rightel-ips.ipv4') ;;
        "Shatel") IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/shatel-ips.ipv4') ;;
        "AsiaTech") IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/asiatech-ips.ipv4') ;;
        "Pishgaman") IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/pishgaman-ips.ipv4') ;;
        "MobinNet") IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/mobinnet-ips.ipv4') ;;
        "ParsOnline") IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/parsan-ips.ipv4') ;;
        "All-IRAN-IPs") IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Mmdd93/IR-ISP-Blocker/main/all-iran-ips.ipv4') ;;
    esac

    if [ $? -ne 0 ]; then
        echo -e "\033[1;31mFailed to fetch the IP list. Please contact @Kiya6955\033[0m"
        read -p "Press enter to return to Menu" dummy
        blocking_menu
    fi      

    echo -e "\n\033[1;34m---------------$isp-----------------\033[0m"
    echo -e "\033[1;33m1. \033[0m Block $isp"
    echo -e "\033[1;33m2. \033[0m Allow $isp"
    echo -e "\033[1;33m3. \033[0m Return"
    echo -e "\033[1;34m-----------------------------------\033[0m"
    read -p 'Enter your choice: ' choice

    case $choice in
        1) blocker ;;
        2) only_mode ;;
        3) isp_blocker ;;
        *) echo "Invalid option press enter"; blocking_menu ;;
    esac
}

function blocker {
    clear
    echo -e "\033[1;34m-- Advanced Blocking Options for ISP --\033[0m"
    echo -e "\033[1;33m1. \033[0m Block specific ports for ISP"
    echo -e "\033[1;33m2. \033[0m Block all ports for ISP"
    echo -e "\033[1;33m3. \033[0m Return"
    echo -e "\033[1;34m---------------------------------------\033[0m"
    read -p 'Enter your choice: ' choice

    case $choice in
        1)
         # Block Specific Ports
         
        echo -e "\n\033[1;35mEnter the SSH port to allow for \033[1;32m$isp\033[1;35m (default is 22):\033[0m"
        read -p ' > ' SSH_PORT
        SSH_PORT=${SSH_PORT:-22}
    
        echo -e "\n\033[1;34mAllow SSH port\033[0m"
        ufw allow $SSH_PORT
        
        
          echo -e "\n\033[1;33mEnter the ports to block for $isp:\033[0m"
          echo -e "\033[1;33m(Use commas like 80,443\033[0m)"
          read -p '> ' ports
          IFS=',' read -r -a portArray <<< "$ports"
          
          
          
          echo -e "\n\033[1;33mApplying rules. Please wait...\033[0m"



        # Block the specified ports for all IPs (without protocol choice)
        total_ips=$(echo "$IP_LIST" | wc -w)  # Count number of IPs
        total_ports=${#portArray[@]}          # Count number of ports
        total_tasks=$((total_ips * total_ports))  # Total tasks = IPs * Ports
        current=0
        
        echo -e "\n\033[1;33mBlocking specified ports for $isp. Please wait...\033[0m"
        
        # Iterate through each IP and each port to apply the rules
        for ip in $IP_LIST; do
            for port in "${portArray[@]}"; do
                ufw deny from "$ip" to any port "$port" >/dev/null 2>&1

        # Update progress after each IP is processed
        ((current++))
        percent=$((current * 100 / total_tasks))

        # Display only the percentage
        echo -ne "\r\033[1;32mProgress: $percent%\033[0m"
        done
        done

        # Finish with a newline after completing all tasks
        echo -e "\n\033[1;32mAll specified ports successfully blocked for $isp.\033[0m"

        echo -e "\n\033[1;33m Enable ufw if not already enabled.\033[0m"
            if ! ufw status | grep -q "Status: active"; then
            ufw enable
            fi
            
            echo -e "\n\033[1;33m reload ufw.\033[0m"

            ufw reload >/dev/null 2>&1

            echo -e "\033[1;32mPorts [$ports] successfully blocked for $isp.\033[0m"

            ;;

        2)
        
         # Block All Ports
        
        echo -e "\n\033[1;35mEnter the SSH port to allow for \033[1;32m$isp\033[1;35m (default is 22):\033[0m"
        read -p ' > ' SSH_PORT
        SSH_PORT=${SSH_PORT:-22}
    
        echo -e "\n\033[1;34m allow SSH port\033[0m"
        ufw allow $SSH_PORT

    # Count the total number of IPs to deny
    total_ips=$(echo "$IP_LIST" | wc -w)  # Count the number of IPs
    current=0

    # Iterate through IP_LIST and deny traffic with progress update
    echo -e "\n\033[1;31mDenying traffic from $isp. Please wait...\033[0m"
    for ip in $IP_LIST; do
    ufw deny from "$ip" >/dev/null 2>&1  # Silently execute the command

    # Update progress
    ((current++))
    percent=$((current * 100 / total_ips))  # Calculate percentage progress

    # Show the percentage progress
    echo -ne "\r\033[1;31mProgress: $percent%\033[0m"
    done

            echo -e "\n\033[1;33m Enable ufw if not already enabled.\033[0m"
            if ! ufw status | grep -q "Status: active"; then
            ufw enable
            fi
            
            echo -e "\n\033[1;33m reload ufw.\033[0m"

            ufw reload >/dev/null 2>&1
            
            # Finish with a newline
            echo -e "\n\033[1;33mTraffic have been denied for $isp.\033[0m"
            read -p 'Press Enter to continue... '
            ;;
        3) # Return
            echo -e "\033[1;33mReturning to the main menu...\033[0m"
            ;;
        *) # Invalid Option
            echo -e "\033[1;31mInvalid choice. Returning to menu.\033[0m"
            ;;
    esac
}


only_mode() {

# Count the total number of IPs
    
    echo -e "\n\033[1;35mEnter the SSH port to allow for \033[1;32m$isp\033[1;35m (default is 22):\033[0m"
    read -p ' > ' SSH_PORT
    SSH_PORT=${SSH_PORT:-22}
    
    echo -e "\n\033[1;34m allow SSH port\033[0m"
    ufw allow $SSH_PORT

    echo -e "\n\033[1;34mEnter white list ports for all ISPs:\033[0m"
    echo -e "\033[1;34m(separate with commas, e.g., 80,443 or leave empty)\033[0m"
    read -p ' > ' allowlist_ports
    IFS=',' read -r -a allowlistPortArray <<< "$allowlist_ports"

    echo -e "\n\033[1;35mEnter white list IPs for all ISPs:\033[0m"
    echo -e "\033[1;35m(separate with commas, e.g., 1.1.1.1,8.8.8.8 or leave empty)\033[0m"
    read -p '> ' whitelist_ips
    IFS=',' read -r -a whitelistIPArray <<< "$whitelist_ips"

    echo -e "\033[1;35mAllowing traffic for all ISPs on specified ports...\033[0m"
    for port in "${allowlistPortArray[@]}"; do
        ufw allow $port
    done

    echo -e "\033[1;35mAllowing traffic for whitelist IP for all ISPs...\033[0m"
    for ip in "${whitelistIPArray[@]}"; do
        ufw allow from $ip
    done

    
    
      echo -e "\033[1;35mAllowing traffic for \033[1;32m$isp\033[1;35m. Please wait...\033[0m"
      
      # Count the total number of IPs to deny
      total_ips=$(echo "$IP_LIST" | wc -w)  # Count the number of IPs
      current=0
      
      # Iterate through IP_LIST and deny traffic with progress update
      echo -e "\n\033[1;33mAllowing traffic from $isp. Please wait...\033[0m"
      for ip in $IP_LIST; do
          ufw allow from "$ip" >/dev/null 2>&1  # Silently execute the command
      
          # Update progress
          ((current++))
          percent=$((current * 100 / total_ips))  # Calculate percentage progress
      
          # Show the percentage progress
          echo -ne "\r\033[1;31mProgress: $percent%\033[0m"
      done
      
      
      
      echo -e "\n\033[1;33mTraffic allowed for \033[1;32m$isp\033[1;33m and configured successfully.\033[0m"
      
      # Echo message for the default deny rule
      echo -e "\n\033[1;31mBlocking all incoming traffic except for $isp and white list IPs/ports...\033[0m"
      
      # Deny all other incoming traffic
      ufw default deny incoming
      
      echo -e "\033[1;33mEnabling UFW...\033[0m"
      ufw enable


    read -p 'Press Enter to continue... '
}



function unblocker {
    echo -e "\033[1;33mDo you want to reset all existing rules? [Y/N]:\033[0m"
    read -p '> ' confirm
    if [[ $confirm =~ ^[Yy]$ ]]; then
        ufw --force reset
        
    fi
    read -p 'Press Enter to continue... '
}

isp_blocker
