bold=$(tput bold)
normal=$(tput sgr0)

echo "----------------------------------------------------------------"
echo "${bold}            AirLift Problem - Script Remote ${normal}"
echo "----------------------------------------------------------------"

export SSHPASS='sistemas2021'

##############################################################################
echo -e "\n${bold} Creating target directories ${normal}"
mkdir -p DepartureAirport/target/EntitiesState
mkdir -p DepartureAirport/target/Interfaces
mkdir -p DepartureAirport/target/MainPackage

mkdir -p DestinationAirport/target/EntitiesState
mkdir -p DestinationAirport/target/Interfaces
mkdir -p DestinationAirport/target/MainPackage

mkdir -p Plane/target/EntitiesState
mkdir -p Plane/target/Interfaces
mkdir -p Plane/target/MainPackage

mkdir -p GeneralRepos/target/EntitiesState
mkdir -p GeneralRepos/target/Interfaces
mkdir -p GeneralRepos/target/MainPackage

mkdir -p Registry/target/EntitiesState
mkdir -p Registry/target/Interfaces
mkdir -p Registry/target/MainPackage

mkdir -p Hostess/target/EntitiesState
mkdir -p Hostess/target/Interfaces
mkdir -p Hostess/target/MainPackage

mkdir -p Pilot/target/EntitiesState
mkdir -p Pilot/target/Interfaces
mkdir -p Pilot/target/MainPackage

mkdir -p Passenger/target/EntitiesState
mkdir -p Passenger/target/Interfaces
mkdir -p Passenger/target/MainPackage

echo -e "\n${bold} Copy simulation parameters ${normal}"
cp SimulationParameters/remote_SimulationParameters.java Registry/MainPackage/SimulationParameters.java
cp SimulationParameters/remote_SimulationParameters.java GeneralRepos/MainPackage/SimulationParameters.java
cp SimulationParameters/remote_SimulationParameters.java DepartureAirport/MainPackage/SimulationParameters.java
cp SimulationParameters/remote_SimulationParameters.java DestinationAirport/MainPackage/SimulationParameters.java
cp SimulationParameters/remote_SimulationParameters.java Plane/MainPackage/SimulationParameters.java
cp SimulationParameters/remote_SimulationParameters.java Passenger/MainPackage/SimulationParameters.java
cp SimulationParameters/remote_SimulationParameters.java Hostess/MainPackage/SimulationParameters.java
cp SimulationParameters/remote_SimulationParameters.java Pilot/MainPackage/SimulationParameters.java

echo -e "\n${bold} Copy genclass jars ${normal}"
cp genclass.jar Registry/
cp genclass.jar GeneralRepos/
cp genclass.jar DepartureAirport/
cp genclass.jar DestinationAirport/
cp genclass.jar Plane/
cp genclass.jar Passenger/
cp genclass.jar Hostess/
cp genclass.jar Pilot/
cp genclass.jar Registry/target/
cp genclass.jar GeneralRepos/target/
cp genclass.jar DepartureAirport/target/
cp genclass.jar DestinationAirport/target/
cp genclass.jar Plane/target/
cp genclass.jar Passenger/target/
cp genclass.jar Hostess/target/
cp genclass.jar Pilot/target/

##############################################################################
echo -e "\n${bold}>>>>> Compiling in each node${normal}"

echo -e "\n${bold}->${normal} Compiling registry"
cd Registry
javac --release 8 -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv Registry/Interfaces/*.class Registry/target/Interfaces/
mv Registry/MainPackage/*.class Registry/target/MainPackage/
mv Registry/EntitiesState/*.class Registry/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling GeneralRepos"
cd GeneralRepos
javac --release 8 -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv GeneralRepos/Interfaces/*.class GeneralRepos/target/Interfaces/
mv GeneralRepos/MainPackage/*.class GeneralRepos/target/MainPackage/
mv GeneralRepos/EntitiesState/*.class GeneralRepos/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling departure airport"
cd DepartureAirport
javac --release 8 -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv DepartureAirport/Interfaces/*.class DepartureAirport/target/Interfaces/
mv DepartureAirport/MainPackage/*.class DepartureAirport/target/MainPackage/
mv DepartureAirport/EntitiesState/*.class DepartureAirport/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling plane"
cd Plane
javac --release 8 -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv Plane/Interfaces/*.class Plane/target/Interfaces/
mv Plane/MainPackage/*.class Plane/target/MainPackage/
mv Plane/EntitiesState/*.class Plane/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling destination airport"
cd DestinationAirport
javac --release 8 -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv DestinationAirport/Interfaces/*.class DestinationAirport/target/Interfaces/
mv DestinationAirport/MainPackage/*.class DestinationAirport/target/MainPackage/
mv DestinationAirport/EntitiesState/*.class DestinationAirport/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling hostess"
cd Hostess
javac --release 8 -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv Hostess/Interfaces/*.class Hostess/target/Interfaces/
mv Hostess/MainPackage/*.class Hostess/target/MainPackage/
mv Hostess/EntitiesState/*.class Hostess/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling pilot"
cd Pilot
javac --release 8 -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv Pilot/Interfaces/*.class Pilot/target/Interfaces/
mv Pilot/MainPackage/*.class Pilot/target/MainPackage/
mv Pilot/EntitiesState/*.class Pilot/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling passenger"
cd Passenger
javac --release 8 -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv Passenger/Interfaces/*.class Passenger/target/Interfaces/
mv Passenger/MainPackage/*.class Passenger/target/MainPackage/
mv Passenger/EntitiesState/*.class Passenger/target/EntitiesState/

##############################################################################
echo -e "\n${bold}>>>>> Sending classes to target nodes${normal}"
zip -r Registry.zip Registry/target
zip -r GeneralRepos.zip GeneralRepos/target
zip -r DepartureAirport.zip DepartureAirport/target
zip -r DestinationAirport.zip DestinationAirport/target
zip -r Plane.zip Plane/target
zip -r Passenger.zip Passenger/target
zip -r Hostess.zip Hostess/target
zip -r Pilot.zip Pilot/target

echo -e "\n${bold}-${normal} Copying registry and GeneralRepos to workstation ${bold}01${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt << !
    put -r Registry.zip
    put -r GeneralRepos.zip
    bye
!

echo -e "\n${bold}-${normal} Copying departure airport to workstation ${bold}02${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws02.ua.pt << !
	put -r DepartureAirport.zip
	bye
!

echo -e "\n${bold}-${normal} Copying plane to workstation ${bold}03${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws03.ua.pt << !
	put -r Plane.zip
	bye
!

echo -e "\n${bold}-${normal} Copying destination airport to workstation ${bold}04${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws04.ua.pt << !
	put -r DestinationAirport.zip
	bye
!

echo -e "\n${bold}-${normal} Copying hostess to workstation ${bold}05${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws05.ua.pt << !
	put -r Hostess.zip
	bye
!

echo -e "\n${bold}-${normal} Copying pilot to workstation ${bold}06${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws06.ua.pt << !
	put -r Pilot.zip
	bye
!

echo -e "\n${bold}-${normal} Copying passenger to workstation ${bold}07${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws07.ua.pt << !
	put -r Passenger.zip
	bye
!

rm Registry.zip
rm GeneralRepos.zip
rm DepartureAirport.zip
rm Plane.zip
rm DestinationAirport.zip
rm Hostess.zip
rm Pilot.zip
rm Passenger.zip

##############################################################################
echo -e "\n${bold}>>>>> Organizing classes in each workstation${normal}"

echo -e "\n${bold}-${normal} Organizing registry and GeneralRepos classes in workstation ${bold}01${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt << EOF
	unzip Registry.zip
	rm Registry.zip

    unzip GeneralRepos.zip
	rm GeneralRepos.zip

    cd Public
    rm -rf registry
    rm -rf generalRepos
    mkdir -p registry
    mkdir -p generalRepos
    
    cd registry
    mkdir -p classes
    cd ..
    
    cd generalRepos
    mkdir -p classes
    cd ..

    cd ..
    mv Registry/target/* Public/registry/classes/
    mv GeneralRepos/target/* Public/generalRepos/classes/
    rm -rf Registry
    rm -rf GeneralRepos
EOF

echo -e "\n${bold}-${normal} Organizing departure airport classes in workstation ${bold}02${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws02.ua.pt << EOF
	unzip DepartureAirport.zip
	rm DepartureAirport.zip

    cd Public
    rm -rf classes
    mkdir -p classes

    cd ..
    mv DepartureAirport/target/* Public/classes/
    rm -rf DepartureAirport
EOF

echo -e "\n${bold}-${normal} Organizing destination airport classes in workstation ${bold}03${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws03.ua.pt << EOF
	unzip DestinationAirport.zip
	rm DestinationAirport.zip

    cd Public
    rm -rf classes
    mkdir -p classes

    cd ..
    mv DestinationAirport/target/* Public/classes/
    rm -rf DestinationAirport
EOF

echo -e "\n${bold}-${normal} Organizing plane classes in workstation ${bold}04${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws04.ua.pt << EOF
	unzip Plane.zip
	rm Plane.zip

    cd Public
    rm -rf classes
    mkdir -p classes

    cd ..
    mv Plane/target/* Public/classes/
    rm -rf Plane
EOF

echo -e "\n${bold}-${normal} Organizing passenger classes in workstation ${bold}05${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws05.ua.pt << EOF
	unzip Passenger.zip
	rm Passenger.zip

    cd Public
    rm -rf classes
    mkdir -p classes

    cd ..
    mv Passenger/target/* Public/classes/
    rm -rf Passenger
EOF

echo -e "\n${bold}-${normal} Organizing pilot classes in workstation ${bold}06${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws06.ua.pt << EOF
	unzip Pilot.zip
	rm Pilot.zip

    cd Public
    rm -rf classes
    mkdir -p classes

    cd ..
    mv Pilot/target/* Public/classes/
    rm -rf Pilot
EOF

echo -e "\n${bold}-${normal} Organizing hostess classes in workstation ${bold}07${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws07.ua.pt << EOF
	unzip Hostess.zip
	rm Hostess.zip


    cd Public
    rm -rf classes
    mkdir -p classes

    cd ..
    mv Hostess/target/* Public/classes/
    rm -rf Hostess
EOF

##############################################################################
echo -e "\n${bold}>>>>> Executing in each workstation${normal}"

echo -e "\n${bold}->${normal} Executing registry and GeneralRepos in workstation ${bold}01${normal}"

sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt << EOF
	cd Public/registry/classes
    nohup rmiregistry -J-Djava.rmi.server.useCodebaseOnly=true 22455 > /dev/null 2>&1 & 
EOF
sleep 5

xterm -e sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt '
    cd Public/registry/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws01.ua.pt/sd406/registry/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        MainPackage.ServerRegisterRemoteObject' & registrypid=$! 
sleep 5

xterm -e sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt '
    cd Public/generalRepos/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws01.ua.pt/sd406/registry/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        MainPackage.MainProgram' &     
sleep 5

echo -e "\n${bold}->${normal} Executing departure airport in workstation ${bold}02${normal}"
xterm -e sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws02.ua.pt '
    cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws01.ua.pt/sd406/registry/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        MainPackage.MainProgram' &
sleep 5

echo -e "\n${bold}->${normal} Executing destination airport in workstation ${bold}03${normal}"
xterm -e sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws03.ua.pt '
	cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws01.ua.pt/sd406/registry/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        MainPackage.MainProgram' & 
sleep 5

echo -e "\n${bold}-${normal} Executing plane in workstation ${bold}04${normal}"
xterm -e sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws04.ua.pt '
	cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws01.ua.pt/sd406/registry/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        MainPackage.MainProgram' &
sleep 1

echo -e "\n${bold}-${normal} Executing passenger in workstation ${bold}05${normal}"
xterm -e sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws05.ua.pt '
	cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws01.ua.pt/sd406/registry/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        MainPackage.MainProgram' &
sleep 1

echo -e "\n${bold}-${normal} Executing pilot in workstation ${bold}06${normal}"
xterm -e sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws06.ua.pt '
	cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws01.ua.pt/sd406/registry/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        MainPackage.MainProgram' &
sleep 1

echo -e "\n${bold}-${normal} Executing hostess in workstation ${bold}07${normal}"
xterm -e sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws07.ua.pt '
	cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws01.ua.pt/sd406/registry/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        MainPackage.MainProgram' &

##############################################################################
wait $registrypid
echo -e "\n${bold}>>>>> Registry server finished, killing registry${normal}"

sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt << EOF
    pkill -f 'rmiregistry -J-Djava.rmi.server.useCodebaseOnly=true 22455'
EOF

##############################################################################
echo -e "\n${bold}>>>>> Retrieving logs${normal}"

sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt << !
	cd Public/GeneralRepos/classes
	get -r log.txt
	bye
!

##############################################################################
echo -e "\n${bold}>>>>> Cleaning files on remote machines${normal}"

sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt << EOF
    cd Public 
    rm -rf registry
    rm -rf GeneralRepos
EOF

sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws02.ua.pt << EOF
    cd Public 
    rm -rf classes
EOF

sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws03.ua.pt << EOF
    cd Public 
    rm -rf classes
EOF

sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws04.ua.pt << EOF
    cd Public 
    rm -rf classes
EOF

sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws05.ua.pt << EOF
    cd Public 
    rm -rf classes
EOF

sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws06.ua.pt << EOF
    cd Public 
    rm -rf classes
EOF

sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws07.ua.pt << EOF
    cd Public 
    rm -rf classes
EOF

echo -e "\n${bold}>>>>> Finished execution${normal}"
