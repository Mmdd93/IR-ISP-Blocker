#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    clear
    echo "You should run this script with root!"
    echo "Use sudo -i to change user to root"
    exit 1
fi

function isp_blocker {
    clear


echo -e "\033[1;34m--------------------------------------\033[0m"
echo -e "\033[1;32m           IR ISP MANAGEMENT           \033[0m"
echo -e "\033[1;34m--------------------------------------\033[0m"
echo -e "\033[1;36m   https://github.com/Kiya6955/IR-ISP-Blocker   \033[0m"
echo -e "\033[1;34m--------------------------------------\033[0m"
echo -e "\033[1;33mWhich ISP do you want to perform an action on?\033[0m"
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
echo -e "\033[1;32m11. \033[0mAll IRAN ISP"
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
    0) echo "Exiting..."; exit 0 ;;
    *) echo "Invalid option"; isp_blocker ;;
    esac
}

function blocking_menu {
    echo "ٌWait a minute, installing prerequisites..."
    sleep 2s

    

    if ! dpkg -l | grep -q iptables; then
        apt update
        apt install -y iptables
    fi

    if ! dpkg -l | grep -q iptables-persistent; then
        apt update
        apt install -y iptables-persistent
    fi

    if ! iptables -L isp-blocker -n >/dev/null 2>&1; then
        iptables -N isp-blocker
    fi

    if ! iptables -C INPUT -j isp-blocker &> /dev/null; then
        iptables -I INPUT -j isp-blocker
    fi

    
    

    case $isp in
        "MCI")
            IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/mci-ips.ipv4')
            ;;
        "MTN")
            IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/mtn-ips.ipv4')
            ;;
        "TCI")
            IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/tci-ips.ipv4')
            ;;
        "Rightel")
            IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/rightel-ips.ipv4')
            ;;
        "Shatel")
            IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/shatel-ips.ipv4')
            ;;
        "AsiaTech")
            IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/asiatech-ips.ipv4')
            ;;
        "Pishgaman")
            IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/pishgaman-ips.ipv4')
            ;;
        "MobinNet")
            IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/mobinnet-ips.ipv4')
            ;;
        "ParsOnline")
            IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Kiya6955/IR-ISP-Blocker/main/parsan-ips.ipv4')
            ;;
        "All-IRAN-IPs")
            IP_LIST=$(curl -s 'https://raw.githubusercontent.com/Mmdd93/IR-ISP-Blocker/main/all-iran-ips.ipv4')
            ;;
    esac

    if [ $? -ne 0 ]; then
        echo "Failed to fetch the IP list. Please contact @Kiya6955"
        read -p "Press enter to return to Menu" dummy
        blocking_menu
    fi      
        
    clear



echo -e "\033[1;34m-----------------------------------\033[0m"
echo -e "\033[1;32m              $isp                 \033[0m"
echo -e "\033[1;34m-----------------------------------\033[0m"
echo -e "\033[1;33m1. \033[0m Blocking $isp"
echo -e "\033[1;33m2. \033[0m Allowing $isp"
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
    


echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1;32m       Port Blocking Options for $isp   \033[0m"
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1;33m1. \033[0m Block specific ports for $isp"
echo -e "\033[1;33m2. \033[0m Block all ports for $isp"
echo -e "\033[1;33m3. \033[0m Return"
echo -e "\033[1;34m----------------------------------------\033[0m"
read -p 'Enter your choice: ' choice


        clear
        echo -e "\033[1;33mEnter whitelist IPs for \033[1;32m$isp\033[1;33m:\033[0m"
echo -e "\033[1;33m(separate with commas like \033[1;36m1.1.1.1,8.8.8.8\033[1;33m or leave empty for none)\033[0m"
read -p '> ' whitelist_ips

        IFS=',' read -r -a whitelistIPArray <<< "$whitelist_ips"
        
        clear
        if [[ $choice == 1 ]]; then
echo -e "\033[1;33mEnter the ports you want to block for \033[1;32m$isp\033[1;33m:\033[0m"
echo -e "\033[1;33m(enter a single port like \033[1;36m443\033[1;33m or separated by commas like \033[1;36m443,8443\033[1;33m)\033[0m"
read -p '> ' ports

            IFS=',' read -r -a portArray <<< "$ports"
        fi

        case $choice in
            1)
                
                echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1;32mProtocol to block for \033[1;36m$isp\033[0m"
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1;33m1. \033[0mTCP & UDP"
echo -e "\033[1;33m2. \033[0mTCP"
echo -e "\033[1;33m3. \033[0mUDP"
echo -e "\033[1;34m----------------------------------------\033[0m"
read -p 'Enter your choice: ' protocol


                case $protocol in
                1) protocol="all" ;;
                2) protocol="tcp" ;;
                3) protocol="udp" ;;
                *) echo "Invalid option"; blocker ;;
                esac
                
                
               read -p 'Do you want to delete the previous rules?[Y/N]:' confirm
                if [[ $confirm == [Yy]* ]]; then
                    iptables -F isp-blocker
                    echo -e "\033[1;32mPrevious rules deleted successfully\033[0m"
                    sleep 1s
                fi

                
                echo -e "\033[1;33mBlocking [$ports] for \033[1;32m$isp\033[1;33m started, please wait...\033[0m"

for ip in "${whitelistIPArray[@]}"; do
    iptables -I isp-blocker -s $ip -j ACCEPT
done

for port in "${portArray[@]}"
do
    for IP in $IP_LIST; do
        if [ "$protocol" == "all" ]; then
            iptables -A isp-blocker -s $IP -p tcp --dport $port -j DROP
            iptables -A isp-blocker -s $IP -p udp --dport $port -j DROP
        else
            iptables -A isp-blocker -s $IP -p $protocol --dport $port -j DROP
        fi
    done
done

iptables-save > /etc/iptables/rules.v4


if [ "$protocol" == "all" ]; then
    echo -e "\033[1;32mTCP & UDP [$ports] successfully blocked for \033[1;32m$isp.\033[0m"
else
    echo -e "\033[1;32m$protocol [$ports] successfully blocked for \033[1;32m$isp.\033[0m"
fi
;;

# Option 2
echo -e "\033[1;33mEnter the ports you want to whitelist for \033[1;32m$isp\033[1;33m:\033[0m"
echo -e "\033[1;33m(enter a single port or separated by commas like \033[1;36m443,8443\033[1;33m)\033[0m"
echo -e "\033[1;33mLeave empty for none\033[0m"
read -p '> ' whitelist_ports

IFS=',' read -r -a whitelistPortArray <<< "$whitelist_ports"



read -p "Enter the SSH port you want open for $isp (default is 22): " SSH_PORT
SSH_PORT=${SSH_PORT:-22}


read -p "Do you want to delete the previous rules? [Y/N] : " confirm
if [[ $confirm == [Yy]* ]]; then
    iptables -F isp-blocker
    echo -e "\033[1;32mPrevious rules deleted successfully\033[0m"
    sleep 2s
fi


echo -e "\033[1;33mBlocking all ports for \033[1;32m$isp\033[1;33m started, please wait...\033[0m"

for ip in "${whitelistIPArray[@]}"; do
    iptables -I isp-blocker -s $ip -j ACCEPT
done

for port in "${whitelistPortArray[@]}"; do
    iptables -I isp-blocker -p tcp --dport $port -j ACCEPT
    iptables -I isp-blocker -p udp --dport $port -j ACCEPT
done

if ! iptables -C isp-blocker -p tcp --dport "$SSH_PORT" -j ACCEPT 2>/dev/null; then
    iptables -I isp-blocker -p tcp --dport "$SSH_PORT" -j ACCEPT
fi

for IP in $IP_LIST; do
    iptables -A isp-blocker -s $IP -j DROP
done

iptables-save > /etc/iptables/rules.v4


echo -e "\033[1;32m$isp successfully blocked for all ports.\033[0m"
echo -e "\033[1;32mPort $SSH_PORT has been opened for SSH.\033[0m"
;;

# Option 3
*) 
    echo -e "\033[1;31mInvalid option\033[0m"
    blocking_menu
    ;;
esac
read -p "Press enter to return to Menu" dummy
blocking_menu
}

function only_mode {
    
    read -p "Enter your SSH port (default is 22): " SSH_PORT
    SSH_PORT=${SSH_PORT:-22}
    
    
    read -p "Enter ports to block for all ISPs except $isp (separate with comma e.g 443,8443): " blocklist_ports
    IFS=',' read -r -a blocklistPortArray <<< "$blocklist_ports"
    
    if [[ -z "$blocklist_ports" ]]; then
        blocking_menu
        return
    fi

    blocklistPortArray=("${blocklistPortArray[@]}")

    
    
    echo -e "\033[1;33mEnter whitelist IP addresses for (${blocklistPortArray[*]// /, }):\033[0m"
    echo -e "\033[1;33m(enter a single ip or separated by commas like \033[1;36m1.1.1.1,8.8.8.8\033[1;33m)\033[0m"
    echo -e "\033[1;33mleave empty for none\033[0m"
    read -p '> ' whitelist_ips
    IFS=',' read -r -a whitelistIPArray <<< "$whitelist_ips"
    

    
    read -p "Do you want to delete the previous rules? [Y/N]: " confirm
    if [[ $confirm == [Yy]* ]]; then
        iptables -F isp-blocker
        echo -e "\033[1;32mPrevious rules deleted successfully\033[0m"
        sleep 2s
    fi

    
    echo -e "\033[1;33mBlocking all ISPs for ports (${blocklistPortArray[*]// /, }) except \033[1;32m$isp\033[1;33m started...\033[0m"
    echo -e "\033[1;33mplease wait...\033[0m"

    for IP in $IP_LIST; do
        for port in "${blocklistPortArray[@]}"; do
            iptables -I isp-blocker -s $IP -p tcp --dport $port -j ACCEPT
            iptables -I isp-blocker -s $IP -p udp --dport $port -j ACCEPT
        done
    done

    for ip in "${whitelistIPArray[@]}"; do
        iptables -I isp-blocker -s $ip -j ACCEPT
    done
    
    if ! iptables -C isp-blocker -p tcp --dport "$SSH_PORT" -j ACCEPT 2>/dev/null; then
        iptables -I isp-blocker -p tcp --dport "$SSH_PORT" -j ACCEPT
    fi
    
    for port in "${blocklistPortArray[@]}"; do
        if ! iptables -C isp-blocker -p tcp --dport $port -j DROP 2>/dev/null; then
            iptables -A isp-blocker -p tcp --dport $port -j DROP
        fi
        if ! iptables -C isp-blocker -p udp --dport $port -j DROP 2>/dev/null; then
            iptables -A isp-blocker -p udp --dport $port -j DROP
        fi
    done
    
    iptables-save > /etc/iptables/rules.v4

    
    echo -e "\033[1;32mPorts (${blocklistPortArray[*]// /, }) blocked for all ISPs except \033[1;32m$isp\033[0m successfully"
}

function unblocker {
    
    iptables -F isp-blocker
    iptables-save > /etc/iptables/rules.v4
    clear
    echo -e "\033[1;32mAll ISPs Unblocked successfully!\033[0m"
    read -p "Press enter to return to Menu" dummy
    isp_blocker
}

isp_blocker
