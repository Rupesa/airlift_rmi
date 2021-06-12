
echo "----------------------------------------------------------------"
echo "${bold}      AirLift Problem - Generate java docs ${normal}"
echo "----------------------------------------------------------------"

javadoc -d ./DepartureAirportDocs -classpath ./genclass.jar -sourcepath ./DepartureAirport -subpackages Interfaces:EntitiesState:MainPackage
javadoc -d ./DestinationAirportDocs -classpath ./genclass.jar -sourcepath ./DestinationAirport -subpackages Interfaces:EntitiesState:MainPackage
javadoc -d ./PlaneDocs -classpath ./genclass.jar -sourcepath ./Plane -subpackages Interfaces:EntitiesState:MainPackage
javadoc -d ./GeneralReposDocs -classpath ./genclass.jar -sourcepath ./GeneralRepos -subpackages Interfaces:EntitiesState:MainPackage
javadoc -d ./HostessDocs -classpath ./genclass.jar -sourcepath ./Hostess -subpackages Interfaces:EntitiesState:MainPackage
javadoc -d ./PassengerDocs -classpath ./genclass.jar -sourcepath ./Passenger -subpackages Interfaces:EntitiesState:MainPackage
javadoc -d ./PilotDocs -classpath ./genclass.jar -sourcepath ./Pilot -subpackages Interfaces:EntitiesState:MainPackage
javadoc -d ./RegistryDocs -classpath ./genclass.jar -sourcepath ./Registry -subpackages Interfaces:EntitiesState:MainPackage
