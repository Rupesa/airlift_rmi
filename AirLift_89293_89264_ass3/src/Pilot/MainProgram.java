package Pilot;

import Interfaces.*;
import SimulationParameters.SimulationParameters;
import genclass.GenericIO;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

/**
 * Main pilot program. Get the shared regions from the register and start pilot
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
        PlaneInt plane = null;
        DestinationAirportInt destinationAirport = null;

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

        try {
            plane = (PlaneInt) registry.lookup(SimulationParameters.PLANE_NAME_ENTRY);
        } catch (NotBoundException ex) {
            System.out.println("Plane is not registered: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        } catch (RemoteException ex) {
            System.out.println("Exception thrown while locating Plane: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        }

        try {
            destinationAirport = (DestinationAirportInt) registry.lookup(SimulationParameters.DESTINATION_AIRPORT_NAME_ENTRY);
        } catch (NotBoundException ex) {
            System.out.println("DestinationAirport is not registered: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        } catch (RemoteException ex) {
            System.out.println("Exception thrown while locating DestinationAirport: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        }

        GenericIO.writelnString("Starting Pilot...");

        /**
         * Pilot lifecycle start.
         */
        Pilot piloto = new Pilot("Pilot", departureAirport, destinationAirport, plane);
        piloto.start();
        try {
            piloto.join();
        } catch (InterruptedException ex) {
            ex.printStackTrace();
        }

        //registry.unbind(SimulationParameters.REGISTRY_NAME_ENTRY);

        GenericIO.writelnString("The pilot has terminated.");
    }
}
