bold=$(tput bold)
normal=$(tput sgr0)

echo "----------------------------------------------------------------"
echo "${bold}      AirLift Problem - Removing local files ${normal}"
echo "----------------------------------------------------------------"

rm -f $(find . -name '*.class')
rm Registry/MainPackage/SimulationParameters.java
rm GeneralRepos/MainPackage/SimulationParameters.java
rm DepartureAirport/MainPackage/SimulationParameters.java
rm DestinationAirport/MainPackage/SimulationParameters.java
rm Plane/MainPackage/SimulationParameters.java
rm Hostess/MainPackage/SimulationParameters.java
rm Pilot/MainPackage/SimulationParameters.java
rm Passenger/MainPackage/SimulationParameters.java

rm Registry/genclass.jar
rm GeneralRepos/genclass.jar
rm DepartureAirport/genclass.jar
rm DestinationAirport/genclass.jar
rm Plane/genclass.jar
rm Passenger/genclass.jar
rm Hostess/genclass.jar
rm Pilot/genclass.jar
rm Registry/target/genclass.jar
rm GeneralRepos/target/genclass.jar
rm DepartureAirport/target/genclass.jar
rm DestinationAirport/target/genclass.jar
rm Plane/target/genclass.jar
rm Hostess/target/genclass.jar
rm Pilot/target/genclass.jar
rm Passenger/target/genclass.jar

rm GeneralRepos/target/log.txt
rm log.txt

rm -r DepartureAirportDocs
rm -r DestinationAirportDocs
rm -r PlaneDocs
rm -r GeneralReposDocs
rm -r HostessDocs
rm -r PilotDocs
rm -r PassengerDocs
rm -r RegistryDocs
