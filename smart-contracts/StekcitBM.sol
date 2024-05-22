// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {VRFV2WrapperConsumerBase} from "@chainlink/contracts@1.1.0/src/v0.8/vrf/VRFV2WrapperConsumerBase.sol";
import {LinkTokenInterface} from "@chainlink/contracts@1.1.0/src/v0.8/shared/interfaces/LinkTokenInterface.sol";
import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/FunctionsClient.sol";
import {FunctionsRequest} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/libraries/FunctionsRequest.sol";

import {StekcitUser, StekcitEvent, StekcitTicket, StekcitPayout, StekcitFunctionsError} from "./StekcitBMStructs.sol";

import {ERC20} from "./StekcitBMInterfaces.sol";

contract StekcitBM is FunctionsClient, VRFV2WrapperConsumerBase {
    using FunctionsRequest for FunctionsRequest.Request;

    StekcitUser[] private allStekcitUsers;
    StekcitEvent[] private allStekcitEvents;
    StekcitTicket[] private allStekcitTickets;
    StekcitPayout[] private allStekcitPayouts;
    StekcitFunctionsError[] public allStekcitFunctionsErrors;

    address public stekcitBMOwnerAddress;

    bytes public lastFunctionsError;

    uint256 private currentUserId;
    uint256 private currentEventId;
    uint256 private currentTicketId;
    uint256 private currentPayoutId;
    uint256 private currentFunctionsErrorId;

    ERC20 cUSD = ERC20(0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1);

    // LINK on Fuji
    address linkAddress = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;

    // Chainlink VRF - Wrapper address for Avalanche Fuji
    address wrapperAddress = 0x9345AC54dA4D0B5Cda8CB749d8ef37e5F02BBb21;

    // Chainlink Functions - Router address for Avalanche Fuji
    address router = 0xA9d587a00A31A52Ed70D6026794a8FC5E2F5dCb0;

    constructor(address _stekcitBMOwnerAddress)
        VRFV2WrapperConsumerBase(linkAddress, wrapperAddress)
        FunctionsClient(router)
    {
        stekcitBMOwnerAddress = _stekcitBMOwnerAddress;
    }

    // modifier onlyCreatingUserOfEvent(uint256 _eventId) {
    //     require(
    //         checkIfUserisCreatingUserOfEvent(_eventId, msg.sender),
    //         "Only a creating user of event can perform this action."
    //     );
    //     _;
    // }

    // modifier onlyCreatingUser(address _walletAddress) {
    //     StekcitUser memory checkingUser = getUserByWalletAddress(
    //         _walletAddress
    //     );
    //     require(
    //         checkingUser.isCreatingUser,
    //         "Only a creating user can perform this action."
    //     );
    //     _;
    // }

    // modifier onlyExistingUser() {
    //     require(
    //         checkIfUserExists(msg.sender),
    //         "Only existing users can perform this action."
    //     );
    //     _;
    // }

    // function checkIfUserExists(address _walletAddress)
    //     public
    //     view
    //     returns (bool)
    // {
    //     for (uint256 userId = 0; userId < allStekcitUsers.length; userId++) {
    //         StekcitUser memory currentUser = allStekcitUsers[userId];
    //         if (
    //             currentUser.walletAddress == _walletAddress &&
    //             !currentUser.isBlank
    //         ) {
    //             return true;
    //         }
    //     }

    //     return false;
    // }

    // function checkIfUserisCreatingUserOfEvent(
    //     uint256 _eventId,
    //     address _walletAddress
    // ) public view returns (bool) {
    //     StekcitEvent memory eventToCheck = allStekcitEvents[_eventId];

    //     if (eventToCheck.creatingUserWalletAddress == _walletAddress) {
    //         return true;
    //     }

    //     return false;
    // }

    function createUser(string memory _username, string memory _emailAddress)
        public
        returns (StekcitUser memory)
    {
        // bool userExists = checkIfUserExists(msg.sender);

        // if (userExists) {
        //     return getUserByWalletAddress(msg.sender);
        // }

        uint256 newUserId = currentUserId;

        allStekcitUsers.push(
            StekcitUser(
                newUserId,
                msg.sender,
                _username,
                _emailAddress,
                false,
                false,
                false,
                ""
            )
        );

        currentUserId++;

        StekcitUser memory newUser = getUserByUserId(newUserId);

        return newUser;
    }

    function getUserByWalletAddress(address _walletAddress)
        public
        view
        returns (StekcitUser memory)
    {
        for (uint256 userId = 0; userId < allStekcitUsers.length; userId++) {
            StekcitUser memory currentUser = allStekcitUsers[userId];
            if (currentUser.walletAddress == _walletAddress) {
                return currentUser;
            }
        }
        StekcitUser memory blankUser;
        blankUser.isBlank = true;
        return blankUser;
    }

    function getUserByUserId(uint256 _userId)
        public
        view
        returns (StekcitUser memory)
    {
        for (uint256 userId = 0; userId < allStekcitUsers.length; userId++) {
            StekcitUser memory currentUser = allStekcitUsers[userId];
            if (currentUser.id == _userId) {
                return currentUser;
            }
        }
        StekcitUser memory blankUser;
        blankUser.isBlank = true;
        return blankUser;
    }

    function getTotalNumberOfAllEventsCreatedByUser(address _walletAddress)
        public
        view
        returns (uint256)
    {
        uint256 numberOfEventsCreatedByUser = 0;

        for (
            uint256 eventId = 0;
            eventId < allStekcitEvents.length;
            eventId++
        ) {
            StekcitEvent memory currentEvent = allStekcitEvents[eventId];
            if (currentEvent.creatingUserWalletAddress == _walletAddress) {
                numberOfEventsCreatedByUser++;
            }
        }

        return numberOfEventsCreatedByUser;
    }

    function getNumberOfTicketsOfUser(address _walletAddress)
        public
        view
        returns (uint256)
    {
        uint256 numberOfTicketsOfUser = 0;

        for (
            uint256 ticketId = 0;
            ticketId < allStekcitTickets.length;
            ticketId++
        ) {
            StekcitTicket memory currentTicket = allStekcitTickets[ticketId];
            if (currentTicket.attendingUserWalletAddress == _walletAddress) {
                numberOfTicketsOfUser++;
            }
        }

        return numberOfTicketsOfUser;
    }

    function getNumberOfTicketsOfEvent(uint256 _eventId)
        public
        view
        returns (uint256)
    {
        uint256 numberOfTicketsOfEvent = 0;

        for (
            uint256 ticketId = 0;
            ticketId < allStekcitTickets.length;
            ticketId++
        ) {
            StekcitTicket memory currentTicket = allStekcitTickets[ticketId];
            if (currentTicket.eventId == _eventId) {
                numberOfTicketsOfEvent++;
            }
        }

        return numberOfTicketsOfEvent;
    }

    function getAllEventsCreatedByUser(address _walletAddress)
        public
        view
        returns (StekcitEvent[] memory)
    {
        StekcitEvent[] memory eventsOfCreatingUser = new StekcitEvent[](
            getTotalNumberOfAllEventsCreatedByUser(_walletAddress)
        );

        for (
            uint256 eventId = 0;
            eventId < allStekcitEvents.length;
            eventId++
        ) {
            StekcitEvent memory currentEvent = allStekcitEvents[eventId];
            if (currentEvent.creatingUserWalletAddress == _walletAddress) {
                eventsOfCreatingUser[eventId] = currentEvent;
            }
        }

        return eventsOfCreatingUser;
    }

    function getTotalNumberOfTicketsOfEvent(uint256 _eventId)
        public
        view
        returns (uint256)
    {
        uint256 numberOfTicketsOfEvents = 0;

        for (
            uint256 ticketId = 0;
            ticketId < allStekcitTickets.length;
            ticketId++
        ) {
            StekcitTicket memory currentTicket = allStekcitTickets[ticketId];
            if (currentTicket.eventId == _eventId) {
                numberOfTicketsOfEvents++;
            }
        }

        return numberOfTicketsOfEvents;
    }

    function getAllTicketsOfEvent(uint256 _eventId)
        public
        view
        returns (StekcitTicket[] memory)
    {
        uint256 runningTicketId = 0;

        uint256 totalNumberOfTicketsOfEvent = getNumberOfTicketsOfEvent(
            _eventId
        );

        StekcitTicket[] memory allTicketsOfEvent = new StekcitTicket[](
            totalNumberOfTicketsOfEvent
        );

        for (
            uint256 ticketId = 0;
            ticketId < totalNumberOfTicketsOfEvent;
            ticketId++
        ) {
            StekcitTicket memory currentTicket = allStekcitTickets[ticketId];

            if (currentTicket.eventId == _eventId) {
                allTicketsOfEvent[runningTicketId] = currentTicket;
                runningTicketId++;
            }
        }

        return allTicketsOfEvent;
    }

    function getNumberOfAllPublishedEvents() public view returns (uint256) {
        uint256 numberOfPublishedEvents = 0;

        for (
            uint256 eventId = 0;
            eventId < allStekcitEvents.length;
            eventId++
        ) {
            StekcitEvent memory currentEvent = allStekcitEvents[eventId];
            if (currentEvent.isPublished) {
                numberOfPublishedEvents++;
            }
        }

        return numberOfPublishedEvents;
    }

    function getAllPublishedEvents()
        public
        view
        returns (StekcitEvent[] memory)
    {
        uint256 runningEventId = 0;
        StekcitEvent[] memory publishedEvents = new StekcitEvent[](
            getNumberOfAllPublishedEvents()
        );

        for (
            uint256 eventId = 0;
            eventId < allStekcitEvents.length;
            eventId++
        ) {
            StekcitEvent memory currentEvent = allStekcitEvents[eventId];
            if (currentEvent.isPublished) {
                publishedEvents[runningEventId] = currentEvent;
                runningEventId++;
            }
        }

        return publishedEvents;
    }

    function getAllTicketsOfUser(address _walletAddress)
        public
        view
        returns (StekcitTicket[] memory)
    {
        uint256 runningTicketId = 0;
        StekcitTicket[] memory allTicketsOfUser = new StekcitTicket[](
            getNumberOfTicketsOfUser(_walletAddress)
        );

        for (
            uint256 ticketId = 0;
            ticketId < allStekcitTickets.length;
            ticketId++
        ) {
            StekcitTicket memory currentTicket = allStekcitTickets[ticketId];
            if (currentTicket.attendingUserWalletAddress == _walletAddress) {
                allTicketsOfUser[runningTicketId] = currentTicket;
                runningTicketId++;
            }
        }

        return allTicketsOfUser;
    }

    function makeCreatingUser()
        public
        returns (
            // onlyExistingUser
            bool
        )
    {
        StekcitUser memory userToBeUpdated = getUserByWalletAddress(msg.sender);

        if (!userToBeUpdated.isBlank) {
            uint256 userId = userToBeUpdated.id;
            userToBeUpdated.isCreatingUser = true;
            allStekcitUsers[userId] = userToBeUpdated;
            return true;
        }
        return false;
    }

    function getEventById(uint256 _eventId)
        public
        view
        returns (StekcitEvent memory)
    {
        for (
            uint256 eventId = 0;
            eventId < allStekcitEvents.length;
            eventId++
        ) {
            StekcitEvent memory currentEvent = allStekcitEvents[eventId];
            if (currentEvent.id == _eventId) {
                return currentEvent;
            }
        }

        StekcitEvent memory blankEvent;
        blankEvent.isBlank = true;
        return blankEvent;
    }

    function getEventByVerificationRequestId(uint256 _verificationRequestId)
        public
        view
        returns (StekcitEvent memory)
    {
        for (
            uint256 eventId = 0;
            eventId < allStekcitEvents.length;
            eventId++
        ) {
            StekcitEvent memory currentEvent = allStekcitEvents[eventId];
            if (currentEvent.verificationRequestId == _verificationRequestId) {
                return currentEvent;
            }
        }

        StekcitEvent memory blankEvent;
        blankEvent.isBlank = true;
        return blankEvent;
    }

    function createEvent(
        string memory _title,
        string memory _description,
        string memory _link,
        uint256 _amount,
        uint256 _dateAndTime,
        bool _forImmediatePublishing
    )
        public
        returns (
            // onlyExistingUser
            // onlyCreatingUser(msg.sender)
            StekcitEvent memory
        )
    {
        uint256 newEventId = currentEventId;
        uint256 createdAt = block.timestamp;
        uint256 updatedAt = block.timestamp;
        uint256 amountInEthers = _amount * (10**cUSD.decimals());

        allStekcitEvents.push(
            StekcitEvent(
                newEventId,
                msg.sender,
                _title,
                _description,
                _link,
                amountInEthers,
                createdAt,
                updatedAt,
                _dateAndTime,
                false,
                _forImmediatePublishing,
                false,
                0,
                false,
                false,
                0,
                0
            )
        );

        currentEventId++;

        return getEventById(newEventId);
    }

    function getTicketById(uint256 _ticketId)
        public
        view
        returns (StekcitTicket memory)
    {
        return allStekcitTickets[_ticketId];
    }

    function getEventAttendees(uint256 _eventId)
        public
        view
        returns (StekcitUser[] memory)
    {
        uint256 runningUserId = 0;

        StekcitUser[] memory eventAttendees = new StekcitUser[](
            getTotalNumberOfTicketsOfEvent(_eventId)
        );

        for (
            uint256 ticketId = 0;
            ticketId < allStekcitTickets.length;
            ticketId++
        ) {
            StekcitTicket memory currentTicket = allStekcitTickets[ticketId];

            if (currentTicket.eventId == _eventId) {
                StekcitUser memory currentUser = getUserByWalletAddress(
                    currentTicket.attendingUserWalletAddress
                );
                eventAttendees[runningUserId] = currentUser;
                runningUserId++;
            }
        }

        return eventAttendees;
    }

    function checkIfTicketOfUserForThisEventExists(uint256 _eventId)
        public
        view
        returns (bool)
    {
        for (
            uint256 ticketId = 0;
            ticketId < allStekcitTickets.length;
            ticketId++
        ) {
            StekcitTicket memory currentTicket = allStekcitTickets[ticketId];
            if (
                currentTicket.eventId == _eventId &&
                currentTicket.attendingUserWalletAddress == msg.sender
            ) {
                return true;
            }
        }
        return false;
    }

    function getTicketByEventIdAndWalletAddress(
        uint256 _eventId,
        address _walletAddress
    ) public view returns (StekcitTicket memory) {
        for (
            uint256 ticketId = 0;
            ticketId < allStekcitTickets.length;
            ticketId++
        ) {
            StekcitTicket memory currentTicket = allStekcitTickets[ticketId];
            if (
                currentTicket.eventId == _eventId &&
                currentTicket.attendingUserWalletAddress == _walletAddress
            ) {
                return currentTicket;
            }
        }

        StekcitTicket memory blankTicket;
        blankTicket.isBlank = true;
        return blankTicket;
    }

    function setVerificationRequestIdForTicket(
        uint256 _ticketId,
        uint256 _verificationRequestId
    ) private returns (StekcitTicket memory) {
        StekcitTicket memory updatedTicket = getTicketById(_ticketId);

        updatedTicket.verificationRequestId = _verificationRequestId;

        allStekcitTickets[_ticketId] = updatedTicket;

        return updatedTicket;
    }

    function setVerificationIdForTicket(
        uint256 _ticketId,
        uint256 _verificationId
    ) private returns (StekcitTicket memory) {
        StekcitTicket memory updatedTicket = getTicketById(_ticketId);

        updatedTicket.verificationId = _verificationId;

        allStekcitTickets[_ticketId] = updatedTicket;

        return updatedTicket;
    }

    function getTicketByVerificationRequestId(uint256 _verificationRequestId)
        public
        view
        returns (StekcitTicket memory)
    {
        for (
            uint256 ticketId = 0;
            ticketId < allStekcitTickets.length;
            ticketId++
        ) {
            StekcitTicket memory currentTicket = allStekcitTickets[ticketId];
            if (currentTicket.verificationRequestId == _verificationRequestId) {
                return currentTicket;
            }
        }

        StekcitTicket memory blankTicket;
        blankTicket.isBlank = true;
        return blankTicket;
    }

    function createTicketForUser(uint256 _eventId)
        public
        returns (
            // onlyExistingUser
            StekcitTicket memory
        )
    {
        StekcitEvent memory currentEvent = allStekcitEvents[_eventId];

        bool ticketOfUserForThisEventExists = checkIfTicketOfUserForThisEventExists(
                _eventId
            );

        if (ticketOfUserForThisEventExists) {
            return getTicketByEventIdAndWalletAddress(_eventId, msg.sender);
        }

        uint256 newTicketId = currentTicketId;

        allStekcitTickets.push(
            StekcitTicket(
                newTicketId,
                _eventId,
                msg.sender,
                currentEvent.amountInEthers,
                false,
                0,
                0
            )
        );

        currentTicketId++;

        return getTicketById(newTicketId);
    }

    function checkIfUserAlreadyHasTicket(
        uint256 _eventId,
        address _walletAddress
    ) public view returns (bool) {
        StekcitTicket[] memory userTickets = getAllTicketsOfUser(
            _walletAddress
        );
        for (uint256 ticketId = 0; ticketId < userTickets.length; ticketId++) {
            StekcitTicket memory currentTicket = userTickets[ticketId];
            if (currentTicket.eventId == _eventId) {
                return true;
            }
        }

        return false;
    }

    function checkIfEventIsAlreadyPaidOut(uint256 _eventId)
        public
        view
        returns (
            // onlyCreatingUserOfEvent(_eventId)
            bool
        )
    {
        for (
            uint256 payoutId = 0;
            payoutId < allStekcitPayouts.length;
            payoutId++
        ) {
            StekcitPayout memory currentPayout = allStekcitPayouts[payoutId];

            if (currentPayout.eventId == _eventId) {
                return true;
            }
        }

        return false;
    }

    function processPayout(uint256 _eventId)
        public
        returns (
            // onlyCreatingUserOfEvent(_eventId)
            StekcitPayout memory
        )
    {
        // Check if event has already been paid out (if payout exists)
        StekcitEvent memory eventToBePaidOut = allStekcitEvents[_eventId];

        bool eventIsAlreadyPaidOut = checkIfEventIsAlreadyPaidOut(_eventId);

        StekcitPayout memory blankPayout;
        blankPayout.isBlank = true;

        if (eventIsAlreadyPaidOut) {
            return blankPayout;
        }

        uint256 totalAmountToBePaidOutToCreatingUser = 0; // Starting value

        // Get amount to be paid
        uint256 amountPaidToEventInEthers = getTotalAmountPaidToEventInEthers(
            _eventId
        );

        // Add it to starting value (now running value)
        totalAmountToBePaidOutToCreatingUser +=
            (amountPaidToEventInEthers * 80) /
            100;

        // Add verification amount if [StekcitEvent] was verified
        if (eventToBePaidOut.isVerified) {
            totalAmountToBePaidOutToCreatingUser += eventToBePaidOut
                .verificationAmountInEthers;
        }

        // Transfer to creating user
        bool isCreatingUserPaid = cUSD.transfer(
            eventToBePaidOut.creatingUserWalletAddress,
            totalAmountToBePaidOutToCreatingUser
        );

        if (isCreatingUserPaid) {
            uint256 amountToBePaidOutToStekcitBMOwner = (amountPaidToEventInEthers *
                    20) / 100;

            // Transfer to stekcitBMOwner

            bool isStekcitBMOwnerPaid = cUSD.transfer(
                stekcitBMOwnerAddress,
                amountToBePaidOutToStekcitBMOwner
            );

            if (isStekcitBMOwnerPaid) {
                // Mark the event as ended and as paid out
                eventToBePaidOut.isEnded = true;
                eventToBePaidOut.isPaidOut = true;
                allStekcitEvents[_eventId] = eventToBePaidOut;

                // Create new payout
                StekcitPayout memory newPayout = createPayout(
                    _eventId,
                    totalAmountToBePaidOutToCreatingUser
                );
                return newPayout;
            }
        } else {
            return blankPayout;
        }

        return blankPayout;
    }

    function createPayout(uint256 _eventId, uint256 _amount)
        private
        returns (
            // onlyCreatingUserOfEvent(_eventId)
            StekcitPayout memory
        )
    {
        uint256 newPayoutId = currentPayoutId;

        allStekcitPayouts.push(
            StekcitPayout(
                newPayoutId,
                _eventId,
                msg.sender,
                _amount,
                block.timestamp,
                false
            )
        );

        return getPayoutById(newPayoutId);
    }

    function getPayoutById(uint256 _payoutId)
        public
        view
        returns (StekcitPayout memory)
    {
        return allStekcitPayouts[_payoutId];
    }

    function getTotalAmountPaidToEventInEthers(uint256 _eventId)
        public
        view
        returns (uint256)
    {
        uint256 totalAmountInEthers = 0;

        StekcitTicket[] memory allTicketsOfEvent = getAllTicketsOfEvent(
            _eventId
        );

        for (
            uint256 ticketId = 0;
            ticketId < allTicketsOfEvent.length;
            ticketId++
        ) {
            StekcitTicket memory currentTicket = allTicketsOfEvent[ticketId];
            totalAmountInEthers += currentTicket.amountPaidInEthers;
        }

        return totalAmountInEthers;
    }

    function setVerificationRequestIdForEvent(
        uint256 _eventId,
        uint256 _verificationRequestId
    ) private returns (StekcitEvent memory) {
        StekcitEvent memory updatedEvent = getEventById(_eventId);

        uint256 verificationAmount = updatedEvent.amountInEthers / 10;

        updatedEvent.isVerified = true;
        updatedEvent.updatedAt = block.timestamp;
        updatedEvent.verificationAmountInEthers = verificationAmount;
        updatedEvent.verificationRequestId = _verificationRequestId;

        allStekcitEvents[_eventId] = updatedEvent;

        return updatedEvent;
    }

    function setVerificationIdForEvent(
        uint256 _eventId,
        uint256 _verificationId
    ) private returns (StekcitEvent memory) {
        StekcitEvent memory updatedEvent = getEventById(_eventId);

        updatedEvent.updatedAt = block.timestamp;
        updatedEvent.verificationId = _verificationId;

        allStekcitEvents[_eventId] = updatedEvent;

        return updatedEvent;
    }

    function publishEvent(uint256 _eventId)
        public
        returns (
            // onlyCreatingUserOfEvent(_eventId)
            StekcitEvent memory
        )
    {
        StekcitEvent memory eventToVerifyAndUpdate = getEventById(_eventId);

        eventToVerifyAndUpdate.isPublished = true;

        allStekcitEvents[_eventId] = eventToVerifyAndUpdate;

        return eventToVerifyAndUpdate;
    }

    // <--- CHAINLINK FUNCTIONS IMPLEMENTATION METHODS --->

    function sendRequest(
        string memory source,
        bytes memory encryptedSecretsUrls,
        uint8 donHostedSecretsSlotID,
        uint64 donHostedSecretsVersion,
        string[] memory args,
        bytes[] memory bytesArgs,
        uint64 subscriptionId,
        uint32 gasLimit,
        bytes32 donID
    ) external returns (bytes32) {
        FunctionsRequest.Request memory req;
        req.initializeRequestForInlineJavaScript(source);
        if (encryptedSecretsUrls.length > 0)
            req.addSecretsReference(encryptedSecretsUrls);
        else if (donHostedSecretsVersion > 0) {
            req.addDONHostedSecrets(
                donHostedSecretsSlotID,
                donHostedSecretsVersion
            );
        }
        if (args.length > 0) req.setArgs(args);
        if (bytesArgs.length > 0) req.setBytesArgs(bytesArgs);

        bytes32 requestId = _sendRequest(
            req.encodeCBOR(),
            subscriptionId,
            gasLimit,
            donID
        );

        return requestId;
    }

    // function sendRequestCBOR(
    //     bytes memory request,
    //     uint64 subscriptionId,
    //     uint32 gasLimit,
    //     bytes32 donID
    // ) external returns (bytes32 requestId) {
    //     return _sendRequest(request, subscriptionId, gasLimit, donID);
    // }

    // Callback for Chainlink Functions
    function fulfillRequest(
        bytes32 requestId,
        bytes memory response,
        bytes memory err
    ) internal override {
        (uint256 userId, bool isWelcomeEmailSent) = abi.decode(
            response,
            (uint256, bool)
        );

        updateWelcomeEmailVerificationId(userId, isWelcomeEmailSent, requestId);

        lastFunctionsError = err;

        // createFunctionsError(err);
    }

    function updateWelcomeEmailVerificationId(
        uint256 _userId,
        bool _isWelcomeEmailSent,
        bytes32 _welcomeEmailVerificationId
    ) private returns (bool) {
        StekcitUser memory userToBeUpdated = allStekcitUsers[_userId];

        if (!userToBeUpdated.isBlank) {
            uint256 userId = userToBeUpdated.id;
            userToBeUpdated.isWelcomeEmailSent = _isWelcomeEmailSent;
            userToBeUpdated
                .welcomeEmailVerificationId = _welcomeEmailVerificationId;

            allStekcitUsers[userId] = userToBeUpdated;
            return true;
        }
        return false;
    }

    // function createFunctionsError(bytes memory error) private {
    //     uint256 newFunctionsErrorId = currentFunctionsErrorId;

    //     allStekcitFunctionsErrors.push(
    //         StekcitFunctionsError(newFunctionsErrorId, error)
    //     );

    //     currentFunctionsErrorId++;
    // }

    // <--- CHAINLINK VRF IMPLEMENTATION METHODS --->

    // function getVerificationId() private returns (uint256) {
    //     // Param 1: gasLimit
    //     // Param 2: requestConfirmations
    //     // Param 3: numberOfWords
    //     return requestRandomness(100000, 1, 1);
    // }

    function verifyEventAndSetVerificationId(uint256 _eventId)
        public
        returns (StekcitEvent memory)
    {
        uint256 eventVerificationId = requestRandomness(100000, 1, 1);
        return setVerificationRequestIdForEvent(_eventId, eventVerificationId);
    }

    function verifyTicketAndSetVerificationId(uint256 _ticketId)
        public
        returns (StekcitTicket memory)
    {
        uint256 ticketVerificationId = requestRandomness(100000, 1, 1);
        return
            setVerificationRequestIdForTicket(_ticketId, ticketVerificationId);
    }

    // Callback for Chainlink VRF
    function fulfillRandomWords(
        uint256 _requestId,
        uint256[] memory _randomWords
    ) internal override {
        // Block for verifying events
        StekcitEvent memory updatedEvent = getEventByVerificationRequestId(
            _requestId
        );

        if (!updatedEvent.isBlank) {
            setVerificationIdForEvent(updatedEvent.id, _randomWords[0]);
        }

        // Block for verifying tickets
        StekcitTicket memory updatedTicket = getTicketByVerificationRequestId(
            _requestId
        );

        if (!updatedTicket.isBlank) {
            setVerificationIdForTicket(updatedTicket.id, _randomWords[0]);
        }
    }
}
