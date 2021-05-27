package Registry;

import genclass.GenericIO;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;
import Interfaces.RegisterInt;
import SimulationParameters.SimulationParameters;
import java.rmi.NotBoundException;

/**
 * This data type instantiates and registers a remote object that enables the
 * registration of other remote objects located in the same or other processing
 * nodes in the local registry service. Communication is based in Java RMI.
 */
public class ServerRegisterRemoteObject {

    /**
     * Used to check if the service must terminate.
     */
    public static boolean serviceEnd = false;

    /**
     * Main task.
     *
     * @param args
     */
    public static void main(String[] args) {
        /* get location of the registry service */

        String rmiRegHostName;
        int rmiRegPortNumb;

        rmiRegHostName = SimulationParameters.REGISTRY_HOST_NAME;
        rmiRegPortNumb = SimulationParameters.REGISTRY_PORT;

        /* create and install the security manager */
        if (System.getSecurityManager() == null) {
            System.setSecurityManager(new SecurityManager());
        }

        /* instantiate a registration remote object and generate a stub for it */
        RegisterRemoteObject regEngine = new RegisterRemoteObject(rmiRegHostName, rmiRegPortNumb, 6);
        RegisterInt registerInt = null;
        int listeningPort = SimulationParameters.SERVER_REGISTRY_PORT;

        try {
            registerInt = (RegisterInt) UnicastRemoteObject.exportObject(regEngine, listeningPort);
        } catch (RemoteException e) {
            GenericIO.writelnString("RegisterRemoteObject stub generation exception: " + e.getMessage());
            System.exit(1);
        }

        /* register it with the local registry service */
        String nameEntry = SimulationParameters.REGISTRY_NAME_ENTRY;
        Registry registry = null;

        try {
            registry = LocateRegistry.getRegistry(rmiRegHostName, rmiRegPortNumb);
        } catch (RemoteException e) {
            GenericIO.writelnString("RMI registry creation exception: " + e.getMessage());
            System.exit(1);
        }

        try {
            registry.rebind(nameEntry, registerInt);
        } catch (RemoteException e) {
            GenericIO.writelnString("RegisterRemoteObject remote exception on registration: " + e.getMessage());
            System.exit(1);
        }
        GenericIO.writelnString("RegisterRemoteObject object was registered!");

        /* Wait for the service to end */
        while (!serviceEnd) {
            try {
                synchronized (regEngine) {
                    regEngine.wait();
                }
            } catch (InterruptedException ex) {
                GenericIO.writelnString("Main thread of registry was interrupted.");
                System.exit(1);
            }
        }

        GenericIO.writelnString("Registry finished execution.");

        /* Unregister shared region */
        try {
            registry.unbind(nameEntry);
        } catch (RemoteException e) {
            GenericIO.writelnString("RegisterRemoteObject unregistration exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } catch (NotBoundException ex) {
            GenericIO.writelnString("RegisterRemoteObject unregistration exception: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        }
        GenericIO.writelnString("RegisterRemoteObject object was unregistered!");

        /* Unexport shared region */
        try {
            UnicastRemoteObject.unexportObject(regEngine, false);
        } catch (RemoteException e) {
            GenericIO.writelnString("RegisterRemoteObject unexport exception: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }

        GenericIO.writelnString("RegisterRemoteObject object was unexported successfully!");
    }
}
