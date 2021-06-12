package Interfaces;

import EntitiesState.HostessState;
import EntitiesState.PassengerState;
import EntitiesState.PilotState;
import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * General Repository interface to implement the stub for other entities.
 */
public interface GeneralReposInt extends Remote {

    /**
     * Updates the state of the hostess
     *
     * @param state new hostess state
     * @param id id of passenger
     * @throws java.rmi.RemoteException
     */
    public void updateHostessState(HostessState state, int id) throws RemoteException;

    /**
     * Updates the state of the hostess
     *
     * @throws java.rmi.RemoteException
     */
    public void reportFinalStatus() throws RemoteException;

    /**
     * Updates the state of the pilot
     *
     * @param state new pilot state
     * @throws java.rmi.RemoteException
     */
    public void updatePilotState(PilotState state) throws RemoteException;

    /**
     * Updates the state of a passenger
     *
     * @param id id of the passenger
     * @param state new passenger state
     * @throws java.rmi.RemoteException
     */
    public void updatePassengerState(PassengerState state, int id) throws RemoteException;

    /**
     * Updates the state of a flight
     *
     * @param numberOfFilght number of flight
     * @param numberOfPassengerOnThePlane number of passenger on the plane per
     * flight
     * @throws java.rmi.RemoteException
     */
    public void updateInfoBoardPlane(int numberOfFilght, int numberOfPassengerOnThePlane) throws RemoteException;

    /**
     * Message sent to end the activity.
     *
     * @throws java.rmi.RemoteException
     */
    public void serviceEnd() throws RemoteException;
}
