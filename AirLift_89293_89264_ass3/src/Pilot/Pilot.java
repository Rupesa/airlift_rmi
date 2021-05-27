package Pilot;

import EntitiesState.PilotState;
import Interfaces.*;
import genclass.GenericIO;
import java.rmi.RemoteException;

/**
 * Pilot thread. It simulates the pilot life cycle.
 */
public class Pilot extends Thread {

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
     * Current pilot state.
     */
    private PilotState state;

    /**
     * Pilot constructor
     *
     * @param name thread name
     * @param departureAirport instance of the departureAirport
     * @param plane instance of the plane
     */
    public Pilot(String name, DepartureAirportInt departureAirport, DestinationAirportInt destinationAirport, PlaneInt plane) {
        super(name);
        this.departureAirport = departureAirport;
        this.plane = plane;
        this.destinationAirport = destinationAirport;
        this.state = PilotState.AT_TRANSFER_GATE;
    }

    @Override
    public void run() {
        GenericIO.writelnString("Started Pilot activity");
        try{
            while (!departureAirport.informPilotToEndActivity()) {
            departureAirport.informPlaneReadyForBoarding();
            // MUDAR ESTADO ???
            departureAirport.waitForAllInBoard();
            // MUDAR ESTADO ???
            plane.flyToDestinationPoint();
            // MUDAR ESTADO ???
            plane.announceArrival();
            // MUDAR ESTADO ???
            plane.flyToDeparturePoint();
            // MUDAR ESTADO ???
            plane.parkAtTransferGate();
            // MUDAR ESTADO ???
            }
            try {
                destinationAirport.serviceEnd();
                destinationAirport.serviceEnd();
                plane.serviceEnd();
                plane.serviceEnd();
                departureAirport.serviceEnd();
            } catch (Exception e) {
            }
        } catch (RemoteException ex) {
            GenericIO.writelnString ("Remote exception: " + ex.getMessage ());
            ex.printStackTrace ();
            System.exit (1);
        }
        GenericIO.writelnString("Ended Pilot activity");
    }

    /**
     * Get the pilot state
     *
     * @return the state
     */
    public PilotState getPilotState() {
        return state;
    }

    /**
     * Set the pilot state
     *
     * @param state the state to set
     */
    public void setPilotState(PilotState state) {
        this.state = state;
    }
}
