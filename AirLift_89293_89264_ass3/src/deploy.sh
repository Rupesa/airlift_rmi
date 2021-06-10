bold=$(tput bold)
normal=$(tput sgr0)

echo "----------------------------------------------------------"
echo "${bold}AirLift Problem - Script - Deploy (Remote) ${normal}"
echo "----------------------------------------------------------"

echo -e "\n${bold}->${normal} Deploying GeneralRepos na máquina ${bold}01${normal}"
sshpass -f password.txt scp -r java.policy genclass.jar commInfra EntitiesState Interfaces SimulationParameters GeneralRepos sd406@l040101-ws01.ua.pt:airlift_rmi/ &

echo -e "\n${bold}->${normal} Deploying DepartureAirport na máquina ${bold}02${normal}"
sshpass -f password.txt scp -r java.policy genclass.jar commInfra EntitiesState Interfaces SimulationParameters DepartureAirport sd406@l040101-ws02.ua.pt:airlift_rmi/ &

echo -e "\n${bold}->${normal} Deploying Plane na máquina ${bold}03${normal}"
sshpass -f password.txt scp -r java.policy genclass.jar commInfra EntitiesState Interfaces SimulationParameters Plane sd406@l040101-ws03.ua.pt:airlift_rmi/ &

echo -e "\n${bold}->${normal} Deploying DestinationAirport na máquina ${bold}04${normal}"
sshpass -f password.txt scp -r java.policy genclass.jar commInfra EntitiesState Interfaces SimulationParameters DestinationAirport sd406@l040101-ws04.ua.pt:airlift_rmi/ &

echo -e "\n${bold}->${normal} Deploying Hostess na máquina ${bold}05${normal}"
sshpass -f password.txt scp -r java.policy genclass.jar commInfra EntitiesState Interfaces SimulationParameters Hostess sd406@l040101-ws05.ua.pt:airlift_rmi/ &

echo -e "\n${bold}->${normal} Deploying Pilot na máquina ${bold}06${normal}"
sshpass -f password.txt scp -r java.policy genclass.jar commInfra EntitiesState Interfaces SimulationParameters Pilot sd406@l040101-ws06.ua.pt:airlift_rmi/ &

echo -e "\n${bold}->${normal} Deploying Passenger na máquina ${bold}07${normal}"
sshpass -f password.txt scp -r java.policy genclass.jar commInfra EntitiesState Interfaces SimulationParameters Passenger sd406@l040101-ws07.ua.pt:airlift_rmi/ &

echo -e "\n${bold}->${normal} Deploying Registry na máquina ${bold}08${normal}"
sshpass -f password.txt scp -r java.policy genclass.jar commInfra EntitiesState Interfaces SimulationParameters Registry sd406@l040101-ws08.ua.pt:airlift_rmi/ &

echo -e "\n${normal}----------------------------------------------------------\n${normal}"
wait
echo -e "\n${normal}----------------------------------------------------------"

echo -e "\n${bold}>>>>>>>>>>${normal} A execução terminou"