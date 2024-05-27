export const stekcitBMContractABI: Object[] =
    [
        {
            "inputs": [
                {
                    "internalType": "string",
                    "name": "_title",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "_description",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "_link",
                    "type": "string"
                },
                {
                    "internalType": "uint256",
                    "name": "_amount",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "_dateAndTime",
                    "type": "uint256"
                },
                {
                    "internalType": "bool",
                    "name": "_forImmediatePublishing",
                    "type": "bool"
                }
            ],
            "name": "createEvent",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "createTicketForUser",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "string",
                    "name": "_username",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "_emailAddress",
                    "type": "string"
                }
            ],
            "name": "createUser",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "walletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "username",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "emailAddress",
                            "type": "string"
                        },
                        {
                            "internalType": "bool",
                            "name": "isCreatingUser",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isWelcomeEmailSent",
                            "type": "bool"
                        },
                        {
                            "internalType": "bytes32",
                            "name": "welcomeEmailVerificationId",
                            "type": "bytes32"
                        }
                    ],
                    "internalType": "struct StekcitUser",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "_stekcitBMOwnerAddress",
                    "type": "address"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "constructor"
        },
        {
            "inputs": [],
            "name": "EmptyArgs",
            "type": "error"
        },
        {
            "inputs": [],
            "name": "EmptySecrets",
            "type": "error"
        },
        {
            "inputs": [],
            "name": "EmptySource",
            "type": "error"
        },
        {
            "inputs": [
                {
                    "internalType": "bytes32",
                    "name": "requestId",
                    "type": "bytes32"
                },
                {
                    "internalType": "bytes",
                    "name": "response",
                    "type": "bytes"
                },
                {
                    "internalType": "bytes",
                    "name": "err",
                    "type": "bytes"
                }
            ],
            "name": "handleOracleFulfillment",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "makeCreatingUser",
            "outputs": [
                {
                    "internalType": "bool",
                    "name": "",
                    "type": "bool"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "NoInlineSecrets",
            "type": "error"
        },
        {
            "inputs": [],
            "name": "OnlyRouterCanFulfill",
            "type": "error"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "processPayout",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "eventId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "creatingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountPaidOutInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "dateTimeAndMade",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        }
                    ],
                    "internalType": "struct StekcitPayout",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "publishEvent",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "creatingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "title",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "description",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "link",
                            "type": "string"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "createdAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "updatedAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "dateAndTime",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPublished",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isVerified",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationAmountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isEnded",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPaidOut",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationRequestId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationId",
                            "type": "uint256"
                        }
                    ],
                    "internalType": "struct StekcitEvent",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_requestId",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256[]",
                    "name": "_randomWords",
                    "type": "uint256[]"
                }
            ],
            "name": "rawFulfillRandomWords",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "internalType": "bytes32",
                    "name": "id",
                    "type": "bytes32"
                }
            ],
            "name": "RequestFulfilled",
            "type": "event"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "internalType": "bytes32",
                    "name": "id",
                    "type": "bytes32"
                }
            ],
            "name": "RequestSent",
            "type": "event"
        },
        {
            "inputs": [
                {
                    "internalType": "string",
                    "name": "source",
                    "type": "string"
                },
                {
                    "internalType": "bytes",
                    "name": "encryptedSecretsUrls",
                    "type": "bytes"
                },
                {
                    "internalType": "uint8",
                    "name": "donHostedSecretsSlotID",
                    "type": "uint8"
                },
                {
                    "internalType": "uint64",
                    "name": "donHostedSecretsVersion",
                    "type": "uint64"
                },
                {
                    "internalType": "string[]",
                    "name": "args",
                    "type": "string[]"
                },
                {
                    "internalType": "bytes[]",
                    "name": "bytesArgs",
                    "type": "bytes[]"
                },
                {
                    "internalType": "uint64",
                    "name": "subscriptionId",
                    "type": "uint64"
                },
                {
                    "internalType": "uint32",
                    "name": "gasLimit",
                    "type": "uint32"
                },
                {
                    "internalType": "bytes32",
                    "name": "donID",
                    "type": "bytes32"
                }
            ],
            "name": "sendRequest",
            "outputs": [
                {
                    "internalType": "bytes32",
                    "name": "",
                    "type": "bytes32"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "verifyEventAndSetVerificationRequestId",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "creatingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "title",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "description",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "link",
                            "type": "string"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "createdAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "updatedAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "dateAndTime",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPublished",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isVerified",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationAmountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isEnded",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPaidOut",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationRequestId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationId",
                            "type": "uint256"
                        }
                    ],
                    "internalType": "struct StekcitEvent",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_ticketId",
                    "type": "uint256"
                }
            ],
            "name": "verifyTicketAndSetVerificationRequestId",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "eventId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "attendingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountPaidInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationRequestId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationId",
                            "type": "uint256"
                        }
                    ],
                    "internalType": "struct StekcitTicket",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "checkIfEventIsAlreadyPaidOut",
            "outputs": [
                {
                    "internalType": "bool",
                    "name": "",
                    "type": "bool"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "checkIfTicketOfUserForThisEventExists",
            "outputs": [
                {
                    "internalType": "bool",
                    "name": "",
                    "type": "bool"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                },
                {
                    "internalType": "address",
                    "name": "_walletAddress",
                    "type": "address"
                }
            ],
            "name": "checkIfUserAlreadyHasTicket",
            "outputs": [
                {
                    "internalType": "bool",
                    "name": "",
                    "type": "bool"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "_walletAddress",
                    "type": "address"
                }
            ],
            "name": "getAllEventsCreatedByUser",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "creatingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "title",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "description",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "link",
                            "type": "string"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "createdAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "updatedAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "dateAndTime",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPublished",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isVerified",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationAmountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isEnded",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPaidOut",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationRequestId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationId",
                            "type": "uint256"
                        }
                    ],
                    "internalType": "struct StekcitEvent[]",
                    "name": "",
                    "type": "tuple[]"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "getAllPublishedEvents",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "creatingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "title",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "description",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "link",
                            "type": "string"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "createdAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "updatedAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "dateAndTime",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPublished",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isVerified",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationAmountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isEnded",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPaidOut",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationRequestId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationId",
                            "type": "uint256"
                        }
                    ],
                    "internalType": "struct StekcitEvent[]",
                    "name": "",
                    "type": "tuple[]"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "getAllTicketsOfEvent",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "eventId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "attendingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountPaidInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationRequestId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationId",
                            "type": "uint256"
                        }
                    ],
                    "internalType": "struct StekcitTicket[]",
                    "name": "",
                    "type": "tuple[]"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "_walletAddress",
                    "type": "address"
                }
            ],
            "name": "getAllTicketsOfUser",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "eventId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "attendingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountPaidInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationRequestId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationId",
                            "type": "uint256"
                        }
                    ],
                    "internalType": "struct StekcitTicket[]",
                    "name": "",
                    "type": "tuple[]"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "getEventAttendees",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "walletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "username",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "emailAddress",
                            "type": "string"
                        },
                        {
                            "internalType": "bool",
                            "name": "isCreatingUser",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isWelcomeEmailSent",
                            "type": "bool"
                        },
                        {
                            "internalType": "bytes32",
                            "name": "welcomeEmailVerificationId",
                            "type": "bytes32"
                        }
                    ],
                    "internalType": "struct StekcitUser[]",
                    "name": "",
                    "type": "tuple[]"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "getEventById",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "creatingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "title",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "description",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "link",
                            "type": "string"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "createdAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "updatedAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "dateAndTime",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPublished",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isVerified",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationAmountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isEnded",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPaidOut",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationRequestId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationId",
                            "type": "uint256"
                        }
                    ],
                    "internalType": "struct StekcitEvent",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_verificationRequestId",
                    "type": "uint256"
                }
            ],
            "name": "getEventByVerificationRequestId",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "creatingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "title",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "description",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "link",
                            "type": "string"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "createdAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "updatedAt",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "dateAndTime",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPublished",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isVerified",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationAmountInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isEnded",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isPaidOut",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationRequestId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationId",
                            "type": "uint256"
                        }
                    ],
                    "internalType": "struct StekcitEvent",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "getNumberOfAllPublishedEvents",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "getNumberOfTicketsOfEvent",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "_walletAddress",
                    "type": "address"
                }
            ],
            "name": "getNumberOfTicketsOfUser",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_payoutId",
                    "type": "uint256"
                }
            ],
            "name": "getPayoutById",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "eventId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "creatingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountPaidOutInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "dateTimeAndMade",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        }
                    ],
                    "internalType": "struct StekcitPayout",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                },
                {
                    "internalType": "address",
                    "name": "_walletAddress",
                    "type": "address"
                }
            ],
            "name": "getTicketByEventIdAndWalletAddress",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "eventId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "attendingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountPaidInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationRequestId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationId",
                            "type": "uint256"
                        }
                    ],
                    "internalType": "struct StekcitTicket",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_verificationRequestId",
                    "type": "uint256"
                }
            ],
            "name": "getTicketByVerificationRequestId",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "eventId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "attendingUserWalletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountPaidInEthers",
                            "type": "uint256"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationRequestId",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "verificationId",
                            "type": "uint256"
                        }
                    ],
                    "internalType": "struct StekcitTicket",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "getTotalAmountPaidToEventInEthers",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "_walletAddress",
                    "type": "address"
                }
            ],
            "name": "getTotalNumberOfAllEventsCreatedByUser",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_eventId",
                    "type": "uint256"
                }
            ],
            "name": "getTotalNumberOfTicketsOfEvent",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "_userId",
                    "type": "uint256"
                }
            ],
            "name": "getUserById",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "walletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "username",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "emailAddress",
                            "type": "string"
                        },
                        {
                            "internalType": "bool",
                            "name": "isCreatingUser",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isWelcomeEmailSent",
                            "type": "bool"
                        },
                        {
                            "internalType": "bytes32",
                            "name": "welcomeEmailVerificationId",
                            "type": "bytes32"
                        }
                    ],
                    "internalType": "struct StekcitUser",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "_walletAddress",
                    "type": "address"
                }
            ],
            "name": "getUserByWalletAddress",
            "outputs": [
                {
                    "components": [
                        {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                        },
                        {
                            "internalType": "address",
                            "name": "walletAddress",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "username",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "emailAddress",
                            "type": "string"
                        },
                        {
                            "internalType": "bool",
                            "name": "isCreatingUser",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isBlank",
                            "type": "bool"
                        },
                        {
                            "internalType": "bool",
                            "name": "isWelcomeEmailSent",
                            "type": "bool"
                        },
                        {
                            "internalType": "bytes32",
                            "name": "welcomeEmailVerificationId",
                            "type": "bytes32"
                        }
                    ],
                    "internalType": "struct StekcitUser",
                    "name": "",
                    "type": "tuple"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "lastFunctionsError",
            "outputs": [
                {
                    "internalType": "bytes",
                    "name": "",
                    "type": "bytes"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "stekcitBMOwnerAddress",
            "outputs": [
                {
                    "internalType": "address",
                    "name": "",
                    "type": "address"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        }
    ]