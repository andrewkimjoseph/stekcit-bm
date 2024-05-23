// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {VRFV2WrapperConsumerBase} from "@chainlink/contracts@1.1.0/src/v0.8/vrf/VRFV2WrapperConsumerBase.sol";
import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/FunctionsClient.sol";
import {FunctionsRequest} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/libraries/FunctionsRequest.sol";

import {ERC20} from "./StekcitBMInterfaces.sol";
import {StekcitBMUser} from "./StekcitBMUser.sol";
import {StekcitBMEvent} from "./StekcitBMEvent.sol";
import {StekcitBMTicket} from "./StekcitBMTicket.sol";
import {StekcitBMPayout} from "./StekcitBMPayout.sol";

import {StekcitEvent, StekcitTicket, StekcitUser} from "./StekcitBMStructs.sol";

contract StekcitBM is FunctionsClient, VRFV2WrapperConsumerBase {
    using FunctionsRequest for FunctionsRequest.Request;

    address public stekcitBMOwnerAddress;
    ERC20 cUSD;

    StekcitBMUser private stekcitBMUserContract;
    StekcitBMEvent private stekcitBMEventContract;
    StekcitBMTicket private stekcitBMTicketContract;
    StekcitBMPayout private stekcitBMPayoutContract;

    bytes public lastFunctionsError;

    address linkAddress = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;

    // Chainlink VRF - Wrapper address for Avalanche Fuji
    address wrapperAddress = 0x9345AC54dA4D0B5Cda8CB749d8ef37e5F02BBb21;

    // Chainlink Functions - Router address for Avalanche Fuji
    address router = 0xA9d587a00A31A52Ed70D6026794a8FC5E2F5dCb0;

    constructor(
        address _stekcitBMOwnerAddress,
        address _cUSDAddress,
        address _stekcitBMUserContract,
        address _stekcitBMEventContract,
        address _stekcitBMTicketContract,
        address _stekcitBMPayoutContract
    )
        VRFV2WrapperConsumerBase(linkAddress, wrapperAddress)
        FunctionsClient(router)
    {
        stekcitBMOwnerAddress = _stekcitBMOwnerAddress;
        cUSD = ERC20(_cUSDAddress);
        stekcitBMUserContract = StekcitBMUser(_stekcitBMUserContract);
        stekcitBMEventContract = StekcitBMEvent(_stekcitBMEventContract);
        stekcitBMTicketContract = StekcitBMTicket(_stekcitBMTicketContract);
        stekcitBMPayoutContract = StekcitBMPayout(_stekcitBMPayoutContract);
    }

    function createUser(string memory _username, string memory _emailAddress)
        public
    {
        stekcitBMUserContract.createUser(_username, _emailAddress, msg.sender);
    }

    function createEvent(
        string memory _title,
        string memory _description,
        string memory _link,
        uint256 _amount,
        uint256 _dateAndTime,
        bool _forImmediatePublishing
    ) public {
        stekcitBMEventContract.createEvent(
            _title,
            _description,
            _link,
            _amount,
            _dateAndTime,
            _forImmediatePublishing,
            msg.sender
        );
    }

    function createTicketForUser(uint256 _eventId) public {
        stekcitBMTicketContract.createTicketForUser(_eventId, msg.sender);
    }

    function processPayout(uint256 _eventId) public {
        stekcitBMPayoutContract.processPayout(
            _eventId,
            msg.sender,
            cUSD,
            stekcitBMOwnerAddress
        );
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
    ) private view returns (bool) {
        StekcitUser memory userToBeUpdated = stekcitBMUserContract.getUserById(
            _userId
        );

        if (!userToBeUpdated.isBlank) {
            uint256 userId = userToBeUpdated.id;
            userToBeUpdated.isWelcomeEmailSent = _isWelcomeEmailSent;
            userToBeUpdated
                .welcomeEmailVerificationId = _welcomeEmailVerificationId;

            stekcitBMUserContract.getAllUsers()[userId] = userToBeUpdated;
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

    function setVerificationRequestIdForEvent(
        uint256 _eventId,
        uint256 _verificationRequestId 
    ) private view returns (StekcitEvent memory) {
        StekcitEvent memory updatedEvent = stekcitBMEventContract.getEventById(
            _eventId
        );

        uint256 verificationAmount = updatedEvent.amountInEthers / 10;

        updatedEvent.isVerified = true;
        updatedEvent.updatedAt = block.timestamp;
        updatedEvent.verificationAmountInEthers = verificationAmount;
        updatedEvent.verificationRequestId = _verificationRequestId;

        stekcitBMEventContract.getAllEvents()[_eventId] = updatedEvent;

        return updatedEvent;
    }

    function setVerificationIdForEvent(
        uint256 _eventId,
        uint256 _verificationId
    ) private view returns (StekcitEvent memory) {
        StekcitEvent memory updatedEvent = stekcitBMEventContract.getEventById(
            _eventId
        );

        updatedEvent.updatedAt = block.timestamp;
        updatedEvent.verificationId = _verificationId;

        stekcitBMEventContract.getAllEvents()[_eventId] = updatedEvent;

        return updatedEvent;
    }

    function verifyEventAndSetVerificationRequestId(uint256 _eventId)
        public
        returns (StekcitEvent memory)
    {
        uint256 eventVerificationId = requestRandomness(100000, 1, 1);
        return setVerificationRequestIdForEvent(_eventId, eventVerificationId);
    }

    function verifyTicketAndSetVerificationRequestId(uint256 _ticketId)
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
    ) internal view override {
        // Block for verifying events
        StekcitEvent memory updatedEvent = stekcitBMEventContract
            .getEventByVerificationId(_requestId);

        if (!updatedEvent.isBlank) {
            setVerificationIdForEvent(updatedEvent.id, _randomWords[0]);
        }

        // Block for verifying tickets
        StekcitTicket memory updatedTicket = stekcitBMTicketContract
            .getTicketByVerificationRequestId(_requestId);

        if (!updatedTicket.isBlank) {
            setVerificationIdForTicket(updatedTicket.id, _randomWords[0]);
        }
    }

    function setVerificationRequestIdForTicket(
        uint256 _ticketId,
        uint256 _verificationRequestId
    ) private view returns (StekcitTicket memory) {
        StekcitTicket memory updatedTicket = stekcitBMTicketContract
            .getAllTickets()[_ticketId];

        updatedTicket.verificationRequestId = _verificationRequestId;

        stekcitBMTicketContract.getAllTickets()[_ticketId] = updatedTicket;

        return updatedTicket;
    }

    function setVerificationIdForTicket(
        uint256 _ticketId,
        uint256 _verificationId
    ) private view returns (StekcitTicket memory) {
        StekcitTicket memory updatedTicket = stekcitBMTicketContract
            .getAllTickets()[_ticketId];

        updatedTicket.verificationId = _verificationId;

        stekcitBMTicketContract.getAllTickets()[_ticketId] = updatedTicket;

        return updatedTicket;
    }
}
