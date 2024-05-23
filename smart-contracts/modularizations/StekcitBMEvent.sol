// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {StekcitEvent} from "./StekcitBMStructs.sol";
import {ERC20} from "./StekcitBMInterfaces.sol";

contract StekcitBMEvent {
    StekcitEvent[] private allStekcitEvents;
    uint256 private currentEventId;

    function createEvent(
        string memory _title,
        string memory _description,
        string memory _link,
        uint256 _amount,
        uint256 _dateAndTime,
        bool _forImmediatePublishing,
        address _creatingUserWalletAddress
    ) public {
        uint256 newEventId = currentEventId;
        uint256 createdAt = block.timestamp;
        uint256 updatedAt = block.timestamp;

        allStekcitEvents.push(
            StekcitEvent(
                newEventId,
                _creatingUserWalletAddress,
                _title,
                _description,
                _link,
                _amount,
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

    function getAllEvents() public view returns (StekcitEvent[] memory) {
        return allStekcitEvents;
    }


  function getEventByVerificationId(uint256 _verificationId)
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
            if (currentEvent.verificationId == _verificationId) {
                return currentEvent;
            }
        }

        StekcitEvent memory blankEvent;
        blankEvent.isBlank = true;
        return blankEvent;
    }
    
}
