// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {StekcitTicket} from "./StekcitBMStructs.sol";
import {StekcitBMEvent} from "./StekcitBMEvent.sol";
import {StekcitEvent} from "./StekcitBMStructs.sol";

contract StekcitBMTicket {
    StekcitTicket[] public allStekcitTickets;
    uint256 private currentTicketId;
    StekcitBMEvent private stekcitBMEventContract;

    constructor(address _eventContractAddress) {
        stekcitBMEventContract = StekcitBMEvent(_eventContractAddress);
    }

    function createTicketForUser(
        uint256 _eventId,
        address _attendingUserWalletAddress
    ) public {
        StekcitEvent memory currentEvent = stekcitBMEventContract.getEventById(
            _eventId
        );

        uint256 newTicketId = currentTicketId;
        allStekcitTickets.push(
            StekcitTicket(
                newTicketId,
                _eventId,
                _attendingUserWalletAddress,
                currentEvent.amountInEthers,
                false,
                0,
                0
            )
        );

        currentTicketId++;
    }

    function getAllTickets() public view returns (StekcitTicket[] memory) {
        return allStekcitTickets;
    }

    function getTicketById(uint256 _ticketId)
        public
        view
        returns (StekcitTicket memory)
    {
        return allStekcitTickets[_ticketId];
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
}
