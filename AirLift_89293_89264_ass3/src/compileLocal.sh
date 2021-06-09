bold=$(tput bold)
normal=$(tput sgr0)

echo "----------------------------------------------------------------"
echo "${bold}             AirLift Problem - Compile Script Local      ${normal}"
echo "----------------------------------------------------------------"

### COMPILAR

echo -e "\n${bold}>>>>> Compilação do código em cada nó ${normal}"

echo -e "\n${bold}>${normal} A compilar EntitiesState"
cd EntitiesState/
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java $(find . -name '*.java')
cd ..

echo -e "\n${bold}>${normal} A compilar SimulationParameters"
cd SimulationParameters/
javac --release 8 -classpath ../genclass.jar ../commInfra/*.java $(find . -name '*.java')
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