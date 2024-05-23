// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {StekcitUser} from "./StekcitBMStructs.sol";

contract StekcitBMUser {
    StekcitUser[] private allStekcitUsers;
    uint256 private currentUserId;

    function createUser(
        string memory _username,
        string memory _emailAddress,
        address _walletAddress
    ) public {
        uint256 newUserId = currentUserId;
        allStekcitUsers.push(
            StekcitUser(
                newUserId,
                _walletAddress,
                _username,
                _emailAddress,
                false,
                false,
                false,
                ""
            )
        );
        currentUserId++;
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

    function getUserById(uint256 _userId)
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

    function getAllUsers() public view returns (StekcitUser[] memory) {
        return allStekcitUsers;
    }
}
