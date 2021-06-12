package MainPackage;

import EntitiesState.PassengerState;
import EntitiesState.PilotState;
import Interfaces.*;
import genclass.GenericIO;
import java.rmi.RemoteException;

/**
 * Passenger thread. It simulates the passenger life cycle.
 */
public class Passenger extends Thread {

    /**
     * Instance of the departureAirport.
     */
    private final DepartureAirportInt departureAirport;

    /**
     * Instance of the plane.
     */
    private final PlaneInt plane;

    /**
     * Instance of the destinationAirport.
     */
    private final DestinationAirportInt destinationAirport;

    /**
     * Id of Passenger
     */
    private int idPassenger;

    /**
     * Current passenger state.
     */
    private PassengerState state;

    /**
     * Passenger constructor
     *
     * @param name thread name
     * @param id of passenger
     * @param departureAirport instance of the departureAirport
     * @param plane instance of the plane
     * @param destinationAirport instance of the destinationAirport
     */
    public Passenger(String name, DepartureAirportInt departureAirport, PlaneInt plane, DestinationAirportInt destinationAirport, int id) {
        super(name);
        this.departureAirport = departureAirport;
        this.destinationAirport = destinationAirport;
        this.plane = plane;
        this.idPassenger = id;
        this.state = PassengerState.GOING_TO_AIRPORT;
    }

    @Override
    public void run() {
        GenericIO.writelnString("Started Passenger " + getPassengerId() + " activity");
        try {
            goingToAirport();
            departureAirport.travelToAirport(getPassengerId());
            departureAirport.waitInQueue(getPassengerId());
            departureAirport.showDocuments();
            plane.boardThePlane(getPassengerId());
            plane.waitForEndOfFlight();
            plane.leaveThePlane(getPassengerId());
            destinationAirport.leaveAirport();
        } catch (RemoteException ex) {
            GenericIO.writelnString("Remote exception: " + ex.getMessage());
            ex.printStackTrace();
            System.exit(1);
        }
        GenericIO.writelnString("Ended Passenger " + getPassengerId() + " activity");
    }

    /**
     * The passenger goes to the airport.
     *
     * Internal operation.
     */
    private void goingToAirport() {
        int randomSleepValue = (int) ((Math.random() * (10 - 5)) + 5);
        try {
            Thread.sleep(randomSleepValue * 1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * Get the passenger id
     *
     * @return the id
     */
    public int getPassengerId() {
        return idPassenger;
    }

    /**
     * Set the passenger id
     *
     * @param id the id to set
     */
    public void setPassengerId(int id) {
        this.idPassenger = id;
    }

    /**
     * Get the passenger state
     *
     * @return the state
     */
    public PassengerState getPassengerState() {
        return state;
    }

    /**
     * Set the passenger state
     *
     * @param state the state to set
     */
    public void setPassengerState(PassengerState state) {
        this.state = state;
    }
}
