package Registry.EntitiesState;

/**
 * Definition of the internal states of the pilot during his life cycle.
 */
public enum PilotState {

    /**
     * The pilot returns to the airport and prepares for a new departure.
     */
    AT_TRANSFER_GATE("ATGR"),
    /**
     * The pilot announces that he is ready for boarding.
     */
    READY_FOR_BOARDING("RDFB"),
    /**
     * The pilot waits the plane to be ready to board.
     */
    WAITING_FOR_BOARDING("WTFB"),
    /**
     * The pilot flies to the destination airport.
     */
    FLYING_FORWARD("FLFW"),
    /**
     * The pilot arrives at the destination airport and waits passengers to
     * disembark.
     */
    DEBOARDING("DRPP"),
    /**
     * The pilot flies brack to the departure airport.
     */
    FLYING_BACK("FLBK");

    private final String state;

    private PilotState(String state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return this.state;
    }
}
