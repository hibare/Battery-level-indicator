#!/bin/sh

#Installation script
#Declaring color variables
CYAN='\033[0;36m'       #CYAN COLOUR
NC='\033[0m'            #NO COLOUR
GREEN='\033[0;32m'      #GREEN COLOUR
RED='\033[0;31m'        #RED COLOUR
YELLOW='\033[1;33m'

#Clear terminal screen
clear

#Banner
echo "======================================================"
echo "+             Install battery notifier               +"
echo "======================================================"                                                  
echo "    [0;1;34;94m▄▄▄▄[0m   [0;34m▄▄▄▄▄▄[0m               [0;37m▄▄▄▄▄[0m   [0;1;30;90m▄▄▄[0m    [0;1;30;90m▄▄▄[0m"
echo "  [0;34m██▀▀▀▀█[0m  [0;34m██▀▀▀[0;37m▀██[0m   [0;37m▄████▄[0m   [0;37m█[0;1;30;90m▀▀▀▀██▄[0m  [0;1;30;90m██▄[0m  [0;1;30;90m▄█[0;1;34;94m█[0m" 
echo " [0;34m██▀[0m       [0;37m██[0m    [0;37m██[0m [0;37m▄██▀[0m  [0;1;30;90m▀██[0m        [0;1;30;90m██[0m   [0;1;34;94m██▄▄██[0m " 
echo " [0;37m██[0m        [0;37m█████[0;1;30;90m██[0m  [0;1;30;90m██[0m [0;1;30;90m▄█████[0m      [0;1;34;94m▄█▀[0m     [0;1;34;94m▀██▀[0m"   
echo " [0;37m██▄[0m       [0;1;30;90m██[0m  [0;1;30;90m▀██▄[0m [0;1;30;90m██[0m [0;1;30;90m█[0;1;34;94m█▄▄██[0m    [0;1;34;94m▄█▀[0m        [0;34m██[0m"    
echo "  [0;1;30;90m██▄▄▄▄█[0m  [0;1;30;90m██[0m    [0;1;34;94m██[0m [0;1;34;94m▀█▄[0m [0;1;34;94m▀▀▀▀▀[0m  [0;1;34;94m▄[0;34m██▄▄▄▄▄[0m     [0;34m██[0m"    
echo "    [0;1;30;90m▀▀▀▀[0m   [0;1;34;94m▀▀[0m    [0;1;34;94m▀▀▀[0m [0;1;34;94m▀██[0;34m▄▄▄█▄[0m  [0;34m▀▀▀▀▀▀▀▀[0m     [0;37m▀▀[0m"    
echo "                       [0;34m▀▀▀▀▀[0m"                      
                                                
echo "======================================================"
echo "  Developed by : Shubham Hibare (CR@2Y)"
echo "  Website      : http://hibare.in"  
echo "  Github       : https://hibare.github.io/"
echo "  Linkedin     : https://linkedin.com/in/hibare"
echo "  License      : Unlicensed"
echo "======================================================"
echo "${RED}Disclaimer:${NC} Author of this script is not responsible 
for any damage caused to your system from using this 
script. Use this script at your own risk. You have ${RED}15 
seconds${NC} to abort the process."
echo "======================================================"
sleep 15

#Check for dependencies
echo "${CYAN}Checking for dependencies${NC}..."

#Check package espeak
echo -n "[*] Checking for package espeak ... "
which upower > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "${GREEN}[Present]${NC}"
else
	echo "${RED}[Absent]${NC}"
	echo "${YELLOW}Please install it and then continue ${NC}"
	echo "${RED}ABORT${NC}"
	exit
fi

#Remember present working directory
pwd=`pwd`

#Create filesystem
echo "${CYAN}Creating file structure ... ${NC}"

#Make a directory to hold the script
echo -n "[*] Creating script directory ... "
mkdir -p  ~/.crazyScripts/BatteryNotify > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "${GREEN}[Done]${NC}"
else
	echo "${RED}[Failed]${NC}"
	exit
fi

#Begin installation
echo "${CYAN}Installing program ... ${NC}"

#Copy script to the location
echo -n "[*] Installing script ... "
cp src/main.sh ~/.crazyScripts/BatteryNotify/ > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "${GREEN}[Done]${NC}"
else
	echo "${RED}[Failed]${NC}"
fi

#Change permissions
echo -n "[*] Adjusting permissions ... "
chmod 755 ~/.crazyScripts/BatteryNotify/main.sh
if [ $? -eq 0 ]; then
	echo "${GREEN}[Done]${NC}"
else
	echo "${RED}[Failed]${NC}"
	exit
fi

#create a cron job
echo -n "[*] Creating cron job ... "
(crontab -l 2>/dev/null; echo "* * * * * sh ~/.crazyScripts/BatteryNotify/main.sh") | crontab -
if [ $? -eq 0 ]; then
	echo "${GREEN}[Done]${NC}"
else
	echo "${RED}[Failed]${NC}"
	exit
fi

echo "${GREEN} Completed."
