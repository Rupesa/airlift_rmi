package Hostess.MainPackage;

import Hostess.EntitiesState.HostessState;
import Hostess.Interfaces.*;
import genclass.GenericIO;
import java.rmi.RemoteException;

/**
 * Hostess thread. It simulates the hostess life cycle.
 */
public class Hostess extends Thread {

    /**
     * Instance of the departureAirport.
     */
    private final DepartureAirportInt departureAirport;

    /**
     * Current hostess state.
     */
    private HostessState hostessState;

    /**
     * Maximum number of passengers.
     */
    private int maxNumberOfPassengers;

    /**
     * Number of attended passengers.
     */
    private int numberOfAttendedPassengers;

    /**
     * Hostess constructor
     *
     * @param name thread name
     * @param departureAirport instance of the departureAirport
     * @param max maximum number of passengers
     */
    public Hostess(String name, DepartureAirportInt departureAirport, int max) {
        super(name);
        this.departureAirport = departureAirport;
        this.maxNumberOfPassengers = max;
        this.numberOfAttendedPassengers = 0;
        this.hostessState = HostessState.WAIT_FOR_FLIGHT;
    }

    @Override
    public void run() {
        GenericIO.writelnString("Started Hostess activity");
        try {
            while (maxNumberOfPassengers > numberOfAttendedPassengers) {
                departureAirport.waitForNextFlight();
                departureAirport.waitForNextPassenger();
                departureAirport.checkDocuments();
                numberOfAttendedPassengers++;
                departureAirport.informPlaneReadyToTakeOff();
            }
        } catch (RemoteException ex) {
            GenericIO.writelnString("Remote exception: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        }
        GenericIO.writelnString("Ended Hostess activity");
    }

    /**
     * Get the hostess state
     *
     * @return the state
     */
    public HostessState getHostessState() {
        return hostessState;
    }

    /**
     * Set the hostess state
     *
     * @param state the state to set
     */
    public void setHostessState(HostessState state) {
        this.hostessState = state;
    }
}
