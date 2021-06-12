package Plane.Interfaces;

import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * Destination Airport interface to implement the stub for other entities.
 */
public interface DestinationAirportInt extends Remote {

    /* ****************************** PASSENGER ***************************** */
    /**
     * The passenger leaves airport. It is called by a passenger.
     *
     * @throws java.rmi.RemoteException
     */
    public void leaveAirport() throws RemoteException;

    /**
     * Message sent to end the activity.
     *
     * @throws java.rmi.RemoteException
     */
    public void serviceEnd() throws RemoteException;
}
