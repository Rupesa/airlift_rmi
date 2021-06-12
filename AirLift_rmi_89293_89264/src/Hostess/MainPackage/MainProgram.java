package MainPackage;

import Interfaces.*;
import genclass.GenericIO;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

/**
 * Main hostess program. Get the shared regions from the register and start hostess
 * lifecycle.
 */
public class MainProgram {

    public static void main(String args[]) {

        /* get location of the generic registry service */
        String rmiRegHostName = SimulationParameters.REGISTRY_HOST_NAME;
        int rmiRegPortNumb = SimulationParameters.REGISTRY_PORT;

        /* look for the remote object by name in the remote host registry */
        String nameEntry = SimulationParameters.REGISTRY_NAME_ENTRY;
        Registry registry = null;

        /* Interface initialization */
        DepartureAirportInt departureAirport = null;
        
        /* create RMI registry */
        try {
            registry = LocateRegistry.getRegistry(rmiRegHostName, rmiRegPortNumb);
        } catch (RemoteException e) {
            GenericIO.writelnString("RMI registry creation exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
        GenericIO.writelnString("RMI registry was created!");

        /* Check others entities in the registry */
        try {
            departureAirport = (DepartureAirportInt) registry.lookup(SimulationParameters.DEPARTURE_AIRPORT_NAME_ENTRY);
        } catch (NotBoundException ex) {
            System.out.println("DepartureAirport is not registered: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        } catch (RemoteException ex) {
            System.out.println("Exception thrown while locating DepartureAirport: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        }
        
        GenericIO.writelnString("Starting Hostess...");
        
        /**
         * Hostess lifecycle start.
         */
        Hostess hostess = new Hostess("Hostess", departureAirport, SimulationParameters.TTL_PASSENGER);
        hostess.start();
        try {
            hostess.join();
        } catch (InterruptedException ex) {
            ex.printStackTrace();
        }
        
        GenericIO.writelnString("The hostess has terminated.");
    }
}
