package GeneralRepos.MainPackage;

import GeneralRepos.EntitiesState.HostessState;
import GeneralRepos.EntitiesState.PassengerState;
import GeneralRepos.EntitiesState.PilotState;
import GeneralRepos.Interfaces.DepartureAirportInt;
import SimulationParameters.SimulationParameters;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.rmi.RemoteException;
import GeneralRepos.Interfaces.GeneralReposInt;
import java.util.Objects;
import genclass.GenericIO;
import genclass.TextFile;

/**
 * General Repository for the program.
 * Writes the logs to a file specified on the SimulationParameters class.
 * Also has the intervining entities and the shared regions needed to print the logs.
 */
public class GeneralRepos implements GeneralReposInt{

    /**
     * Name of the logging file.
     */
    private final String logFileName;

    /**
     * Information of flight.
     */
    private int numOfFlight;
    private int flight;
    private int currentPassenger;
    private String[] voos;

    /**
     * State of the pilot.
     */
    private PilotState pilotState;
    private PilotState lastPilotReportedState;

    /**
     * State of the hostess.
     */
    private HostessState hostessState;
    private HostessState lastHostessReportedState;
    /**
     * State of the passengers.
     */
    private final PassengerState[] passengerState;
    private PassengerState[] lastPassengerReportedState;

    /**
     * Number of passengers presently forming a queue to board the plane.
     */
    private int inQ;

    /**
     * Number of passengers in the plane.
     */
    private int inF;

    /**
     * Number of passengers that have already arrived at their destination.
     */
    private int pTAL;

    /**
     * Instantiation of a general repository object.
     *
     * @param logFileName name of the logging file
     */
    public GeneralRepos(String logFileName) {
        if ((logFileName == null) || Objects.equals(logFileName, "")) {
            this.logFileName = "logger";
        } else {
            this.logFileName = logFileName;
        }
        pilotState = PilotState.AT_TRANSFER_GATE;
        lastPilotReportedState = null;
        currentPassenger = 0;
        hostessState = HostessState.WAIT_FOR_FLIGHT;
        lastHostessReportedState = null;
        passengerState = new PassengerState[SimulationParameters.TTL_PASSENGER];
        lastPassengerReportedState = new PassengerState[SimulationParameters.TTL_PASSENGER];
        for (int i = 0; i < passengerState.length; i++) {
            passengerState[i] = PassengerState.GOING_TO_AIRPORT;
            lastPassengerReportedState[i] = null;
        }
        reportInitialStatus();
        this.inQ = 0;
        this.inF = 0;
        this.pTAL = 0;
        voos = new String[6];
        this.flight = 1;
    }

    /**
     * Set flight state.
     *
     * @param nFlight number of flight
     * @param nPassengers number of passengers on the flight
     */
    @Override
    public synchronized void updateInfoBoardPlane(int nFlight, int nPassengers) throws RemoteException {
        this.numOfFlight = nFlight;
        voos[numOfFlight - 1] = numOfFlight + "-" + nPassengers;
    }

    /**
     * Set pilot state.
     *
     * @param state pilot state
     */
    @Override
    public synchronized void updatePilotState(PilotState state) throws RemoteException {
        pilotState = state;
        reportStatus();
    }

    /**
     * Set hostess state.
     *
     * @param id id passenger
     * @param state hostess state
     */
    @Override
    public synchronized void updateHostessState(HostessState state, int id) throws RemoteException {
        hostessState = state;
        currentPassenger = id;
        reportStatus();
    }

    /**
     * Set hostess state.
     *
     * @param state hostess state
     * @throws java.rmi.RemoteException
     */
    public synchronized void updateHostessState(HostessState state) throws RemoteException {
        hostessState = state;
        reportStatus();
    }

    /**
     * Set passenger state.
     *
     * @param id passenger id
     * @param state passenger state
     */
    @Override
    public synchronized void updatePassengerState(PassengerState state, int id) throws RemoteException {
        passengerState[id] = state;
        reportStatus();
    }

    /**
     * Write the header to the logging file.
     *
     * Internal operation.
     */
    private void reportInitialStatus() {
        TextFile log = new TextFile();

        if (!log.openForWriting(".", logFileName)) {
            GenericIO.writelnString("The operation of creating the file " + logFileName + " failed!");
            System.exit(1);
        }

        /* initial status */
        log.writelnString("\t\t\t\t\t\t   Airlift - Description of the internal state\n");
        log.writelnString("  PT    HT    P00   P01   P02   P03   P04   P05   P06   P07   P08   P09   P10   P11   P12   P13   P14   P15   P16   P17   P18   P19   P20  InQ   InF  PTAL");

        if (!log.close()) {
            GenericIO.writelnString("The operation of closing the file " + logFileName + " failed!");
            System.exit(1);
        }

        reportStatus();
    }

    /**
     * Write a state line at the end of the logging file.
     *
     * Internal operation.
     */
    private void reportStatus() {
        TextFile log = new TextFile();

        String lineStatus = "";

        if (!log.openForAppending(".", logFileName)) {
            GenericIO.writelnString("The operation of opening for appending the file " + logFileName + " failed!");
            System.exit(1);
        }

        /* check pilot state */
        if (pilotState == PilotState.AT_TRANSFER_GATE) {
            lineStatus += " ATGR ";
            lastPilotReportedState = PilotState.AT_TRANSFER_GATE;
        } else if (pilotState == PilotState.READY_FOR_BOARDING) {
            /* check and print flight status : BOARDING STARTED */
            if (lastPilotReportedState == PilotState.AT_TRANSFER_GATE) {
                log.writelnString("\n Flight " + flight + ": boarding started.");
            }
            lineStatus += " RDFB ";
            lastPilotReportedState = PilotState.READY_FOR_BOARDING;
        } else if (pilotState == PilotState.WAITING_FOR_BOARDING) {
            lineStatus += " WTFB ";
            lastPilotReportedState = PilotState.WAITING_FOR_BOARDING;
        } else if (pilotState == PilotState.FLYING_FORWARD) {
            lineStatus += " FLFW ";
            lastPilotReportedState = PilotState.FLYING_FORWARD;
        } else if (pilotState == PilotState.DEBOARDING) {
            /* check and print flight status : ARRIVED */
            if (lastPilotReportedState == PilotState.FLYING_FORWARD) {
                log.writelnString("\n Flight " + flight + ": arrived.");
            }
            lineStatus += " DRPP ";
            lastPilotReportedState = PilotState.DEBOARDING;
        } else if (pilotState == PilotState.FLYING_BACK) {
            /* check and print flight status : RETURNING */
            if (lastPilotReportedState == PilotState.DEBOARDING) {
                log.writelnString("\n Flight " + flight + ": returning.");
                flight++;
            }
            lineStatus += " FLBK ";
            lastPilotReportedState = PilotState.FLYING_BACK;
        }

        /* check hostess state */
        if (hostessState == HostessState.WAIT_FOR_FLIGHT) {
            lineStatus += " WTFL ";
            lastHostessReportedState = HostessState.WAIT_FOR_FLIGHT;
        } else if (hostessState == HostessState.WAIT_FOR_PASSENGER) {
            lineStatus += " WTPS ";
            lastHostessReportedState = HostessState.WAIT_FOR_PASSENGER;
        } else if (hostessState == HostessState.CHECK_PASSENGER) {
            /* check and print flight status : PASSENGER _ CHECKED */
            if ((lastHostessReportedState == HostessState.WAIT_FOR_PASSENGER) || (lastHostessReportedState == HostessState.WAIT_FOR_FLIGHT)) {
                log.writelnString("\n Flight " + flight + ": passenger " + currentPassenger + " checked.");
                inQ--;
            }
            lineStatus += " CKPS ";
            lastHostessReportedState = HostessState.CHECK_PASSENGER;
        } else if (hostessState == HostessState.READY_TO_FLY) {
            /* check and print flight status : DEPARTED WITH _ PASSENGERS */
            if (lastHostessReportedState == HostessState.WAIT_FOR_PASSENGER) {
                log.writelnString("\n Flight " + flight + ": departed with " + inF + " passengers.");
            }
            lineStatus += " RDTF ";
            lastHostessReportedState = HostessState.READY_TO_FLY;
        }

        /* check passenger state */
        for (int i = 0; i < SimulationParameters.TTL_PASSENGER; i++) {
            if (passengerState[i] == PassengerState.GOING_TO_AIRPORT) {
                lineStatus += " GTAP ";
                lastPassengerReportedState[i] = PassengerState.GOING_TO_AIRPORT;
            } else if (passengerState[i] == PassengerState.IN_QUEUE) {
                if (lastPassengerReportedState[i] == PassengerState.GOING_TO_AIRPORT) {
                    inQ++;
                }
                lineStatus += " INQE ";
                lastPassengerReportedState[i] = PassengerState.IN_QUEUE;
            } else if (passengerState[i] == PassengerState.IN_FLIGHT) {
                if (lastPassengerReportedState[i] == PassengerState.IN_QUEUE) {
                    inF++;
                }
                lineStatus += " INFL ";
                lastPassengerReportedState[i] = PassengerState.IN_FLIGHT;
            } else if (passengerState[i] == PassengerState.AT_DESTINATION) {
                if (lastPassengerReportedState[i] == PassengerState.IN_FLIGHT) {
                    inF--;
                    pTAL++;
                }
                lineStatus += " ATDS ";
                lastPassengerReportedState[i] = PassengerState.AT_DESTINATION;
            }
        }

        lineStatus += String.format(" %3d   %3d  %3d", inQ, inF, pTAL);
        log.writelnString(lineStatus);

        if (!log.close()) {
            GenericIO.writelnString("The operation of closing the file " + logFileName + " failed!");
            System.exit(1);
        }
    }

    /**
     * Write the footer to the logging file.
     *
     * Internal operation.
     */
    @Override
    public void reportFinalStatus() throws RemoteException  {
        TextFile log = new TextFile();

        if (!log.openForAppending(".", logFileName)) {
            GenericIO.writelnString("The operation of opening for appending the file " + logFileName + " failed!");
            System.exit(1);
        }

        /* final status */
        log.writelnString("\n AirLift sum up:");
        for (int i = 0; i < numOfFlight; i++) {
            if (i == numOfFlight - 1) {
                log.writelnString(" Flight " + voos[i].split("-")[0] + " transported " + voos[i].split("-")[1] + " passengers.");
            } else {
                log.writelnString(" Flight " + voos[i].split("-")[0] + " transported " + voos[i].split("-")[1] + " passengers");
            }
        }

        if (!log.close()) {
            GenericIO.writelnString("The operation of closing the file " + logFileName + " failed!");
            System.exit(1);
        }
        MainProgram.serviceEnd = true;
    }

    /**
     * Terminates the logger service.
     */
    @Override
    public synchronized void serviceEnd() throws RemoteException  {
        MainProgram.serviceEnd = true;
        notifyAll();
    }
}
