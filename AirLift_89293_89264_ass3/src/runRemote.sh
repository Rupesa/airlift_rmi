bold=$(tput bold)
normal=$(tput sgr0)

echo "----------------------------------------------------------"
echo "${bold}AirLift Problem - Script - Run (Remote) ${normal}"
echo "----------------------------------------------------------"

export SSHPASS='sistemas2021'

echo -e "\n${bold}->${normal} A iniciar e executar Registry na máquina ${bold}8${normal}"
sshpass -e ssh -o StrictHostKeyChecking=no sd406@l040101-ws08.ua.pt << EOF

    cd Public/Registry
    nohup rmiregistry -J-Djava.rmi.server.useCodebaseOnly=false 22455  > /dev/null 2>&1 &
    cd ..

    sleep 5
    
    nohup java -cp ".:./genclass.jar"\
        -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/"\
        -Djava.rmi.server.useCodebaseOnly=false\
        -Djava.security.policy=java.policy\
        Registry/ServerRegisterRemoteObject  > /dev/null 2>&1 &
    

EOF

sleep 1

echo -e "\n${bold}->${normal} A executar GeneralRepos na máquina ${bold}1${normal}"
sshpass -e ssh -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt << EOF

    cd airlift_rmi/
    java -cp ".:./genclass.jar"\
        -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/"\
        -Djava.rmi.server.useCodebaseOnly=false\
        -Djava.security.policy=java.policy\
        GeneralRepos/MainProgram &

EOF

sleep 1

echo -e "\n${bold}->${normal} A executar DepartureAirport na máquina ${bold}2${normal}"
sshpass -e ssh -o StrictHostKeyChecking=no sd406@l040101-ws02.ua.pt << EOF

    cd airlift_rmi/
    java -cp ".:./genclass.jar"\
        -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/"\
        -Djava.rmi.server.useCodebaseOnly=false\
        -Djava.security.policy=java.policy\
        DepartureAirport/MainProgram &

EOF

sleep 1

echo -e "\n${bold}->${normal} A executar Plane na máquina ${bold}3${normal}"
sshpass -e ssh -o StrictHostKeyChecking=no sd406@l040101-ws03.ua.pt << EOF

    cd airlift_rmi/
    java -cp ".:./genclass.jar"\
        -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/"\
        -Djava.rmi.server.useCodebaseOnly=false\
        -Djava.security.policy=java.policy\
        Plane/MainProgram &

EOF

sleep 1

echo -e "\n${bold}->${normal} A executar DestinationAirport na máquina ${bold}4${normal}"
sshpass -e ssh -o StrictHostKeyChecking=no sd406@l040101-ws04.ua.pt << EOF

    cd airlift_rmi/
    java -cp ".:./genclass.jar"\
        -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/"\
        -Djava.rmi.server.useCodebaseOnly=false\
        -Djava.security.policy=java.policy\
        DestinationAirport/MainProgram &

EOF

# Wait for the shared regions to be launched before lanching the intervening enities

sleep 5

echo -e "\n${bold}->${normal} A executar Hostess na máquina ${bold}5${normal}"
sshpass -e ssh -o StrictHostKeyChecking=no sd406@l040101-ws05.ua.pt << EOF

    cd airlift_rmi/
    java -cp ".:./genclass.jar"\
        -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/"\
        -Djava.rmi.server.useCodebaseOnly=false\
        Hostess/MainProgram &

EOF

sleep 1

echo -e "\n${bold}->${normal} A executar Pilot na máquina ${bold}6${normal}"
sshpass -e ssh -o StrictHostKeyChecking=no sd406@l040101-ws06.ua.pt << EOF

    cd airlift_rmi/
    java -cp ".:./genclass.jar"\
        -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/"\
        -Djava.rmi.server.useCodebaseOnly=false\
        Pilot/MainProgram &

EOF

sleep 1

echo -e "\n${bold}->${normal} A executar Passenger na máquina ${bold}7${normal}"
sshpass -e ssh -o StrictHostKeyChecking=no sd406@l040101-ws07.ua.pt << EOF

    cd airlift_rmi/
    java -cp ".:./genclass.jar"\
        -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/"\
        -Djava.rmi.server.useCodebaseOnly=false\
        Passenger/MainProgram &

EOF

echo -e "\n${normal}----------------------------------------------------------\n${normal}"
wait
echo -e "\n${normal}----------------------------------------------------------"

echo -e "\n${bold}>>>>>>>>>>${normal} A execução terminou"
