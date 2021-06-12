package Hostess.EntitiesState;

/**
 * Definition of the internal states of the passenger during his life cycle.
 */
public enum PassengerState {

    /**
     * The passenger goes to the departure airport.
     */
    GOING_TO_AIRPORT("GTAP"),
    /**
     * The passenger queue at the boarding gate waiting for the flight to be
     * announced.
     */
    IN_QUEUE("INQE"),
    /**
     * The passenger flies to the destination airport.
     */
    IN_FLIGHT("INFL"),
    /**
     * The passenger arrives at the destination airport, disembarks and leaves
     * the airport.
     */
    AT_DESTINATION("ATDS");

    private final String state;

    private PassengerState(String state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return this.state;
    }
}
