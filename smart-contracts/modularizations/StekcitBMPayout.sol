// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {StekcitPayout} from "./StekcitBMStructs.sol";
import {ERC20} from "./StekcitBMInterfaces.sol";
import {StekcitBMEvent} from "./StekcitBMEvent.sol";
import {StekcitBMTicket} from "./StekcitBMTicket.sol";
import {StekcitEvent} from "./StekcitBMStructs.sol";
import {StekcitTicket} from "./StekcitBMStructs.sol";

contract StekcitBMPayout {
    StekcitPayout[] private allStekcitPayouts;
    uint256 private currentPayoutId;
    StekcitBMEvent private stekcitBMEventContract;
    StekcitBMTicket private stekcitBMTicketContract;

    constructor(address _eventContractAddress, address _ticketContractAddress) {
        stekcitBMEventContract = StekcitBMEvent(_eventContractAddress);
        stekcitBMTicketContract = StekcitBMTicket(_ticketContractAddress);
    }

    function processPayout(
        uint256 _eventId,
        address _creatingUserWalletAddress,
        ERC20 cUSD,
        address _stekcitBMOwnerAddress
    ) public {
        StekcitEvent memory eventToBePaidOut = stekcitBMEventContract
            .getEventById(_eventId);

        uint256 totalAmountToBePaidOutToCreatingUser = getTotalAmountPaidToEventInEthers(
                _eventId
            );
        totalAmountToBePaidOutToCreatingUser =
            (totalAmountToBePaidOutToCreatingUser * 80) /
            100;

        if (eventToBePaidOut.isVerified) {
            totalAmountToBePaidOutToCreatingUser += eventToBePaidOut
                .verificationAmountInEthers;
        }

        bool isCreatingUserPaid = cUSD.transfer(
            eventToBePaidOut.creatingUserWalletAddress,
            totalAmountToBePaidOutToCreatingUser
        );

        if (isCreatingUserPaid) {
            uint256 amountToBePaidOutToStekcitBMOwner = (totalAmountToBePaidOutToCreatingUser *
                    20) / 100;
            cUSD.transfer(
                _stekcitBMOwnerAddress,
                amountToBePaidOutToStekcitBMOwner
            );
        }

        uint256 newPayoutId = currentPayoutId;

        allStekcitPayouts.push(
            StekcitPayout(
                newPayoutId,
                _eventId,
                _creatingUserWalletAddress,
                totalAmountToBePaidOutToCreatingUser,
                block.timestamp,
                false
            )
        );

        currentPayoutId++;
    }

    function getTotalAmountPaidToEventInEthers(uint256 _eventId)
        public
        view
        returns (uint256)
    {
        uint256 totalAmountPaid = 0;
        for (
            uint256 ticketId = 0;
            ticketId < stekcitBMTicketContract.getAllTickets().length;
            ticketId++
        ) {
            // stekcitBMTicketContract
            StekcitTicket memory currentTicket = stekcitBMTicketContract
                .getTicketById(ticketId);
            if (currentTicket.eventId == _eventId) {
                totalAmountPaid += currentTicket.amountPaidInEthers;
            }
        }
        return totalAmountPaid;
    }
}
