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
 * Main DepartureAirport program. Registers the DepartureAirport in the register
 * server and waits for a connection.
 */
public class MainProgram {

    /**
     * Used to check if the service must terminate.
     */
    public static boolean serviceEnd = false;

    /**
     * Main DepartureAirport launcher
     *
     * @param args args
     */
    public static void main(String[] args) {

        /* get location of the registry service */
        String rmiRegHostName = SimulationParameters.REGISTRY_HOST_NAME;
        int rmiRegPortNumb = SimulationParameters.REGISTRY_PORT;

        String nameEntryBase = SimulationParameters.REGISTRY_NAME_ENTRY;
        String nameEntryObject = SimulationParameters.DEPARTURE_AIRPORT_NAME_ENTRY;
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
        // DepartureAirport dp = new DepartureAirport(logger);
        DepartureAirport dp = new DepartureAirport(SimulationParameters.MIN_PASSENGER, SimulationParameters.MAX_PASSENGER, SimulationParameters.TTL_PASSENGER, logger);
        DepartureAirportInt dpInt = null;

        try {
            dpInt = (DepartureAirportInt) UnicastRemoteObject.exportObject(dp, SimulationParameters.DEPARTURE_AIRPORT_PORT);
        } catch (RemoteException e) {
            GenericIO.writelnString("DepartureAirport stub generation exception: " + e.getMessage());
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
            GenericIO.writelnString("DepartureAirport registration exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } catch (AlreadyBoundException e) {
            GenericIO.writelnString("DepartureAirport already bound exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }

        GenericIO.writelnString("DepartureAirport object was registered!");

        /* Wait for the service to end */
        while (!serviceEnd) {
            try {
                synchronized (dp) {
                    dp.wait();
                }
            } catch (InterruptedException ex) {
                GenericIO.writelnString("Main thread of DepartureAirport was interrupted.");
                System.exit(1);
            }
        }

        GenericIO.writelnString("DepartureAirport finished execution.");

        /* Unregister shared region */
        try {
            registerInt.unbind(nameEntryObject);
        } catch (RemoteException e) {
            GenericIO.writelnString("DepartureAirport unregistration exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } catch (NotBoundException ex) {
            GenericIO.writelnString("DepartureAirport unregistration exception: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        }
        GenericIO.writelnString("DepartureAirport object was unregistered!");

        /* Unexport shared region */
        try {
            UnicastRemoteObject.unexportObject(dp, false);
        } catch (RemoteException e) {
            GenericIO.writelnString("DepartureAirport unexport exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }

        GenericIO.writelnString("DepartureAirport object was unexported successfully!");
    }
}
