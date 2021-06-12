package MainPackage;

import Interfaces.DestinationAirportInt;
import Interfaces.GeneralReposInt;
import genclass.GenericIO;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.rmi.RemoteException;

/**
 * Where passengers leave the airport.
 */
public class DestinationAirport implements DestinationAirportInt {

    /**
     * GeneralRepos class for debugging.
     */
    private final GeneralReposInt repos;

    // configurations
    private int numberOfPassengersLeavingThePlane;

    /**
     * DestinationAirport class constructor.
     *
     * @param repos
     */
    public DestinationAirport(GeneralReposInt repos) {
        this.repos = repos;
    }

    /* ****************************** PASSENGER ***************************** */
    /**
     * The passenger leaves airport. It is called by a passenger.
     */
    @Override
    public synchronized void leaveAirport() throws RemoteException {
        GenericIO.writelnString("(26) Passenger leave airport");
        numberOfPassengersLeavingThePlane++;
    }

    /**
     * Terminate the departure airport service.
     */
    @Override
    public synchronized void serviceEnd() throws RemoteException {
        MainProgram.serviceEnd = true;
        notifyAll();
    }
}
