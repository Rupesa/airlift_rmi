package GeneralRepos.Interfaces;

import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * Departure Airport interface to implement the stub for other entities.
 */
public interface DepartureAirportInt extends Remote {

    /* ******************************* HOSTESS ****************************** */
    /**
     * The hostess waits for the next flight to be ready for boarding.
     *
     * @throws java.rmi.RemoteException
     */
    public void waitForNextFlight() throws RemoteException;

    /**
     * The hostess waits for the next passenger in the queue.
     *
     * @throws java.rmi.RemoteException
     */
    public void waitForNextPassenger() throws RemoteException;

    /**
     * The hostess asks the passenger for the documents and waits for him to
     * deliver them.
     *
     * @throws java.rmi.RemoteException
     */
    public void checkDocuments() throws RemoteException;

    /**
     * The hostess informs the pilot that the plane is ready to take off.
     *
     * @throws java.rmi.RemoteException
     */
    public void informPlaneReadyToTakeOff() throws RemoteException;


    /* ****************************** PASSENGER ***************************** */
    /**
     * The passenger goes to the airport.It is called by a passenger.
     *
     * @param id passenger id
     * @throws java.rmi.RemoteException
     */
    public void travelToAirport(int id) throws RemoteException;

    /**
     * The passenger waits in line for the check in.
     *
     * @param id passenger id
     * @throws java.rmi.RemoteException
     */
    public void waitInQueue(int id) throws RemoteException;

    /**
     * The passenger is asked to show his documents and he shows them to the
     * hostess.
     *
     * @throws java.rmi.RemoteException
     */
    public void showDocuments() throws RemoteException;

    /* ******************************** PILOT ******************************* */
    /**
     * The pilot informs the plane that he is ready to board.
     *
     * @throws java.rmi.RemoteException
     */
    public void informPlaneReadyForBoarding() throws RemoteException;

    /**
     * The pilot waits for the passengers to be on the plane and then is ready
     * to fly.
     *
     * @throws java.rmi.RemoteException
     */
    public void waitForAllInBoard() throws RemoteException;

    /**
     * The pilot stops his activity when the hostess tells him to.
     *
     * @return the value of the hostessInformPilotToEndActivity variable
     * @throws java.rmi.RemoteException
     */
    public boolean informPilotToEndActivity() throws RemoteException;

    /**
     * Stop the service and shuts down the shared region.
     *
     * @throws java.rmi.RemoteException
     */
    public void serviceEnd() throws RemoteException;
}
