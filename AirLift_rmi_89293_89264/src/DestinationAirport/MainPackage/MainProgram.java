package MainPackage;

import Interfaces.*;
import genclass.GenericIO;
import java.rmi.AlreadyBoundException;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;

/**
 * Main DestinationAirport program. Registers the DepartureAirport in the register
 * server and waits for a connection.
 */
public class MainProgram {

    /**
     * Used to check if the service must terminate.
     */
    public static boolean serviceEnd = false;

    /**
     * Main DestinationAirport launcher
     *
     * @param args args
     */
    public static void main(String[] args) {

        /* get location of the registry service */
        String rmiRegHostName = SimulationParameters.REGISTRY_HOST_NAME;
        int rmiRegPortNumb = SimulationParameters.REGISTRY_PORT;

        String nameEntryBase = SimulationParameters.REGISTRY_NAME_ENTRY;
        String nameEntryObject = SimulationParameters.DESTINATION_AIRPORT_NAME_ENTRY;
        Registry registry = null;
        RegisterInt registerInt = null;

        /* create and install the security manager */
        if (System.getSecurityManager() == null) {
            System.setSecurityManager(new SecurityManager());
        }

        try {
            registry = LocateRegistry.getRegistry(rmiRegHostName, rmiRegPortNumb);
        } catch (RemoteException e) {
            GenericIO.writelnString("RMI registry locate exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
        
        /* Localize the GeneralRepos in the RMI server by its name */
        GeneralReposInt logger = null;
        try {
            logger = (GeneralReposInt) registry.lookup(SimulationParameters.REPOS_NAME_ENTRY);
        } catch (RemoteException e) {
            System.out.println("GeneralRepos lookup exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } catch (NotBoundException e) {
            System.out.println("GeneralRepos not bound exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
        
        /* Initialize the shared region */
        DestinationAirport dt = new DestinationAirport(logger);
        DestinationAirportInt dpInt = null;

        try {
            dpInt = (DestinationAirportInt) UnicastRemoteObject.exportObject(dt, SimulationParameters.DESTINATION_AIRPORT_PORT);
        } catch (RemoteException e) {
            GenericIO.writelnString("DestinationAirport stub generation exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
        
        /* register it with the general registry service */
        try {
            registerInt = (RegisterInt) registry.lookup(nameEntryBase);
        } catch (RemoteException e) {
            GenericIO.writelnString("Register lookup exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } catch (NotBoundException e) {
            GenericIO.writelnString("Register not bound exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }

        try {
            registerInt.bind(nameEntryObject, dpInt);
        } catch (RemoteException e) {
            GenericIO.writelnString("DestinationAirport registration exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } catch (AlreadyBoundException e) {
            GenericIO.writelnString("DestinationAirport already bound exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }

        GenericIO.writelnString("DestinationAirport object was registered!");

        /* Wait for the service to end */
        while (!serviceEnd) {
            try {
                synchronized (dt) {
                    dt.wait();
                }
            } catch (InterruptedException ex) {
                GenericIO.writelnString("Main thread of DestinationAirport was interrupted.");
                System.exit(1);
            }
        }

        GenericIO.writelnString("DestinationAirport finished execution.");

        /* Unregister shared region */
        try {
            registerInt.unbind(nameEntryObject);
        } catch (RemoteException e) {
            GenericIO.writelnString("DestinationAirport unregistration exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } catch (NotBoundException ex) {
            GenericIO.writelnString("DestinationAirport unregistration exception: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        }
        GenericIO.writelnString("DestinationAirport object was unregistered!");

        /* Unexport shared region */
        try {
            UnicastRemoteObject.unexportObject(dt, false);
        } catch (RemoteException e) {
            GenericIO.writelnString("DestinationAirport unexport exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }

        GenericIO.writelnString("DestinationAirport object was unexported successfully!");
    }
}
