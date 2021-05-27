package DepartureAirport;

import EntitiesState.HostessState;
import EntitiesState.PassengerState;
import EntitiesState.PilotState;
import Interfaces.DepartureAirportInt;
import Interfaces.GeneralReposInt;
import commInfra.MemException;
import commInfra.MemFIFO;
import genclass.GenericIO;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.rmi.RemoteException;

/**
 * Where passengers arrive and start flying.
 */
public class DepartureAirport implements DepartureAirportInt{

    /**
     * GeneralRepos class for debugging.
     */
    private final GeneralReposInt repos;

    /* initial configurations */
    private MemFIFO<Integer> passengers;
    private int MAX_PASSENGER;
    private int MIN_PASSENGER;
    private int TTL_PASSENGER;
    private int numberOfPassengerOnThePlane;
    private int numberOfAttendedPassengers;
    private int numberOfFilght;
    private int currentPassenger;
    private boolean passengerShowingDocuments;
    private boolean hostessAsksPassengerForDocuments;
    private boolean hostessInformPlaneReadyToTakeOff;
    private static boolean hostessInformPilotToEndActivity;
    private boolean pilotInformPlaneReadyForBoarding;
    private String hostessState;

    /**
     * Departure Airport instantiation.
     *
     * @param min minimum number of passengers per flight
     * @param max maximum number of passengers per flight
     * @param total total number of passengers per flight
     * @param repos reference to the general repository
     */
    public DepartureAirport(int min, int max, int total, GeneralReposInt repos) {
        try {
            passengers = new MemFIFO<>(new Integer[total + 1]);
        } catch (MemException ex) {
            Logger.getLogger(DepartureAirport.class.getName()).log(Level.SEVERE, null, ex);
        }
        this.MIN_PASSENGER = min;
        this.MAX_PASSENGER = max;
        this.TTL_PASSENGER = total;
        numberOfPassengerOnThePlane = 0;
        numberOfAttendedPassengers = 0;
        numberOfFilght = 0;
        currentPassenger = 0;
        passengerShowingDocuments = false;
        hostessAsksPassengerForDocuments = false;
        hostessInformPlaneReadyToTakeOff = false;
        hostessInformPilotToEndActivity = false;
        pilotInformPlaneReadyForBoarding = false;
        this.repos = repos;
        hostessState = HostessState.WAIT_FOR_FLIGHT.toString();
    }

    /**
     * DepartureAiport class constructor.
     *
     * @param repos
     */
    public DepartureAirport(GeneralReposInt repos) {
        this.repos = repos;
    }

    /* ******************************* HOSTESS ****************************** */
    /**
     * The hostess waits for the next flight to be ready for boarding. It is
     * called by a hostess.
     */
    @Override
    public synchronized void waitForNextFlight() throws RemoteException {
        /* change state of hostess to WTFL */
        if (hostessState.equals("RDTF")) {
            repos.updateHostessState(HostessState.WAIT_FOR_FLIGHT, currentPassenger);
            hostessState = "WTFL";
        }

        /* wait for the pilot to notify that he is ready to board */
        while (!pilotInformPlaneReadyForBoarding) {
            GenericIO.writelnString("(01) Hostess is waiting for the next flight to be ready to be boarded");
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * The hostess waits for the next passenger in the queue. When there is a
     * passenger, the hostess removes him from the queue and starts the check
     * in. It is called by a hostess.
     */
    @Override
    public synchronized void waitForNextPassenger() throws RemoteException {
        /* waiting for passengers */
        notifyAll();

        while (passengers.empty()) {
            GenericIO.writelnString("(02) Hostess is waiting for passengers");

            /* change state of hostess to WTPS */
            repos.updateHostessState(HostessState.WAIT_FOR_PASSENGER, currentPassenger);
            hostessState = "WTPS";

            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        try {
            currentPassenger = passengers.read();
        } catch (MemException ex) {
            Logger.getLogger(DepartureAirport.class.getName()).log(Level.SEVERE, null, ex);
        }
        notifyAll();
        GenericIO.writelnString("(03) Hostess accepted a passenger for check in");
    }

    /**
     * The hostess asks the passenger for the documents and waits for him to
     * deliver them. When the passenger shows the documents, the hostess accepts
     * and adds them to the flight. It is called by a hostess.
     */
    @Override
    public synchronized void checkDocuments() throws RemoteException {
        /* change state of hostess to CKPS */
        repos.updateHostessState(HostessState.CHECK_PASSENGER, currentPassenger);
        hostessState = "CKPS";

        /* ask for documents from the passenger */
        GenericIO.writelnString("(04) Hostess asked passenger for documents");
        hostessAsksPassengerForDocuments = true;
        notifyAll();

        /* wait for the passenger to show the documents */
        while (!passengerShowingDocuments) {
            GenericIO.writelnString("(05) Hostess is waiting for passenger to give documents");
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        passengerShowingDocuments = false;
        GenericIO.writelnString("(06) Hostess received and accepted documents");
        numberOfPassengerOnThePlane++;
        numberOfAttendedPassengers++;

        /* change state of hostess to WTPS */
        repos.updateHostessState(HostessState.WAIT_FOR_PASSENGER, currentPassenger);
    }

    /**
     * The hostess informs the pilot that the plane is ready to take off. When:
     * There are no more passengers in the queue and the plane already has the
     * minimum number of passengers for boarding; The number of passengers on
     * the plane has already reached its maximum; There are no more passengers
     * in the queue (because they are the last) and they are all already checked
     * in. It is called by a hostess.
     */
    @Override
    public synchronized void informPlaneReadyToTakeOff() throws RemoteException {
        /* check if the flight has the conditions to take off */
        if ((passengers.empty() && numberOfPassengerOnThePlane > MIN_PASSENGER) || numberOfPassengerOnThePlane == MAX_PASSENGER || (passengers.empty() && (numberOfAttendedPassengers == TTL_PASSENGER))) {
            hostessInformPlaneReadyToTakeOff = true;
            if (numberOfAttendedPassengers == TTL_PASSENGER) {
                hostessInformPilotToEndActivity = true;
                GenericIO.writelnString("(07) Hostess informs pilot that he can end activity");
            }
            notifyAll();
            GenericIO.writelnString("(08) Hostess informs plane is ready to fly");

            /* change state of hostess to RDTF */
            repos.updateHostessState(HostessState.READY_TO_FLY, currentPassenger);
            hostessState = "RDTF";

            /* wait for the pilot to report that he is ready to board */
            while (pilotInformPlaneReadyForBoarding) {
                try {
                    wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            numberOfPassengerOnThePlane = 0;
            hostessInformPlaneReadyToTakeOff = false;
        }
    }

    /* ****************************** PASSENGER ***************************** */
    /**
     * The passenger goes to the airport.It is called by a passenger.
     *
     * @param id passenger id
     */
    @Override
    public synchronized void travelToAirport(int id) throws RemoteException {
        /* going to airport */ 
        try {
            passengers.write(id);
        } catch (MemException ex) {
            Logger.getLogger(DepartureAirport.class.getName()).log(Level.SEVERE, null, ex);
        }
        GenericIO.writelnString("(09) Passenger " + id + " go to airport");
    }

    /**
     * The passenger waits in line for the check in.It is called by a passenger.
     *
     * @param id passenger id
     */
    @Override
    public synchronized void waitInQueue(int id) throws RemoteException {
        /* change state of passenger to INQE */
        repos.updatePassengerState(PassengerState.IN_QUEUE, id);
        notifyAll();

        /* wait in line until the hostess starts checking in */
        GenericIO.writelnString("(10) Passenger " + id + " is waiting in queue");
        while (passengers.contains(id)) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * The passenger is asked to show his documents and he shows them to the
     * hostess. It is called by a passenger.
     */
    @Override
    public synchronized void showDocuments() throws RemoteException {
        /* wait for the hostess to ask you for the documents */
        GenericIO.writelnString("(11) Passenger is being asked for documents");
        while (!hostessAsksPassengerForDocuments) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        passengerShowingDocuments = true;
        GenericIO.writelnString("(12) Passenger showed documents");
        notifyAll();
    }

    /* ******************************** PILOT ******************************* */
    /**
     * The pilot informs the plane that he is ready to board.
     *
     * It is called by a pilot.
     */
    @Override
    public synchronized void informPlaneReadyForBoarding() throws RemoteException {
        /* increment flight */
        numberOfFilght++;

        /* change state of pilot to RDFB */
        repos.updatePilotState(PilotState.READY_FOR_BOARDING);

        /* wait for the hostess to notify you that the plane is ready to take off */
        GenericIO.writelnString("(13) Pilot informed plane is ready to be boarded");
        pilotInformPlaneReadyForBoarding = true;
        notifyAll();
    }

    /**
     * The pilot waits for the passengers to be on the plane and then is ready
     * to fly. It is called by a pilot.
     */
    @Override
    public synchronized void waitForAllInBoard() throws RemoteException {
        /* change state of pilot to WTFB */
        repos.updatePilotState(PilotState.WAITING_FOR_BOARDING);

        /* wait for the hostess to notify you that the plane is ready to take off */
        GenericIO.writelnString("(14) Pilot is waiting for the boarding to be finished");
        while (!hostessInformPlaneReadyToTakeOff) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        pilotInformPlaneReadyForBoarding = false;
        notifyAll();
        GenericIO.writelnString("(15) Boarding is finished and pilot is going to fly");

        /* set information of flight */
        repos.updateInfoBoardPlane(numberOfFilght, numberOfPassengerOnThePlane);
        GenericIO.writelnString("FLIGHT " + numberOfFilght + " with " + numberOfPassengerOnThePlane + " passengers");

        /* travel time (added so that you can see other passengers arriving at the airport during the flight) */
        try {
            Thread.sleep(1500);
        } catch (InterruptedException ex) {
            Logger.getLogger(DepartureAirport.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * The pilot stops his activity when the hostess tells him to. It is called
     * by a pilot.
     *
     * @return the value of the hostessInformPilotToEndActivity variable
     */
    @Override
    public synchronized boolean informPilotToEndActivity() throws RemoteException {
        if (hostessInformPilotToEndActivity) {
            repos.reportFinalStatus();
            MainProgram.serviceEnd = true;
        }
        return hostessInformPilotToEndActivity;
    }

    /**
     * Terminate the departure airport service.
     */
    @Override
    public synchronized void serviceEnd() throws RemoteException {
        MainProgram.serviceEnd = true;
        repos.serviceEnd();
    }
}
