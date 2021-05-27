package GeneralRepos;

import Interfaces.*;
import SimulationParameters.SimulationParameters;
import genclass.GenericIO;
import java.rmi.AlreadyBoundException;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;

/**
 * Main GeneralRepos program. Registers the GeneralRepos in the register server
 * and waits for connections.
 */
public class MainProgram {

    /**
     * Used to check if the service must terminate.
     */
    public static boolean serviceEnd = false;

    /**
     * Main GeneralRepos launcher
     *
     * @param args args
     */
    public static void main(String args[]) {

        /* get location of the registry service */
        String rmiRegHostName = SimulationParameters.REGISTRY_HOST_NAME;
        int rmiRegPortNumb = SimulationParameters.REGISTRY_PORT;

        String nameEntryBase = SimulationParameters.REGISTRY_NAME_ENTRY;
        String nameEntryObject = SimulationParameters.REPOS_NAME_ENTRY;
        Registry registry = null;
        RegisterInt registerInt = null;

        /* create and install the security manager */
        if (System.getSecurityManager() == null) {
            System.setSecurityManager(new SecurityManager());
        }

        /* Get the RMI server registry */
        try {
            registry = LocateRegistry.getRegistry(rmiRegHostName, rmiRegPortNumb);
        } catch (RemoteException e) {
            GenericIO.writelnString("RMI registry locate exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }

        /* Shared region initialization */
        GeneralRepos logger = new GeneralRepos("rep.txt");
        GeneralReposInt loggerInt = null;

        /* Export logger to the registry */
        try {
            loggerInt = (GeneralReposInt) UnicastRemoteObject.exportObject(logger, SimulationParameters.REPOS_PORT);
        } catch (RemoteException e) {
            GenericIO.writelnString("GeneralRepos stub generation exception: " + e.getMessage());
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
            registerInt.bind(nameEntryObject, loggerInt);
        } catch (RemoteException e) {
            GenericIO.writelnString("GeneralRepos registration exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } catch (AlreadyBoundException e) {
            GenericIO.writelnString("GeneralRepos already bound exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
        GenericIO.writelnString("GeneralRepos object was registered!");

        /* Wait for the service to end */
        while (!serviceEnd) {
            try {
                synchronized (logger) {
                    logger.wait();
                }
            } catch (InterruptedException ex) {
                GenericIO.writelnString("Main thread of GeneralRepos was interrupted.");
                System.exit(1);
            }
        }

        GenericIO.writelnString("GeneralRepos finished execution.");

        /* Unregister shared region */
        try {
            registerInt.unbind(nameEntryObject);
        } catch (RemoteException e) {
            GenericIO.writelnString("GeneralRepos unregistration exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } catch (NotBoundException ex) {
            GenericIO.writelnString("GeneralRepos unregistration exception: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        }
        GenericIO.writelnString("GeneralRepos object was unregistered!");

        /* Unexport shared region */
        try {
            UnicastRemoteObject.unexportObject(logger, false);
        } catch (RemoteException e) {
            GenericIO.writelnString("GeneralRepos unexport exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }

        GenericIO.writelnString("GeneralRepos object was unexported successfully!");
    }
}
