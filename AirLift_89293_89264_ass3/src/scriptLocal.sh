bold=$(tput bold)
normal=$(tput sgr0)

echo "----------------------------------------------------------"
echo "${bold}             AirLift Problem - Script Local               ${normal}"
echo "----------------------------------------------------------"

echo -e "\n${bold}>>>>> A parar todos os processos ativos ${normal}"
sudo kill -9 $(ps -ef | grep java | grep -v "netbeans" | awk '{ print $2 }')

### COMPILAR

echo -e "\n${bold}>>>>> Compilação do código em cada nó ${normal}"

echo -e "\n${bold}>${normal} A compilar EntitiesState"
cd EntitiesState/
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java $(find . -name '*.java')
cd ..

echo -e "\n${bold}>${normal} A compilar SimulationParameters"
cd SimulationParameters/
javac --release 8 -classpath ../genclass.jar:.. ../commInfra/*.java $(find . -name '*.java')
cd ..

echo -e "\n${bold}>${normal} A compilar Interfaces"
cd Interfaces/
javac --release 8 -classpath ../genclass.jar ../EntitiesState/*.java ../commInfra/*.java $(find . -name '*.java')
cd ..

echo -e "\n${bold}>${normal} A compilar Registry"
cd Registry/
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../SimulationParameters/*.java ../Interfaces/*.java $(find . -name '*.java')
cd ..

echo -e "\n${bold}>${normal} A compilar GeneralRepos"
cd GeneralRepos/
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../SimulationParameters/*.java ../Interfaces/*.java $(find . -name '*.java')
cd ..

echo -e "\n${bold}>${normal} A compilar DepartureAirport"
cd DepartureAirport/
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../SimulationParameters/*.java ../Interfaces/*.java $(find . -name '*.java')
cd ..

echo -e "\n${bold}>${normal} A compilar Plane"
cd Plane/
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../SimulationParameters/*.java ../Interfaces/*.java $(find . -name '*.java')
cd ..

echo -e "\n${bold}>${normal} A compilar DestinationAirport"
cd DestinationAirport/
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../SimulationParameters/*.java ../Interfaces/*.java $(find . -name '*.java')
cd ..

echo -e "\n${bold}>${normal} A compilar Hostess"
cd Hostess/
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../SimulationParameters/*.java ../Interfaces/*.java $(find . -name '*.java')
cd ..

echo -e "\n${bold}>${normal} A compilar Pilot"
cd Pilot/
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../SimulationParameters/*.java ../Interfaces/*.java $(find . -name '*.java')
cd ..

echo -e "\n${bold}>${normal} A compilar Passenger"
cd Passenger/
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java ../EntitiesState/*.java ../SimulationParameters/*.java ../Interfaces/*.java $(find . -name '*.java')
cd ..

### EXECUTAR 

echo -e "\n${bold}>>>>> Execução do código em cada nó ${normal}"

echo -e "\n${bold}* A iniciar Registry *${normal}"
cd Registry
rmiregistry -J-Djava.rmi.server.useCodebaseOnly=false 8086 &
regId=$!
cd ..

echo -e "\n${bold}->${normal} A executar Registry"
java -cp ".:./genclass.jar"\
     -Djava.rmi.server.codebase="/Users/ruisantos/Desktop/ano4/sd/proj3/airlift_rmi/AirLift_89293_89264_ass3/src/Registry/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     Registry/ServerRegisterRemoteObject &
serverId=$!
sleep 1






# echo -e "\n${bold}>${normal} A executar GeneralRepos"
# java -cp ".:./genclass.jar" GeneralRepos/Main/MainProgram &

# echo -e "\n${bold}>${normal} A executar DepartureAirport"
# java -cp ".:./genclass.jar" DepartureAirport/Main/MainProgram &

# echo -e "\n${bold}>${normal} A executar Plane"
# java -cp ".:./genclass.jar" Plane/Main/MainProgram &

# echo -e "\n${bold}>${normal} A executar DestinationAirport"
# java -cp ".:./genclass.jar" DestinationAirport/Main/MainProgram &

# # Wait for the shared regions to be launched before lanching the intervening enities
# sleep 1

# echo -e "\n${bold}>${normal} A executar Hostess"
# java -cp ".:./genclass.jar" Hostess/Main/MainProgram &

# echo -e "\n${bold}>${normal} A executar Pilot"
# java -cp ".:./genclass.jar" Pilot/Main/MainProgram &

# echo -e "\n${bold}>${normal} A executar Passenger"
# java -cp ".:./genclass.jar" Passenger/Main/MainProgram &

echo -e "\n${normal}----------------------------------------------------------\n${normal}"
wait
echo -e "\n${normal}----------------------------------------------------------"

echo -e "\n${bold}>>>>>>>>>>${normal} A execução terminou"


