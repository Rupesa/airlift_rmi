bold=$(tput bold)
normal=$(tput sgr0)
echo "${bold}*** Script Local ***${normal}"

###

echo -e "\n${bold}* Copiar parâmetros de simulação *${normal}"
cp SimulationParameters/SimulationParameters_local.java SDA3_Registry/src/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters_local.java SDA3_Logger/src/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters_local.java SDA3_BettingCenter/src/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters_local.java SDA3_ControlCenter/src/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters_local.java SDA3_Paddock/src/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters_local.java SDA3_RacingTrack/src/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters_local.java SDA3_Stable/src/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters_local.java SDA3_Broker/src/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters_local.java SDA3_HorseJockey/src/MainPackage/SimulationParameters.java
cp SimulationParameters/SimulationParameters_local.java SDA3_Spectators/src/MainPackage/SimulationParameters.java


echo -e "\n${bold}* Compilação do código em cada nó *${normal}"


echo -e "\n${bold}->${normal} A compilar Registry"
javac SDA3_Registry/src/Interfaces/*.java SDA3_Registry/src/MainPackage/*.java SDA3_Registry/src/HelperClasses/*.java SDA3_Registry/src/EntitiesState/*.java
mv SDA3_Registry/src/Interfaces/*.class SDA3_Registry/src/target/Interfaces/
mv SDA3_Registry/src/MainPackage/*.class SDA3_Registry/src/target/MainPackage/
mv SDA3_Registry/src/HelperClasses/*.class SDA3_Registry/src/target/HelperClasses/
mv SDA3_Registry/src/EntitiesState/*.class SDA3_Registry/src/target/EntitiesState/


echo -e "\n${bold}->${normal} A compilar Logger"
javac SDA3_Logger/src/Interfaces/*.java SDA3_Logger/src/MainPackage/*.java SDA3_Logger/src/HelperClasses/*.java SDA3_Logger/src/EntitiesState/*.java
mv SDA3_Logger/src/Interfaces/*.class SDA3_Logger/src/target/Interfaces/
mv SDA3_Logger/src/MainPackage/*.class SDA3_Logger/src/target/MainPackage/
mv SDA3_Logger/src/HelperClasses/*.class SDA3_Logger/src/target/HelperClasses/
mv SDA3_Logger/src/EntitiesState/*.class SDA3_Logger/src/target/EntitiesState/



echo -e "\n${bold}->${normal} A compilar Betting Center"
javac SDA3_BettingCenter/src/Interfaces/*.java SDA3_BettingCenter/src/MainPackage/*.java SDA3_BettingCenter/src/HelperClasses/*.java SDA3_BettingCenter/src/EntitiesState/*.java
mv SDA3_BettingCenter/src/Interfaces/*.class SDA3_BettingCenter/src/target/Interfaces/
mv SDA3_BettingCenter/src/MainPackage/*.class SDA3_BettingCenter/src/target/MainPackage/
mv SDA3_BettingCenter/src/HelperClasses/*.class SDA3_BettingCenter/src/target/HelperClasses/
mv SDA3_BettingCenter/src/EntitiesState/*.class SDA3_BettingCenter/src/target/EntitiesState/


echo -e "\n${bold}->${normal} A compilar Control Center"
javac SDA3_ControlCenter/src/Interfaces/*.java SDA3_ControlCenter/src/MainPackage/*.java SDA3_ControlCenter/src/HelperClasses/*.java SDA3_ControlCenter/src/EntitiesState/*.java
mv SDA3_ControlCenter/src/Interfaces/*.class SDA3_ControlCenter/src/target/Interfaces/
mv SDA3_ControlCenter/src/MainPackage/*.class SDA3_ControlCenter/src/target/MainPackage/
mv SDA3_ControlCenter/src/HelperClasses/*.class SDA3_ControlCenter/src/target/HelperClasses/
mv SDA3_ControlCenter/src/EntitiesState/*.class SDA3_ControlCenter/src/target/EntitiesState/



echo -e "\n${bold}->${normal} A compilar Paddock"
javac SDA3_Paddock/src/Interfaces/*.java SDA3_Paddock/src/MainPackage/*.java SDA3_Paddock/src/HelperClasses/*.java SDA3_Paddock/src/EntitiesState/*.java
mv SDA3_Paddock/src/Interfaces/*.class SDA3_Paddock/src/target/Interfaces/
mv SDA3_Paddock/src/MainPackage/*.class SDA3_Paddock/src/target/MainPackage/
mv SDA3_Paddock/src/HelperClasses/*.class SDA3_Paddock/src/target/HelperClasses/
mv SDA3_Paddock/src/EntitiesState/*.class SDA3_Paddock/src/target/EntitiesState/



echo -e "\n${bold}->${normal} A compilar Racing Track"
javac SDA3_RacingTrack/src/Interfaces/*.java SDA3_RacingTrack/src/MainPackage/*.java SDA3_RacingTrack/src/HelperClasses/*.java SDA3_RacingTrack/src/EntitiesState/*.java
mv SDA3_RacingTrack/src/Interfaces/*.class SDA3_RacingTrack/src/target/Interfaces/
mv SDA3_RacingTrack/src/MainPackage/*.class SDA3_RacingTrack/src/target/MainPackage/
mv SDA3_RacingTrack/src/HelperClasses/*.class SDA3_RacingTrack/src/target/HelperClasses/
mv SDA3_RacingTrack/src/EntitiesState/*.class SDA3_RacingTrack/src/target/EntitiesState/



echo -e "\n${bold}->${normal} A compilar Stable"
javac SDA3_Stable/src/Interfaces/*.java SDA3_Stable/src/MainPackage/*.java SDA3_Stable/src/HelperClasses/*.java SDA3_Stable/src/EntitiesState/*.java
mv SDA3_Stable/src/Interfaces/*.class SDA3_Stable/src/target/Interfaces/
mv SDA3_Stable/src/MainPackage/*.class SDA3_Stable/src/target/MainPackage/
mv SDA3_Stable/src/HelperClasses/*.class SDA3_Stable/src/target/HelperClasses/
mv SDA3_Stable/src/EntitiesState/*.class SDA3_Stable/src/target/EntitiesState/



echo -e "\n${bold}->${normal} A compilar Broker"
javac SDA3_Broker/src/Interfaces/*.java SDA3_Broker/src/MainPackage/*.java SDA3_Broker/src/HelperClasses/*.java SDA3_Broker/src/EntitiesState/*.java
mv SDA3_Broker/src/Interfaces/*.class SDA3_Broker/src/target/Interfaces/
mv SDA3_Broker/src/MainPackage/*.class SDA3_Broker/src/target/MainPackage/
mv SDA3_Broker/src/HelperClasses/*.class SDA3_Broker/src/target/HelperClasses/
mv SDA3_Broker/src/EntitiesState/*.class SDA3_Broker/src/target/EntitiesState/


echo -e "\n${bold}->${normal} A compilar Horse Jockey"
javac SDA3_HorseJockey/src/Interfaces/*.java SDA3_HorseJockey/src/MainPackage/*.java SDA3_HorseJockey/src/HelperClasses/*.java SDA3_HorseJockey/src/EntitiesState/*.java
mv SDA3_HorseJockey/src/Interfaces/*.class SDA3_HorseJockey/src/target/Interfaces/
mv SDA3_HorseJockey/src/MainPackage/*.class SDA3_HorseJockey/src/target/MainPackage/
mv SDA3_HorseJockey/src/HelperClasses/*.class SDA3_HorseJockey/src/target/HelperClasses/
mv SDA3_HorseJockey/src/EntitiesState/*.class SDA3_HorseJockey/src/target/EntitiesState/



echo -e "\n${bold}->${normal} A compilar Spectators"
javac SDA3_Spectators/src/Interfaces/*.java SDA3_Spectators/src/MainPackage/*.java SDA3_Spectators/src/HelperClasses/*.java SDA3_Spectators/src/EntitiesState/*.java
mv SDA3_Spectators/src/Interfaces/*.class SDA3_Spectators/src/target/Interfaces/
mv SDA3_Spectators/src/MainPackage/*.class SDA3_Spectators/src/target/MainPackage/
mv SDA3_Spectators/src/HelperClasses/*.class SDA3_Spectators/src/target/HelperClasses/
mv SDA3_Spectators/src/EntitiesState/*.class SDA3_Spectators/src/target/EntitiesState/


echo -e "\n${bold}* Execução do código em cada nó *${normal}"

echo -e "\n${bold}* A iniciar Registry *${normal}"
cd SDA3_Registry
rmiregistry -J-Djava.rmi.server.useCodebaseOnly=false 22427 &
regId=$!
cd ..

echo -e "\n${bold}->${normal} A executar Registry"
cd SDA3_Registry/src/target/
java -Djava.rmi.server.codebase="file:///home/diogof/Desktop/sd-rmi/SDA3_Registry/src/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     MainPackage.ServerRegisterRemoteObject &
serverId=$!
cd ../../..
sleep 1

echo -e "\n${bold}->${normal} A executar Logger"
cd SDA3_Logger/src/target/
java -Djava.rmi.server.codebase="file:///home/diogof/Desktop/sd-rmi/SDA3_Logger/src/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     MainPackage.MainProgram &
cd ../../..
sleep 1


echo -e "\n${bold}->${normal} A executar Betting Center"
cd SDA3_BettingCenter/src/target/
java -Djava.rmi.server.codebase="file:///home/diogof/Desktop/sd-rmi/SDA3_BettingCenter/src/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     MainPackage.MainProgram &
cd ../../..
sleep 1

echo -e "\n${bold}->${normal} A executar Control Center"
cd SDA3_ControlCenter/src/target/
java -Djava.rmi.server.codebase="file:///home/diogof/Desktop/sd-rmi/SDA3_ControlCenter/src/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     MainPackage.MainProgram &
cd ../../..
sleep 1

echo -e "\n${bold}->${normal} A executar Paddock"
cd SDA3_Paddock/src/target/
java -Djava.rmi.server.codebase="file:///home/diogof/Desktop/sd-rmi/SDA3_Paddock/src/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     MainPackage.MainProgram &
cd ../../..
sleep 1

echo -e "\n${bold}->${normal} A executar Racing Track"
cd SDA3_RacingTrack/src/target/
java -Djava.rmi.server.codebase="file:///home/diogof/Desktop/sd-rmi/SDA3_RacingTrack/src/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     MainPackage.MainProgram &
cd ../../..
sleep 1

echo -e "\n${bold}->${normal} A executar Stable"
cd SDA3_Stable/src/target/
java -Djava.rmi.server.codebase="file:///home/diogof/Desktop/sd-rmi/SDA3_Stable/src/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     -Djava.security.policy=java.policy\
     MainPackage.MainProgram &
cd ../../..
sleep 1

echo -e "\n${bold}->${normal} A executar Broker"
cd SDA3_Broker/src/target/
java -Djava.rmi.server.codebase="file:///home/diogof/Desktop/sd-rmi/SDA3_Broker/src/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     MainPackage.MainProgram &
cd ../../..
sleep 1

echo -e "\n${bold}->${normal} A executar Horses"
cd SDA3_HorseJockey/src/target/
java -Djava.rmi.server.codebase="file:///home/diogof/Desktop/sd-rmi/SDA3_HorseJockey/src/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     MainPackage.MainProgram &
cd ../../..
sleep 1

echo -e "\n${bold}->${normal} A executar Spectators"
cd SDA3_Spectators/src/target/
java -Djava.rmi.server.codebase="file:///home/diogof/Desktop/sd-rmi/SDA3_Spectators/src/target/"\
     -Djava.rmi.server.useCodebaseOnly=false\
     MainPackage.MainProgram &
cd ../../..

wait $serverId

kill -9 $regId

echo -e "\n${bold}->${normal} A execução terminou"

