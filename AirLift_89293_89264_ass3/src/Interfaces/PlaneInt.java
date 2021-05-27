package Interfaces;

import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * PlaneInt interface to implement the stub for other entities.
 */
public interface PlaneInt extends Remote {

    /* ****************************** PASSENGER ***************************** */
    /**
     * The passenger boards the plane.
     *
     * @param id passenger id
     * @throws java.rmi.RemoteException
     */
    public void boardThePlane(int id) throws RemoteException;

    /**
     * The passenger waits for the flight to end.
     *
     * @throws java.rmi.RemoteException
     */
    public void waitForEndOfFlight() throws RemoteException;

    /**
     * The passenger leaves the plane and, if he is the last to leave, notifies
     * the pilot that he is the last passenger of the plane.
     *
     * @param id passenger id
     * @throws java.rmi.RemoteException
     */
    public void leaveThePlane(int id) throws RemoteException;

    /* ******************************** PILOT ******************************* */
    /**
     * The pilot announces the arrival and waits all passengers to leave.
     *
     * @throws java.rmi.RemoteException
     */
    public void announceArrival() throws RemoteException;

    /**
     * The pilot flight to the destination airport.
     *
     * @throws java.rmi.RemoteException
     */
    public void flyToDestinationPoint() throws RemoteException;

    /**
     * The pilot flight to the departure airport.
     *
     * @throws java.rmi.RemoteException
     */
    public void flyToDeparturePoint() throws RemoteException;

    /**
     * The pilot parks the plane at the transfer gate.
     *
     * @throws java.rmi.RemoteException
     */
    public void parkAtTransferGate() throws RemoteException;

    /**
     * Message sent to end the activity.
     *
     * @throws java.rmi.RemoteException
     */
    public void serviceEnd() throws RemoteException;
}
