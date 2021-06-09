package Registry;

import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.RemoteException;
import java.rmi.AccessException;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.server.*;
import genclass.GenericIO;
import Interfaces.RegisterInt;
import SimulationParameters.SimulationParameters;
import java.rmi.NotBoundException;

/**
 *   Instantiation and registering of a remote object that enables the registration of other remote objects
 *   located in the same or other processing nodes of a parallel machine in the local registry service.
 *
 *   Communication is based in Java RMI.
 */

public class ServerRegisterRemoteObject
{
  /**
   *  Main method.
   *
   *    @param args runtime arguments
   */

/**
 * Used to check if the service must terminate.
 */

   public static boolean serviceEnd = false;

   public static void main(String[] args)
   {
    /* get location of the registering service */

     String rmiRegHostName;
     int rmiRegPortNumb;

     //GenericIO.writeString ("Name of the processing node where the registering service is located? ");
     rmiRegHostName = SimulationParameters.REGISTRY_HOST_NAME;
     //GenericIO.writeString ("Port number where the registering service is listening to? ");
     rmiRegPortNumb = SimulationParameters.REGISTRY_PORT;

    /* create and install the security manager */

     if (System.getSecurityManager () == null)
        System.setSecurityManager (new SecurityManager ());
     GenericIO.writelnString ("Security manager was installed!");

    /* instantiate a registration remote object and generate a stub for it */

     RegisterRemoteObject regEngine = new RegisterRemoteObject (rmiRegHostName, rmiRegPortNumb, 4);
     RegisterInt regEngineStub = null;
     int listeningPort = SimulationParameters.SERVER_REGISTRY_PORT;                                      /* it should be set accordingly in each case */

     try
     { regEngineStub = (RegisterInt) UnicastRemoteObject.exportObject (regEngine, listeningPort);
     }
     catch (RemoteException e)
     { GenericIO.writelnString ("RegisterRemoteObject stub generation exception: " + e.getMessage ());
       System.exit (1);
     }
     GenericIO.writelnString ("Stub was generated!");

    /* register it with the local registry service */

     String nameEntry = SimulationParameters.REGISTRY_NAME_ENTRY;
     Registry registry = null;

     try
     { registry = LocateRegistry.getRegistry (rmiRegHostName, rmiRegPortNumb);
     }
     catch (RemoteException e)
     { GenericIO.writelnString ("RMI registry creation exception: " + e.getMessage ());
       System.exit (1);
     }
     GenericIO.writelnString ("RMI registry was created!");

     try
     { registry.rebind (nameEntry, regEngineStub);
     }
     catch (RemoteException e)
     { GenericIO.writelnString ("RegisterRemoteObject remote exception on registration: " + e.getMessage ());
       System.exit (1);
     }
     GenericIO.writelnString ("RegisterRemoteObject object was registered!");

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
