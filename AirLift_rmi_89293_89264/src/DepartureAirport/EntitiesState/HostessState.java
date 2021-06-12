package DepartureAirport.EntitiesState;

/**
 * Definition of the internal states of the hostess during his life cycle.
 */
public enum HostessState {

    /**
     * The hostess waits the plane to be available for boarding.
     */
    WAIT_FOR_FLIGHT("WTFL"),
    /**
     * The hostess waits passengers to arrive at the airport to check in.
     */
    WAIT_FOR_PASSENGER("WTPS"),
    /**
     * The hostess checks passengers in queue.
     */
    CHECK_PASSENGER("CKPS"),
    /**
     * The hostess announces that there are passengers to board.
     */
    READY_TO_FLY("RDTF");

    private String state;

    private HostessState(String state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return this.state;
    }
}
