bold=$(tput bold)
normal=$(tput sgr0)
echo "${bold}ºººººº Remote deploy script ºººººº${normal}"

export SSHPASS='sistemas2021'


echo -e "\n${bold}ºº Creating target directories ºº${normal}"

mkdir -p DepartureAirport/target
mkdir -p Plane/target
mkdir -p DestinationAirport/target
mkdir -p GeneralRepos/target
mkdir -p Registry/target
mkdir -p Hostess/target
mkdir -p Pilot/target
mkdir -p Passenger/target
mkdir -p EntitiesState/target
mkdir -p Interfaces/target
mkdir -p SimulationParameters/target
mkdir -p commInfra/target

echo -e "\n${bold}ºº Copy genclass jars ºº${normal}"
cp genclass.jar Registry/
cp genclass.jar GeneralRepos/
cp genclass.jar DepartureAirport/
cp genclass.jar Plane/
cp genclass.jar DestinationAirport/
cp genclass.jar Hostess/
cp genclass.jar Pilot/
cp genclass.jar Passenger/
cp genclass.jar EntitiesState/
cp genclass.jar Interfaces/
cp genclass.jar SimulationParameters/
cp genclass.jar commInfra/
cp genclass.jar Registry/target/
cp genclass.jar GeneralRepos/target/
cp genclass.jar DepartureAirport/target/
cp genclass.jar Plane/target/
cp genclass.jar DestinationAirport/target/
cp genclass.jar Hostess/target/
cp genclass.jar Pilot/target/
cp genclass.jar Passenger/target/
cp genclass.jar EntitiesState/target
cp genclass.jar Interfaces/target
cp genclass.jar SimulationParameters/target
cp genclass.jar commInfra/target

echo -e "\n${bold}ºº Compiling code for each node ºº${normal}"

echo -e "\n${bold}->${normal} Compiling EntitiesState"
cd EntitiesState
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java $(find . -name '*.java')
cd ..
mv EntitiesState/*.class EntitiesState/target

echo -e "\n${bold}->${normal} Compiling SimulationParameters"
cd SimulationParameters
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java $(find . -name '*.java')
cd ..
mv SimulationParameters/*.class SimulationParameters/target

echo -e "\n${bold}->${normal} Compiling Interfaces"
cd Interfaces
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java $(find . -name '*.java')
cd ..
mv Interfaces/*.class Interfaces/target

echo -e "\n${bold}-${normal} Compiling registry"
cd Registry
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../Interfaces/*.java ../SimulationParameters/*.java $(find . -name '*.java')
cd ..
mv Registry/*.class Registry/target/

echo -e "\n${bold}-${normal} Compiling GeneralRepos"
cd GeneralRepos
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../Interfaces/*.java ../SimulationParameters/*.java $(find . -name '*.java')
cd ..
mv GeneralRepos/*.class GeneralRepos/target

echo -e "\n${bold}-${normal} Compiling departure airport"
cd DepartureAirport
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../Interfaces/*.java ../SimulationParameters/*.java $(find . -name '*.java')
cd ..
mv DepartureAirport/*.class DepartureAirport/target

echo -e "\n${bold}-${normal} Compiling plane"
cd Plane
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../Interfaces/*.java ../SimulationParameters/*.java $(find . -name '*.java')
cd ..
mv Plane/*.class Plane/target

echo -e "\n${bold}-${normal} Compiling destination airport"
cd DestinationAirport
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../Interfaces/*.java ../SimulationParameters/*.java $(find . -name '*.java')
cd ..
mv DestinationAirport/*.class DestinationAirport/target

echo -e "\n${bold}-${normal} Compiling hostess"
cd Hostess
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../Interfaces/*.java ../SimulationParameters/*.java $(find . -name '*.java')
cd ..
mv Hostess/*.class Hostess/target

echo -e "\n${bold}-${normal} Compiling pilot"
cd Pilot
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../Interfaces/*.java ../SimulationParameters/*.java $(find . -name '*.java')
cd ..
mv Pilot/*.class Pilot/target

echo -e "\n${bold}->${normal} Compiling passenger"
cd Passenger
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../Interfaces/*.java ../SimulationParameters/*.java $(find . -name '*.java')
cd ..
mv Passenger/*.class Passenger/target

echo -e "\n${bold}->${normal} Compiling commInfra"
cd commInfra
javac --release 8 -classpath ../genclass.jar $(find . -name '*.java')
cd ..
mv commInfra/*.class commInfra/target

echo -e "\n${bold}ºº Sending classes to target nodes ºº${normal}"
zip -r Registry.zip Registry/target
zip -r GeneralRepos.zip GeneralRepos/target
zip -r DepartureAirport.zip DepartureAirport/target
zip -r Plane.zip Plane/target
zip -r DestinationAirport.zip DestinationAirport/target
zip -r Hostess.zip Hostess/target
zip -r Pilot.zip Pilot/target
zip -r Passenger.zip Passenger/target
zip -r SimulationParameters.zip SimulationParameters/target
zip -r Interfaces.zip Interfaces/target
zip -r EntitiesState.zip EntitiesState/target
zip -r commInfra.zip commInfra/target

echo -e "\n${bold}-${normal} Copying registry to workstation ${bold}8${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws08.ua.pt << !
    put -r Registry.zip
	put -r Interfaces.zip
	put -r SimulationParameters.zip
	put -r EntitiesState.zip
	put -r commInfra.zip
    bye
!

echo -e "\n${bold}-${normal} Copying GeneralRepos to workstation ${bold}1${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt << !
    put -r GeneralRepos.zip
	put -r Interfaces.zip
	put -r SimulationParameters.zip
	put -r EntitiesState.zip
	put -r commInfra.zip
    bye
!

echo -e "\n${bold}-${normal} Copying departure airport to workstation ${bold}02${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws02.ua.pt << !
	put -r DepartureAirport.zip
	put -r Interfaces.zip
	put -r SimulationParameters.zip
	put -r EntitiesState.zip
	put -r commInfra.zip
	bye
!

echo -e "\n${bold}-${normal} Copying plane to workstation ${bold}03${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws03.ua.pt << !
	put -r Plane.zip
	put -r Interfaces.zip
	put -r SimulationParameters.zip
	put -r EntitiesState.zip
	put -r commInfra.zip
	bye
!

echo -e "\n${bold}-${normal} Copying destination airport to workstation ${bold}04${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws04.ua.pt << !
	put -r DestinationAirport.zip
	put -r Interfaces.zip
	put -r SimulationParameters.zip
	put -r EntitiesState.zip
	put -r commInfra.zip
	bye
!

echo -e "\n${bold}-${normal} Copying hostess to workstation ${bold}05${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws05.ua.pt << !
	put -r Hostess.zip
	put -r Interfaces.zip
	put -r SimulationParameters.zip
	put -r EntitiesState.zip
	put -r commInfra.zip
	bye
!

echo -e "\n${bold}-${normal} Copying pilot to workstation ${bold}06${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws06.ua.pt << !
	put -r Pilot.zip
	put -r Interfaces.zip
	put -r SimulationParameters.zip
	put -r EntitiesState.zip
	put -r commInfra.zip
	bye
!

echo -e "\n${bold}-${normal} Copying passenger to workstation ${bold}07${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws07.ua.pt << !
	put -r Passenger.zip
	put -r Interfaces.zip
	put -r SimulationParameters.zip
	put -r EntitiesState.zip
	put -r commInfra.zip
	bye
!

rm Registry.zip
rm GeneralRepos.zip
rm DepartureAirport.zip
rm DestinationAirport.zip
rm Plane.zip
rm Passenger.zip
rm Hostess.zip
rm Pilot.zip
rm Interfaces.zip
rm SimulationParameters.zip
rm EntitiesState.zip
rm commInfra.zip

echo -e "\n${bold}ºº Organizing classes in each workstation ºº${normal}"

echo -e "\n${bold}-${normal} Organizing registry classes in workstation ${bold}08${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws08.ua.pt << EOF
    cd Public 
    rm -rf classes
    cd ..

    rm -rf Registry
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra

	unzip Registry.zip
	unzip Interfaces.zip
	unzip SimulationParameters.zip
	unzip EntitiesState.zip
	unzip commInfra.zip
		
	rm Registry.zip
	rm Interfaces.zip
	rm SimulationParameters.zip
	rm EntitiesState.zip
	rm commInfra.zip

    cd Public
    rm -rf classes
    mkdir -p classes
	
	cd classes
	mkdir -p Registry
    mkdir -p Interfaces
	mkdir -p SimulationParameters
	mkdir -p EntitiesState
	mkdir -p commInfra
	
	cd ../..
    mv Registry/target/java.policy Public/classes/
	mv Registry/target/* Public/classes/Registry
	mv Interfaces/target/* Public/classes/Interfaces
	mv SimulationParameters/target/* Public/classes/SimulationParameters
	mv EntitiesState/target/* Public/classes/EntitiesState
	mv commInfra/target/* Public/classes/commInfra	
	
	rm -rf Registry
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
EOF

echo -e "\n${bold}-${normal} Organizing GeneralRepos classes in workstation ${bold}01${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt << EOF
    cd Public 
    rm -rf classes
    cd ..
	
	rm -rf GeneralRepos
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
    
	unzip GeneralRepos.zip
	unzip Interfaces.zip
	unzip SimulationParameters.zip
	unzip EntitiesState.zip
	unzip commInfra.zip
	
	rm GeneralRepos.zip
	rm Interfaces.zip
	rm SimulationParameters.zip
	rm EntitiesState.zip
	rm commInfra.zip
	
    cd Public
    rm -rf classes
    mkdir -p classes
	
	cd classes
	mkdir -p GeneralRepos
    mkdir -p Interfaces
	mkdir -p SimulationParameters
	mkdir -p EntitiesState
	mkdir -p commInfra
	
	cd ../..

	mv GeneralRepos/target/* Public/classes/GeneralRepos
	mv Interfaces/target/* Public/classes/Interfaces
	mv SimulationParameters/target/* Public/classes/SimulationParameters
	mv EntitiesState/target/* Public/classes/EntitiesState
	mv commInfra/target/* Public/classes/commInfra	
	
	rm -rf GeneralRepos
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
EOF

echo -e "\n${bold}-${normal} Organizing departure airport classes in workstation ${bold}02${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws02.ua.pt << EOF
    cd Public 
    rm -rf classes
    cd ..
	
	rm -rf DepartureAirport
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
    
	unzip DepartureAirport.zip
	unzip Interfaces.zip
	unzip SimulationParameters.zip
	unzip EntitiesState.zip
	unzip commInfra.zip
	
	rm DepartureAirport.zip
	rm Interfaces.zip
	rm SimulationParameters.zip
	rm EntitiesState.zip
	rm commInfra.zip
	
    cd Public
    rm -rf classes
    mkdir -p classes
	
	cd classes
	mkdir -p DepartureAirport
    mkdir -p Interfaces
	mkdir -p SimulationParameters
	mkdir -p EntitiesState
	mkdir -p commInfra
	
	cd ../..

	mv DepartureAirport/target/* Public/classes/DepartureAirport
	mv Interfaces/target/* Public/classes/Interfaces
	mv SimulationParameters/target/* Public/classes/SimulationParameters
	mv EntitiesState/target/* Public/classes/EntitiesState
	mv commInfra/target/* Public/classes/commInfra	
	
	rm -rf DepartureAirport
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
EOF

echo -e "\n${bold}-${normal} Organizing plane classes in workstation ${bold}03${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws03.ua.pt << EOF
    cd Public 
    rm -rf classes
    cd ..
	
	rm -rf Plane
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
    
	unzip Plane.zip
	unzip Interfaces.zip
	unzip SimulationParameters.zip
	unzip EntitiesState.zip
	unzip commInfra.zip
	
	rm Plane.zip
	rm Interfaces.zip
	rm SimulationParameters.zip
	rm EntitiesState.zip
	rm commInfra.zip

    cd Public
    rm -rf classes
    mkdir -p classes

	cd classes
	mkdir -p Plane
    mkdir -p Interfaces
	mkdir -p SimulationParameters
	mkdir -p EntitiesState
	mkdir -p commInfra
	
	cd ../..

	mv Plane/target/* Public/classes/Plane
	mv Interfaces/target/* Public/classes/Interfaces
	mv SimulationParameters/target/* Public/classes/SimulationParameters
	mv EntitiesState/target/* Public/classes/EntitiesState
	mv commInfra/target/* Public/classes/commInfra	
	
	rm -rf Plane
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
EOF

echo -e "\n${bold}-${normal} Organizing destination airport classes in workstation ${bold}04${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws04.ua.pt << EOF
    cd Public 
    rm -rf classes
    cd ..
	
	rm -rf DestinationAirport
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
    
	unzip DestinationAirport.zip
	unzip Interfaces.zip
	unzip SimulationParameters.zip
	unzip EntitiesState.zip
	unzip commInfra.zip
	
	rm DestinationAirport.zip
	rm Interfaces.zip
	rm SimulationParameters.zip
	rm EntitiesState.zip
	rm commInfra.zip
	
    cd Public
    rm -rf classes
    mkdir -p classes

	cd classes
	mkdir -p DestinationAirport
    mkdir -p Interfaces
	mkdir -p SimulationParameters
	mkdir -p EntitiesState
	mkdir -p commInfra
	
	cd ../..

	mv DestinationAirport/target/* Public/classes/DestinationAirport
	mv Interfaces/target/* Public/classes/Interfaces
	mv SimulationParameters/target/* Public/classes/SimulationParameters
	mv EntitiesState/target/* Public/classes/EntitiesState
	mv commInfra/target/* Public/classes/commInfra	
	
	rm -rf DestinationAirport
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
EOF

echo -e "\n${bold}-${normal} Organizing hostess classes in workstation ${bold}05${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws05.ua.pt << EOF
    cd Public 
    rm -rf classes
    cd ..

	rm -rf Hostess
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
    
	unzip Hostess.zip
	unzip Interfaces.zip
	unzip SimulationParameters.zip
	unzip EntitiesState.zip
	unzip commInfra.zip

	rm Hostess.zip
	rm Interfaces.zip
	rm SimulationParameters.zip
	rm EntitiesState.zip
	rm commInfra.zip

    cd Public
    rm -rf classes
    mkdir -p classes

	cd classes
	mkdir -p Hostess
    mkdir -p Interfaces
	mkdir -p SimulationParameters
	mkdir -p EntitiesState
	mkdir -p commInfra
	
	cd ../..

	mv Hostess/target/* Public/classes/Hostess
	mv Interfaces/target/* Public/classes/Interfaces
	mv SimulationParameters/target/* Public/classes/SimulationParameters
	mv EntitiesState/target/* Public/classes/EntitiesState
	mv commInfra/target/* Public/classes/commInfra	
	
	rm -rf Hostess
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
EOF

echo -e "\n${bold}-${normal} Organizing pilot classes in workstation ${bold}06${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws06.ua.pt << EOF
    cd Public 
    rm -rf classes
    cd ..

    rm -rf Pilot
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
    
	unzip Pilot.zip
	unzip Interfaces.zip
	unzip SimulationParameters.zip
	unzip EntitiesState.zip
	unzip commInfra.zip
	
	rm Pilot.zip
	rm Interfaces.zip
	rm SimulationParameters.zip
	rm EntitiesState.zip
	rm commInfra.zip
	
    cd Public
    rm -rf classes
    mkdir -p classes
	
	cd classes
	mkdir -p Pilot
    mkdir -p Interfaces
	mkdir -p SimulationParameters
	mkdir -p EntitiesState
	mkdir -p commInfra
	
	cd ../..

	mv Pilot/target/* Public/classes/Pilot
	mv Interfaces/target/* Public/classes/Interfaces
	mv SimulationParameters/target/* Public/classes/SimulationParameters
	mv EntitiesState/target/* Public/classes/EntitiesState
	mv commInfra/target/* Public/classes/commInfra	
	
	rm -rf Pilot
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
EOF

echo -e "\n${bold}-${normal} Organizing passenger classes in workstation ${bold}07${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws07.ua.pt << EOF
    cd Public 
    rm -rf classes
    cd ..

	rm -rf Passenger
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
    
	unzip Passenger.zip
	unzip Interfaces.zip
	unzip SimulationParameters.zip
	unzip EntitiesState.zip
	unzip commInfra.zip

	rm Passenger.zip
	rm Interfaces.zip
	rm SimulationParameters.zip
	rm EntitiesState.zip
	rm commInfra.zip
	
    cd Public
    rm -rf classes
    mkdir -p classes

	cd classes
	mkdir -p Passenger
    mkdir -p Interfaces
	mkdir -p SimulationParameters
	mkdir -p EntitiesState
	mkdir -p commInfra
	
	cd ../..

	mv Passenger/target/* Public/classes/Passenger
	mv Interfaces/target/* Public/classes/Interfaces
	mv SimulationParameters/target/* Public/classes/SimulationParameters
	mv EntitiesState/target/* Public/classes/EntitiesState
	mv commInfra/target/* Public/classes/commInfra	
	
	rm -rf Passenger
    rm -rf Interfaces
	rm -rf SimulationParameters
    rm -rf EntitiesState
	rm -rf commInfra
EOF

echo -e "\n${bold}ºº Executing in each workstation ºº${normal}"

echo -e "\n${bold}-${normal} Executing registry in workstation ${bold}08${normal}"

sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws08.ua.pt << EOF
	cd Public/classes/Registry
    nohup rmiregistry -J-Djava.rmi.server.useCodebaseOnly=true 22455 &
    cd ..

    sleep 5

    ls

    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        Registry.ServerRegisterRemoteObject &
    
    registrypid=$! 

EOF

sleep 5

echo -e "\n${bold}-${normal} Executing GeneralRepos in workstation ${bold}01${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt << EOF
    cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        GeneralRepos.MainProgram > /dev/null 2>&1 &

EOF
        
sleep 5

echo -e "\n${bold}-${normal} Executing departure airport in workstation ${bold}02${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws02.ua.pt << EOF
    cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        DepartureAirport.MainProgram > /dev/null 2>&1 &

EOF

sleep 5

echo -e "\n${bold}-${normal} Executing  plane in workstation ${bold}03${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws03.ua.pt << EOF
	cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        Plane.MainProgram > /dev/null 2>&1 &

EOF
        
sleep 5

echo -e "\n${bold}-${normal} Executing destination airport in workstation ${bold}04${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws04.ua.pt << EOF
	cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        DestinationAirport.MainProgram > /dev/null 2>&1 &

EOF

sleep 1

echo -e "\n${bold}-${normal} Executing hostess in workstation ${bold}05${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws05.ua.pt << EOF
	cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        Hostess.MainProgram > /dev/null 2>&1 &

EOF
		
sleep 1

echo -e "\n${bold}-${normal} Executing pilot in workstation ${bold}06${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws06.ua.pt << EOF
	cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/classes/\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        Pilot.MainProgram > /dev/null 2>&1 &

EOF

sleep 1

echo -e "\n${bold}-${normal} Executing passenger in workstation ${bold}07${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws07.ua.pt << EOF
	cd Public/classes;
    java -cp ".:./genclass.jar" -Djava.rmi.server.codebase="http://l040101-ws08.ua.pt/sd406/classes/"\
        -Djava.rmi.server.useCodebaseOnly=true\
        -Djava.security.policy=java.policy\
        Passenger.MainProgram > /dev/null 2>&1 &

EOF


wait $registrypid
echo -e "\n${bold}ºº Registry server finished, killing registry ºº${normal}"
sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws08.ua.pt << EOF
    pkill -f 'rmiregistry -J-Djava.rmi.server.useCodebaseOnly=true 22455'
EOF

echo -e "\n${bold}ºº Retrieving logs ºº${normal}"
sshpass -e sftp -o StrictHostKeyChecking=no sd406@l040101-ws01.ua.pt << !
	cd Public/classes
	get -r rep.txt
	bye
!
echo -e "\n${bold}ºº Cleaning files on remote machines ºº${normal}"



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

sshpass -e ssh -T -o StrictHostKeyChecking=no sd406@l040101-ws08.ua.pt << EOF
    cd Public 
    rm -rf classes
EOF

echo -e "\n${bold}ºº Finished ºº${normal}"


