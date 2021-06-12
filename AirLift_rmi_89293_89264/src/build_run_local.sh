bold=$(tput bold)
normal=$(tput sgr0)

echo "----------------------------------------------------------------"
echo "${bold}            AirLift Problem - Script Local${normal}"
echo "----------------------------------------------------------------"

echo -e "\n${bold}>>>>> Stop all active processes ${normal}"
sudo kill -9 $(ps -ef | grep java | grep -v "netbeans" | awk '{ print $2 }')

##############################################################################
echo -e "\n${bold}>>>>> Make directories with .class files ${normal}"
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

echo -e "\n${bold}>>>>> Copy simulation parameters ${normal}"
cp SimulationParameters/SimulationParameters.java Registry/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters.java GeneralRepos/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters.java DepartureAirport/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters.java DestinationAirport/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters.java Plane/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters.java Hostess/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters.java Pilot/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters.java Passenger/MainPackage/SimulationParameters.java

cp commInfra/MemException.java DepartureAirport/MainPackage/MemException.java
cp commInfra/MemFIFO.java DepartureAirport/MainPackage/MemFIFO.java
cp commInfra/MemObject.java DepartureAirport/MainPackage/MemObject.java
cp commInfra/MemException.java DestinationAirport/MainPackage/MemException.java
cp commInfra/MemFIFO.java DestinationAirport/MainPackage/MemFIFO.java
cp commInfra/MemObject.java DestinationAirport/MainPackage/MemObject.java
cp commInfra/MemException.java Plane/MainPackage/MemException.java
cp commInfra/MemFIFO.java Plane/MainPackage/MemFIFO.java
cp commInfra/MemObject.java Plane/MainPackage/MemObject.java

echo -e "\n${bold}>>>>> Copy genclass jars ${normal}"
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
javac -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv Registry/Interfaces/*.class Registry/target/Interfaces/
mv Registry/MainPackage/*.class Registry/target/MainPackage/
mv Registry/EntitiesState/*.class Registry/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling GeneralRepos"
cd GeneralRepos
javac -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv GeneralRepos/Interfaces/*.class GeneralRepos/target/Interfaces/
mv GeneralRepos/MainPackage/*.class GeneralRepos/target/MainPackage/
mv GeneralRepos/EntitiesState/*.class GeneralRepos/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling departure airport"
cd DepartureAirport
javac -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv DepartureAirport/Interfaces/*.class DepartureAirport/target/Interfaces/
mv DepartureAirport/MainPackage/*.class DepartureAirport/target/MainPackage/
mv DepartureAirport/EntitiesState/*.class DepartureAirport/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling destination airport"
cd DestinationAirport
javac -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv DestinationAirport/Interfaces/*.class DestinationAirport/target/Interfaces/
mv DestinationAirport/MainPackage/*.class DestinationAirport/target/MainPackage/
mv DestinationAirport/EntitiesState/*.class DestinationAirport/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling plane"
cd Plane
javac -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv Plane/Interfaces/*.class Plane/target/Interfaces/
mv Plane/MainPackage/*.class Plane/target/MainPackage/
mv Plane/EntitiesState/*.class Plane/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling passenger"
cd Passenger
javac -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv Passenger/Interfaces/*.class Passenger/target/Interfaces/
mv Passenger/MainPackage/*.class Passenger/target/MainPackage/
mv Passenger/EntitiesState/*.class Passenger/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling hostess"
cd Hostess
javac -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv Hostess/Interfaces/*.class Hostess/target/Interfaces/
mv Hostess/MainPackage/*.class Hostess/target/MainPackage/
mv Hostess/EntitiesState/*.class Hostess/target/EntitiesState/

echo -e "\n${bold}->${normal} Compiling pilot"
cd Pilot
javac -cp ".:../genclass.jar" $(find . -name '*.java')
cd ..
mv Pilot/Interfaces/*.class Pilot/target/Interfaces/
mv Pilot/MainPackage/*.class Pilot/target/MainPackage/
mv Pilot/EntitiesState/*.class Pilot/target/EntitiesState/

##############################################################################
echo -e "\n${bold}>>>>> Executing each node${normal}"

echo -e "\n${bold}->${normal} Starting registry ${normal}"
cd Registry
rmiregistry -J-Djava.rmi.server.useCodebaseOnly=false 8086 &
regId=$!
cd ..

echo -e "\n${bold}->${normal} Executing Registry"
cd Registry/target/

java -cp ".:../genclass.jar" -Djava.rmi.server.codebase="file:///Users/ruisantos/Desktop/ano4/sd/proj3/airlift_rmi/AirLift_rmi_89293_89264/src/Registry/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     MainPackage.ServerRegisterRemoteObject &
serverId=$!
cd ../../
sleep 1

echo -e "\n${bold}->${normal} Executing GeneralRepos"
cd GeneralRepos/target/
java -cp ".:../genclass.jar" -Djava.rmi.server.codebase="file:///Users/ruisantos/Desktop/ano4/sd/proj3/airlift_rmi/AirLift_rmi_89293_89264/src/Registry/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     MainPackage.MainProgram &
cd ../../
sleep 1

echo -e "\n${bold}->${normal} Executing Departure Airport"
cd DepartureAirport/target/
java -cp ".:../genclass.jar" -Djava.rmi.server.codebase="file:///Users/ruisantos/Desktop/ano4/sd/proj3/airlift_rmi/AirLift_rmi_89293_89264/src/Registry/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     MainPackage.MainProgram &
cd ../../
sleep 1

echo -e "\n${bold}->${normal} Executing Plane"
cd Plane/target/
java -cp ".:../genclass.jar" -Djava.rmi.server.codebase="file:///Users/ruisantos/Desktop/ano4/sd/proj3/airlift_rmi/AirLift_rmi_89293_89264/src/Registry/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     MainPackage.MainProgram &
cd ../../
sleep 1

echo -e "\n${bold}->${normal} Executing Destination Airport"
cd DestinationAirport/target/
java -cp ".:../genclass.jar" -Djava.rmi.server.codebase="file:///Users/ruisantos/Desktop/ano4/sd/proj3/airlift_rmi/AirLift_rmi_89293_89264/src/Registry/target/"\
	-Djava.rmi.server.useCodebaseOnly=false\
	-Djava.security.policy=java.policy\
	MainPackage.MainProgram &
cd ../../
sleep 1

# Wait for the shared regions to be launched before lanching the intervening enities
sleep 1

echo -e "\n${bold}->${normal} Executing Hostess"
cd Hostess/target/
java -cp ".:../genclass.jar" -Djava.rmi.server.codebase="file:///Users/ruisantos/Desktop/ano4/sd/proj3/airlift_rmi/AirLift_rmi_89293_89264/src/Registry/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     MainPackage.MainProgram &
cd ../../
sleep 1

echo -e "\n${bold}->${normal} Executing Pilot"
cd Pilot/target/
java -cp ".:../genclass.jar" -Djava.rmi.server.codebase="file:///Users/ruisantos/Desktop/ano4/sd/proj3/airlift_rmi/AirLift_rmi_89293_89264/src/Registry/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     MainPackage.MainProgram &
cd ../../
sleep 1

echo -e "\n${bold}->${normal} Executing Passenger"
cd Passenger/target/
java -cp ".:../genclass.jar" -Djava.rmi.server.codebase="file:///Users/ruisantos/Desktop/ano4/sd/proj3/airlift_rmi/AirLift_rmi_89293_89264/src/Registry/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     MainPackage.MainProgram &
cd ../../
sleep 1

wait $serverId

kill -9 $regId

echo -e "\n${normal}----------------------------------------------------------\n${normal}"
wait
echo -e "\n${normal}----------------------------------------------------------"

echo -e "\n${bold}>>>>>${normal} Finished execution"
