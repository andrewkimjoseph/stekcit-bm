// SPDX-License-Identifier: MIT
// File: smart-contracts/StekcitBMInterfaces.sol



pragma solidity ^0.8.19;

interface ERC20 {
    function initialize(string memory name_, string memory symbol_) external;

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);

    // function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
    // function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);

    // function _transfer(address from, address to, uint256 amount) external;
    // function _mint(address account, uint256 amount) external;
    // function _burn(address account, uint256 amount) external;
    // function _approve(address owner, address spender, uint256 amount) external;
    // function _spendAllowance(address owner, address spender, uint256 amount) external;

    // function _beforeTokenTransfer(address from, address to, uint256 amount) external;
    // function _afterTokenTransfer(address from, address to, uint256 amount) external;
}

// File: smart-contracts/StekcitBMStructs.sol



pragma solidity ^0.8.19;

struct StekcitUser {
    uint256 id;
    address walletAddress;
    string username;
    string emailAddress;
    bool isCreatingUser;
    bool isBlank;
    bool isWelcomeEmailSent;

    bytes32 welcomeEmailVerificationId;
}

struct StekcitEvent {
    uint256 id;
    address creatingUserWalletAddress;
    string title;
    string description;
    string link;
    uint256 amountInEthers;
    uint256 createdAt;
    uint256 updatedAt;
    uint256 dateAndTime;
    bool isBlank;
    bool isPublished;
    bool isVerified;
    uint256 verificationAmountInEthers;
    bool isEnded;
    bool isPaidOut;
    uint256 verificationRequestId;
    uint256 verificationId;
}

struct StekcitTicket {
    uint256 id;
    uint256 eventId;
    address attendingUserWalletAddress;
    uint256 amountPaidInEthers;
    bool isBlank;
    uint256 verificationRequestId;
    uint256 verificationId;
}

struct StekcitPayout {
    uint256 id;
    uint256 eventId;
    address creatingUserWalletAddress;
    uint256 amountPaidOutInEthers;
    uint256 dateTimeAndMade;
    bool isBlank;
}

struct StekcitFunctionsError {
    uint256 id;
    bytes error;
}
// File: @chainlink/contracts/src/v0.8/shared/interfaces/IOwnable.sol


pragma solidity ^0.8.0;

interface IOwnable {
  function owner() external returns (address);

  function transferOwnership(address recipient) external;

  function acceptOwnership() external;
}

// File: @chainlink/contracts/src/v0.8/shared/access/ConfirmedOwnerWithProposal.sol


pragma solidity ^0.8.0;


/// @title The ConfirmedOwner contract
/// @notice A contract with helpers for basic contract ownership.
contract ConfirmedOwnerWithProposal is IOwnable {
  address private s_owner;
  address private s_pendingOwner;

  event OwnershipTransferRequested(address indexed from, address indexed to);
  event OwnershipTransferred(address indexed from, address indexed to);

  constructor(address newOwner, address pendingOwner) {
    // solhint-disable-next-line gas-custom-errors
    require(newOwner != address(0), "Cannot set owner to zero");

    s_owner = newOwner;
    if (pendingOwner != address(0)) {
      _transferOwnership(pendingOwner);
    }
  }

  /// @notice Allows an owner to begin transferring ownership to a new address.
  function transferOwnership(address to) public override onlyOwner {
    _transferOwnership(to);
  }

  /// @notice Allows an ownership transfer to be completed by the recipient.
  function acceptOwnership() external override {
    // solhint-disable-next-line gas-custom-errors
    require(msg.sender == s_pendingOwner, "Must be proposed owner");

    address oldOwner = s_owner;
    s_owner = msg.sender;
    s_pendingOwner = address(0);

    emit OwnershipTransferred(oldOwner, msg.sender);
  }

  /// @notice Get the current owner
  function owner() public view override returns (address) {
    return s_owner;
  }

  /// @notice validate, transfer ownership, and emit relevant events
  function _transferOwnership(address to) private {
    // solhint-disable-next-line gas-custom-errors
    require(to != msg.sender, "Cannot transfer to self");

    s_pendingOwner = to;

    emit OwnershipTransferRequested(s_owner, to);
  }

  /// @notice validate access
  function _validateOwnership() internal view {
    // solhint-disable-next-line gas-custom-errors
    require(msg.sender == s_owner, "Only callable by owner");
  }

  /// @notice Reverts if called by anyone other than the contract owner.
  modifier onlyOwner() {
    _validateOwnership();
    _;
  }
}

// File: @chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol


pragma solidity ^0.8.0;


/// @title The ConfirmedOwner contract
/// @notice A contract with helpers for basic contract ownership.
contract ConfirmedOwner is ConfirmedOwnerWithProposal {
  constructor(address newOwner) ConfirmedOwnerWithProposal(newOwner, address(0)) {}
}

// File: @chainlink/contracts/src/v0.8/vrf/dev/interfaces/IVRFMigratableConsumerV2Plus.sol


pragma solidity ^0.8.0;

/// @notice The IVRFMigratableConsumerV2Plus interface defines the
/// @notice method required to be implemented by all V2Plus consumers.
/// @dev This interface is designed to be used in VRFConsumerBaseV2Plus.
interface IVRFMigratableConsumerV2Plus {
  event CoordinatorSet(address vrfCoordinator);

  /// @notice Sets the VRF Coordinator address
  /// @notice This method should only be callable by the coordinator or contract owner
  function setCoordinator(address vrfCoordinator) external;
}

// File: @chainlink/contracts/src/v0.8/vrf/dev/interfaces/IVRFSubscriptionV2Plus.sol


pragma solidity ^0.8.0;

/// @notice The IVRFSubscriptionV2Plus interface defines the subscription
/// @notice related methods implemented by the V2Plus coordinator.
interface IVRFSubscriptionV2Plus {
  /**
   * @notice Add a consumer to a VRF subscription.
   * @param subId - ID of the subscription
   * @param consumer - New consumer which can use the subscription
   */
  function addConsumer(uint256 subId, address consumer) external;

  /**
   * @notice Remove a consumer from a VRF subscription.
   * @param subId - ID of the subscription
   * @param consumer - Consumer to remove from the subscription
   */
  function removeConsumer(uint256 subId, address consumer) external;

  /**
   * @notice Cancel a subscription
   * @param subId - ID of the subscription
   * @param to - Where to send the remaining LINK to
   */
  function cancelSubscription(uint256 subId, address to) external;

  /**
   * @notice Accept subscription owner transfer.
   * @param subId - ID of the subscription
   * @dev will revert if original owner of subId has
   * not requested that msg.sender become the new owner.
   */
  function acceptSubscriptionOwnerTransfer(uint256 subId) external;

  /**
   * @notice Request subscription owner transfer.
   * @param subId - ID of the subscription
   * @param newOwner - proposed new owner of the subscription
   */
  function requestSubscriptionOwnerTransfer(uint256 subId, address newOwner) external;

  /**
   * @notice Create a VRF subscription.
   * @return subId - A unique subscription id.
   * @dev You can manage the consumer set dynamically with addConsumer/removeConsumer.
   * @dev Note to fund the subscription with LINK, use transferAndCall. For example
   * @dev  LINKTOKEN.transferAndCall(
   * @dev    address(COORDINATOR),
   * @dev    amount,
   * @dev    abi.encode(subId));
   * @dev Note to fund the subscription with Native, use fundSubscriptionWithNative. Be sure
   * @dev  to send Native with the call, for example:
   * @dev COORDINATOR.fundSubscriptionWithNative{value: amount}(subId);
   */
  function createSubscription() external returns (uint256 subId);

  /**
   * @notice Get a VRF subscription.
   * @param subId - ID of the subscription
   * @return balance - LINK balance of the subscription in juels.
   * @return nativeBalance - native balance of the subscription in wei.
   * @return reqCount - Requests count of subscription.
   * @return owner - owner of the subscription.
   * @return consumers - list of consumer address which are able to use this subscription.
   */
  function getSubscription(
    uint256 subId
  )
    external
    view
    returns (uint96 balance, uint96 nativeBalance, uint64 reqCount, address owner, address[] memory consumers);

  /*
   * @notice Check to see if there exists a request commitment consumers
   * for all consumers and keyhashes for a given sub.
   * @param subId - ID of the subscription
   * @return true if there exists at least one unfulfilled request for the subscription, false
   * otherwise.
   */
  function pendingRequestExists(uint256 subId) external view returns (bool);

  /**
   * @notice Paginate through all active VRF subscriptions.
   * @param startIndex index of the subscription to start from
   * @param maxCount maximum number of subscriptions to return, 0 to return all
   * @dev the order of IDs in the list is **not guaranteed**, therefore, if making successive calls, one
   * @dev should consider keeping the blockheight constant to ensure a holistic picture of the contract state
   */
  function getActiveSubscriptionIds(uint256 startIndex, uint256 maxCount) external view returns (uint256[] memory);

  /**
   * @notice Fund a subscription with native.
   * @param subId - ID of the subscription
   * @notice This method expects msg.value to be greater than or equal to 0.
   */
  function fundSubscriptionWithNative(uint256 subId) external payable;
}

// File: @chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol


pragma solidity ^0.8.4;

// End consumer library.
library VRFV2PlusClient {
  // extraArgs will evolve to support new features
  bytes4 public constant EXTRA_ARGS_V1_TAG = bytes4(keccak256("VRF ExtraArgsV1"));
  struct ExtraArgsV1 {
    bool nativePayment;
  }

  struct RandomWordsRequest {
    bytes32 keyHash;
    uint256 subId;
    uint16 requestConfirmations;
    uint32 callbackGasLimit;
    uint32 numWords;
    bytes extraArgs;
  }

  function _argsToBytes(ExtraArgsV1 memory extraArgs) internal pure returns (bytes memory bts) {
    return abi.encodeWithSelector(EXTRA_ARGS_V1_TAG, extraArgs);
  }
}

// File: @chainlink/contracts/src/v0.8/vrf/dev/interfaces/IVRFCoordinatorV2Plus.sol


pragma solidity ^0.8.0;



// Interface that enables consumers of VRFCoordinatorV2Plus to be future-proof for upgrades
// This interface is supported by subsequent versions of VRFCoordinatorV2Plus
interface IVRFCoordinatorV2Plus is IVRFSubscriptionV2Plus {
  /**
   * @notice Request a set of random words.
   * @param req - a struct containing following fields for randomness request:
   * keyHash - Corresponds to a particular oracle job which uses
   * that key for generating the VRF proof. Different keyHash's have different gas price
   * ceilings, so you can select a specific one to bound your maximum per request cost.
   * subId  - The ID of the VRF subscription. Must be funded
   * with the minimum subscription balance required for the selected keyHash.
   * requestConfirmations - How many blocks you'd like the
   * oracle to wait before responding to the request. See SECURITY CONSIDERATIONS
   * for why you may want to request more. The acceptable range is
   * [minimumRequestBlockConfirmations, 200].
   * callbackGasLimit - How much gas you'd like to receive in your
   * fulfillRandomWords callback. Note that gasleft() inside fulfillRandomWords
   * may be slightly less than this amount because of gas used calling the function
   * (argument decoding etc.), so you may need to request slightly more than you expect
   * to have inside fulfillRandomWords. The acceptable range is
   * [0, maxGasLimit]
   * numWords - The number of uint256 random values you'd like to receive
   * in your fulfillRandomWords callback. Note these numbers are expanded in a
   * secure way by the VRFCoordinator from a single random value supplied by the oracle.
   * extraArgs - abi-encoded extra args
   * @return requestId - A unique identifier of the request. Can be used to match
   * a request to a response in fulfillRandomWords.
   */
  function requestRandomWords(VRFV2PlusClient.RandomWordsRequest calldata req) external returns (uint256 requestId);
}

// File: @chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol


pragma solidity ^0.8.4;




/** ****************************************************************************
 * @notice Interface for contracts using VRF randomness
 * *****************************************************************************
 * @dev PURPOSE
 *
 * @dev Reggie the Random Oracle (not his real job) wants to provide randomness
 * @dev to Vera the verifier in such a way that Vera can be sure he's not
 * @dev making his output up to suit himself. Reggie provides Vera a public key
 * @dev to which he knows the secret key. Each time Vera provides a seed to
 * @dev Reggie, he gives back a value which is computed completely
 * @dev deterministically from the seed and the secret key.
 *
 * @dev Reggie provides a proof by which Vera can verify that the output was
 * @dev correctly computed once Reggie tells it to her, but without that proof,
 * @dev the output is indistinguishable to her from a uniform random sample
 * @dev from the output space.
 *
 * @dev The purpose of this contract is to make it easy for unrelated contracts
 * @dev to talk to Vera the verifier about the work Reggie is doing, to provide
 * @dev simple access to a verifiable source of randomness. It ensures 2 things:
 * @dev 1. The fulfillment came from the VRFCoordinatorV2Plus.
 * @dev 2. The consumer contract implements fulfillRandomWords.
 * *****************************************************************************
 * @dev USAGE
 *
 * @dev Calling contracts must inherit from VRFConsumerBaseV2Plus, and can
 * @dev initialize VRFConsumerBaseV2Plus's attributes in their constructor as
 * @dev shown:
 *
 * @dev   contract VRFConsumerV2Plus is VRFConsumerBaseV2Plus {
 * @dev     constructor(<other arguments>, address _vrfCoordinator, address _subOwner)
 * @dev       VRFConsumerBaseV2Plus(_vrfCoordinator, _subOwner) public {
 * @dev         <initialization with other arguments goes here>
 * @dev       }
 * @dev   }
 *
 * @dev The oracle will have given you an ID for the VRF keypair they have
 * @dev committed to (let's call it keyHash). Create a subscription, fund it
 * @dev and your consumer contract as a consumer of it (see VRFCoordinatorInterface
 * @dev subscription management functions).
 * @dev Call requestRandomWords(keyHash, subId, minimumRequestConfirmations,
 * @dev callbackGasLimit, numWords, extraArgs),
 * @dev see (IVRFCoordinatorV2Plus for a description of the arguments).
 *
 * @dev Once the VRFCoordinatorV2Plus has received and validated the oracle's response
 * @dev to your request, it will call your contract's fulfillRandomWords method.
 *
 * @dev The randomness argument to fulfillRandomWords is a set of random words
 * @dev generated from your requestId and the blockHash of the request.
 *
 * @dev If your contract could have concurrent requests open, you can use the
 * @dev requestId returned from requestRandomWords to track which response is associated
 * @dev with which randomness request.
 * @dev See "SECURITY CONSIDERATIONS" for principles to keep in mind,
 * @dev if your contract could have multiple requests in flight simultaneously.
 *
 * @dev Colliding `requestId`s are cryptographically impossible as long as seeds
 * @dev differ.
 *
 * *****************************************************************************
 * @dev SECURITY CONSIDERATIONS
 *
 * @dev A method with the ability to call your fulfillRandomness method directly
 * @dev could spoof a VRF response with any random value, so it's critical that
 * @dev it cannot be directly called by anything other than this base contract
 * @dev (specifically, by the VRFConsumerBaseV2Plus.rawFulfillRandomness method).
 *
 * @dev For your users to trust that your contract's random behavior is free
 * @dev from malicious interference, it's best if you can write it so that all
 * @dev behaviors implied by a VRF response are executed *during* your
 * @dev fulfillRandomness method. If your contract must store the response (or
 * @dev anything derived from it) and use it later, you must ensure that any
 * @dev user-significant behavior which depends on that stored value cannot be
 * @dev manipulated by a subsequent VRF request.
 *
 * @dev Similarly, both miners and the VRF oracle itself have some influence
 * @dev over the order in which VRF responses appear on the blockchain, so if
 * @dev your contract could have multiple VRF requests in flight simultaneously,
 * @dev you must ensure that the order in which the VRF responses arrive cannot
 * @dev be used to manipulate your contract's user-significant behavior.
 *
 * @dev Since the block hash of the block which contains the requestRandomness
 * @dev call is mixed into the input to the VRF *last*, a sufficiently powerful
 * @dev miner could, in principle, fork the blockchain to evict the block
 * @dev containing the request, forcing the request to be included in a
 * @dev different block with a different hash, and therefore a different input
 * @dev to the VRF. However, such an attack would incur a substantial economic
 * @dev cost. This cost scales with the number of blocks the VRF oracle waits
 * @dev until it calls responds to a request. It is for this reason that
 * @dev that you can signal to an oracle you'd like them to wait longer before
 * @dev responding to the request (however this is not enforced in the contract
 * @dev and so remains effective only in the case of unmodified oracle software).
 */
abstract contract VRFConsumerBaseV2Plus is IVRFMigratableConsumerV2Plus, ConfirmedOwner {
  error OnlyCoordinatorCanFulfill(address have, address want);
  error OnlyOwnerOrCoordinator(address have, address owner, address coordinator);
  error ZeroAddress();

  // s_vrfCoordinator should be used by consumers to make requests to vrfCoordinator
  // so that coordinator reference is updated after migration
  IVRFCoordinatorV2Plus public s_vrfCoordinator;

  /**
   * @param _vrfCoordinator address of VRFCoordinator contract
   */
  constructor(address _vrfCoordinator) ConfirmedOwner(msg.sender) {
    if (_vrfCoordinator == address(0)) {
      revert ZeroAddress();
    }
    s_vrfCoordinator = IVRFCoordinatorV2Plus(_vrfCoordinator);
  }

  /**
   * @notice fulfillRandomness handles the VRF response. Your contract must
   * @notice implement it. See "SECURITY CONSIDERATIONS" above for important
   * @notice principles to keep in mind when implementing your fulfillRandomness
   * @notice method.
   *
   * @dev VRFConsumerBaseV2Plus expects its subcontracts to have a method with this
   * @dev signature, and will call it once it has verified the proof
   * @dev associated with the randomness. (It is triggered via a call to
   * @dev rawFulfillRandomness, below.)
   *
   * @param requestId The Id initially returned by requestRandomness
   * @param randomWords the VRF output expanded to the requested number of words
   */
  // solhint-disable-next-line chainlink-solidity/prefix-internal-functions-with-underscore
  function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) internal virtual;

  // rawFulfillRandomness is called by VRFCoordinator when it receives a valid VRF
  // proof. rawFulfillRandomness then calls fulfillRandomness, after validating
  // the origin of the call
  function rawFulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) external {
    if (msg.sender != address(s_vrfCoordinator)) {
      revert OnlyCoordinatorCanFulfill(msg.sender, address(s_vrfCoordinator));
    }
    fulfillRandomWords(requestId, randomWords);
  }

  /**
   * @inheritdoc IVRFMigratableConsumerV2Plus
   */
  function setCoordinator(address _vrfCoordinator) external override onlyOwnerOrCoordinator {
    if (_vrfCoordinator == address(0)) {
      revert ZeroAddress();
    }
    s_vrfCoordinator = IVRFCoordinatorV2Plus(_vrfCoordinator);

    emit CoordinatorSet(_vrfCoordinator);
  }

  modifier onlyOwnerOrCoordinator() {
    if (msg.sender != owner() && msg.sender != address(s_vrfCoordinator)) {
      revert OnlyOwnerOrCoordinator(msg.sender, owner(), address(s_vrfCoordinator));
    }
    _;
  }
}

// File: @chainlink/contracts/src/v0.8/vendor/@ensdomains/buffer/v0.1.0/Buffer.sol


pragma solidity ^0.8.4;

/**
* @dev A library for working with mutable byte buffers in Solidity.
*
* Byte buffers are mutable and expandable, and provide a variety of primitives
* for appending to them. At any time you can fetch a bytes object containing the
* current contents of the buffer. The bytes object should not be stored between
* operations, as it may change due to resizing of the buffer.
*/
library Buffer {
    /**
    * @dev Represents a mutable buffer. Buffers have a current value (buf) and
    *      a capacity. The capacity may be longer than the current value, in
    *      which case it can be extended without the need to allocate more memory.
    */
    struct buffer {
        bytes buf;
        uint capacity;
    }

    /**
    * @dev Initializes a buffer with an initial capacity.
    * @param buf The buffer to initialize.
    * @param capacity The number of bytes of space to allocate the buffer.
    * @return The buffer, for chaining.
    */
    function init(buffer memory buf, uint capacity) internal pure returns(buffer memory) {
        if (capacity % 32 != 0) {
            capacity += 32 - (capacity % 32);
        }
        // Allocate space for the buffer data
        buf.capacity = capacity;
        assembly {
            let ptr := mload(0x40)
            mstore(buf, ptr)
            mstore(ptr, 0)
            let fpm := add(32, add(ptr, capacity))
            if lt(fpm, ptr) {
                revert(0, 0)
            }
            mstore(0x40, fpm)
        }
        return buf;
    }

    /**
    * @dev Initializes a new buffer from an existing bytes object.
    *      Changes to the buffer may mutate the original value.
    * @param b The bytes object to initialize the buffer with.
    * @return A new buffer.
    */
    function fromBytes(bytes memory b) internal pure returns(buffer memory) {
        buffer memory buf;
        buf.buf = b;
        buf.capacity = b.length;
        return buf;
    }

    function resize(buffer memory buf, uint capacity) private pure {
        bytes memory oldbuf = buf.buf;
        init(buf, capacity);
        append(buf, oldbuf);
    }

    /**
    * @dev Sets buffer length to 0.
    * @param buf The buffer to truncate.
    * @return The original buffer, for chaining..
    */
    function truncate(buffer memory buf) internal pure returns (buffer memory) {
        assembly {
            let bufptr := mload(buf)
            mstore(bufptr, 0)
        }
        return buf;
    }

    /**
    * @dev Appends len bytes of a byte string to a buffer. Resizes if doing so would exceed
    *      the capacity of the buffer.
    * @param buf The buffer to append to.
    * @param data The data to append.
    * @param len The number of bytes to copy.
    * @return The original buffer, for chaining.
    */
    function append(buffer memory buf, bytes memory data, uint len) internal pure returns(buffer memory) {
        require(len <= data.length);

        uint off = buf.buf.length;
        uint newCapacity = off + len;
        if (newCapacity > buf.capacity) {
            resize(buf, newCapacity * 2);
        }

        uint dest;
        uint src;
        assembly {
            // Memory address of the buffer data
            let bufptr := mload(buf)
            // Length of existing buffer data
            let buflen := mload(bufptr)
            // Start address = buffer address + offset + sizeof(buffer length)
            dest := add(add(bufptr, 32), off)
            // Update buffer length if we're extending it
            if gt(newCapacity, buflen) {
                mstore(bufptr, newCapacity)
            }
            src := add(data, 32)
        }

        // Copy word-length chunks while possible
        for (; len >= 32; len -= 32) {
            assembly {
                mstore(dest, mload(src))
            }
            dest += 32;
            src += 32;
        }

        // Copy remaining bytes
        unchecked {
            uint mask = (256 ** (32 - len)) - 1;
            assembly {
                let srcpart := and(mload(src), not(mask))
                let destpart := and(mload(dest), mask)
                mstore(dest, or(destpart, srcpart))
            }
        }

        return buf;
    }

    /**
    * @dev Appends a byte string to a buffer. Resizes if doing so would exceed
    *      the capacity of the buffer.
    * @param buf The buffer to append to.
    * @param data The data to append.
    * @return The original buffer, for chaining.
    */
    function append(buffer memory buf, bytes memory data) internal pure returns (buffer memory) {
        return append(buf, data, data.length);
    }

    /**
    * @dev Appends a byte to the buffer. Resizes if doing so would exceed the
    *      capacity of the buffer.
    * @param buf The buffer to append to.
    * @param data The data to append.
    * @return The original buffer, for chaining.
    */
    function appendUint8(buffer memory buf, uint8 data) internal pure returns(buffer memory) {
        uint off = buf.buf.length;
        uint offPlusOne = off + 1;
        if (off >= buf.capacity) {
            resize(buf, offPlusOne * 2);
        }

        assembly {
            // Memory address of the buffer data
            let bufptr := mload(buf)
            // Address = buffer address + sizeof(buffer length) + off
            let dest := add(add(bufptr, off), 32)
            mstore8(dest, data)
            // Update buffer length if we extended it
            if gt(offPlusOne, mload(bufptr)) {
                mstore(bufptr, offPlusOne)
            }
        }

        return buf;
    }

    /**
    * @dev Appends len bytes of bytes32 to a buffer. Resizes if doing so would
    *      exceed the capacity of the buffer.
    * @param buf The buffer to append to.
    * @param data The data to append.
    * @param len The number of bytes to write (left-aligned).
    * @return The original buffer, for chaining.
    */
    function append(buffer memory buf, bytes32 data, uint len) private pure returns(buffer memory) {
        uint off = buf.buf.length;
        uint newCapacity = len + off;
        if (newCapacity > buf.capacity) {
            resize(buf, newCapacity * 2);
        }

        unchecked {
            uint mask = (256 ** len) - 1;
            // Right-align data
            data = data >> (8 * (32 - len));
            assembly {
                // Memory address of the buffer data
                let bufptr := mload(buf)
                // Address = buffer address + sizeof(buffer length) + newCapacity
                let dest := add(bufptr, newCapacity)
                mstore(dest, or(and(mload(dest), not(mask)), data))
                // Update buffer length if we extended it
                if gt(newCapacity, mload(bufptr)) {
                    mstore(bufptr, newCapacity)
                }
            }
        }
        return buf;
    }

    /**
    * @dev Appends a bytes20 to the buffer. Resizes if doing so would exceed
    *      the capacity of the buffer.
    * @param buf The buffer to append to.
    * @param data The data to append.
    * @return The original buffer, for chhaining.
    */
    function appendBytes20(buffer memory buf, bytes20 data) internal pure returns (buffer memory) {
        return append(buf, bytes32(data), 20);
    }

    /**
    * @dev Appends a bytes32 to the buffer. Resizes if doing so would exceed
    *      the capacity of the buffer.
    * @param buf The buffer to append to.
    * @param data The data to append.
    * @return The original buffer, for chaining.
    */
    function appendBytes32(buffer memory buf, bytes32 data) internal pure returns (buffer memory) {
        return append(buf, data, 32);
    }

    /**
     * @dev Appends a byte to the end of the buffer. Resizes if doing so would
     *      exceed the capacity of the buffer.
     * @param buf The buffer to append to.
     * @param data The data to append.
     * @param len The number of bytes to write (right-aligned).
     * @return The original buffer.
     */
    function appendInt(buffer memory buf, uint data, uint len) internal pure returns(buffer memory) {
        uint off = buf.buf.length;
        uint newCapacity = len + off;
        if (newCapacity > buf.capacity) {
            resize(buf, newCapacity * 2);
        }

        uint mask = (256 ** len) - 1;
        assembly {
            // Memory address of the buffer data
            let bufptr := mload(buf)
            // Address = buffer address + sizeof(buffer length) + newCapacity
            let dest := add(bufptr, newCapacity)
            mstore(dest, or(and(mload(dest), not(mask)), data))
            // Update buffer length if we extended it
            if gt(newCapacity, mload(bufptr)) {
                mstore(bufptr, newCapacity)
            }
        }
        return buf;
    }
}
// File: @chainlink/contracts/src/v0.8/vendor/solidity-cborutils/v2.0.0/CBOR.sol


pragma solidity ^0.8.4;


/**
* @dev A library for populating CBOR encoded payload in Solidity.
*
* https://datatracker.ietf.org/doc/html/rfc7049
*
* The library offers various write* and start* methods to encode values of different types.
* The resulted buffer can be obtained with data() method.
* Encoding of primitive types is staightforward, whereas encoding of sequences can result
* in an invalid CBOR if start/write/end flow is violated.
* For the purpose of gas saving, the library does not verify start/write/end flow internally,
* except for nested start/end pairs.
*/

library CBOR {
    using Buffer for Buffer.buffer;

    struct CBORBuffer {
        Buffer.buffer buf;
        uint256 depth;
    }

    uint8 private constant MAJOR_TYPE_INT = 0;
    uint8 private constant MAJOR_TYPE_NEGATIVE_INT = 1;
    uint8 private constant MAJOR_TYPE_BYTES = 2;
    uint8 private constant MAJOR_TYPE_STRING = 3;
    uint8 private constant MAJOR_TYPE_ARRAY = 4;
    uint8 private constant MAJOR_TYPE_MAP = 5;
    uint8 private constant MAJOR_TYPE_TAG = 6;
    uint8 private constant MAJOR_TYPE_CONTENT_FREE = 7;

    uint8 private constant TAG_TYPE_BIGNUM = 2;
    uint8 private constant TAG_TYPE_NEGATIVE_BIGNUM = 3;

    uint8 private constant CBOR_FALSE = 20;
    uint8 private constant CBOR_TRUE = 21;
    uint8 private constant CBOR_NULL = 22;
    uint8 private constant CBOR_UNDEFINED = 23;

    function create(uint256 capacity) internal pure returns(CBORBuffer memory cbor) {
        Buffer.init(cbor.buf, capacity);
        cbor.depth = 0;
        return cbor;
    }

    function data(CBORBuffer memory buf) internal pure returns(bytes memory) {
        require(buf.depth == 0, "Invalid CBOR");
        return buf.buf.buf;
    }

    function writeUInt256(CBORBuffer memory buf, uint256 value) internal pure {
        buf.buf.appendUint8(uint8((MAJOR_TYPE_TAG << 5) | TAG_TYPE_BIGNUM));
        writeBytes(buf, abi.encode(value));
    }

    function writeInt256(CBORBuffer memory buf, int256 value) internal pure {
        if (value < 0) {
            buf.buf.appendUint8(
                uint8((MAJOR_TYPE_TAG << 5) | TAG_TYPE_NEGATIVE_BIGNUM)
            );
            writeBytes(buf, abi.encode(uint256(-1 - value)));
        } else {
            writeUInt256(buf, uint256(value));
        }
    }

    function writeUInt64(CBORBuffer memory buf, uint64 value) internal pure {
        writeFixedNumeric(buf, MAJOR_TYPE_INT, value);
    }

    function writeInt64(CBORBuffer memory buf, int64 value) internal pure {
        if(value >= 0) {
            writeFixedNumeric(buf, MAJOR_TYPE_INT, uint64(value));
        } else{
            writeFixedNumeric(buf, MAJOR_TYPE_NEGATIVE_INT, uint64(-1 - value));
        }
    }

    function writeBytes(CBORBuffer memory buf, bytes memory value) internal pure {
        writeFixedNumeric(buf, MAJOR_TYPE_BYTES, uint64(value.length));
        buf.buf.append(value);
    }

    function writeString(CBORBuffer memory buf, string memory value) internal pure {
        writeFixedNumeric(buf, MAJOR_TYPE_STRING, uint64(bytes(value).length));
        buf.buf.append(bytes(value));
    }

    function writeBool(CBORBuffer memory buf, bool value) internal pure {
        writeContentFree(buf, value ? CBOR_TRUE : CBOR_FALSE);
    }

    function writeNull(CBORBuffer memory buf) internal pure {
        writeContentFree(buf, CBOR_NULL);
    }

    function writeUndefined(CBORBuffer memory buf) internal pure {
        writeContentFree(buf, CBOR_UNDEFINED);
    }

    function startArray(CBORBuffer memory buf) internal pure {
        writeIndefiniteLengthType(buf, MAJOR_TYPE_ARRAY);
        buf.depth += 1;
    }

    function startFixedArray(CBORBuffer memory buf, uint64 length) internal pure {
        writeDefiniteLengthType(buf, MAJOR_TYPE_ARRAY, length);
    }

    function startMap(CBORBuffer memory buf) internal pure {
        writeIndefiniteLengthType(buf, MAJOR_TYPE_MAP);
        buf.depth += 1;
    }

    function startFixedMap(CBORBuffer memory buf, uint64 length) internal pure {
        writeDefiniteLengthType(buf, MAJOR_TYPE_MAP, length);
    }

    function endSequence(CBORBuffer memory buf) internal pure {
        writeIndefiniteLengthType(buf, MAJOR_TYPE_CONTENT_FREE);
        buf.depth -= 1;
    }

    function writeKVString(CBORBuffer memory buf, string memory key, string memory value) internal pure {
        writeString(buf, key);
        writeString(buf, value);
    }

    function writeKVBytes(CBORBuffer memory buf, string memory key, bytes memory value) internal pure {
        writeString(buf, key);
        writeBytes(buf, value);
    }

    function writeKVUInt256(CBORBuffer memory buf, string memory key, uint256 value) internal pure {
        writeString(buf, key);
        writeUInt256(buf, value);
    }

    function writeKVInt256(CBORBuffer memory buf, string memory key, int256 value) internal pure {
        writeString(buf, key);
        writeInt256(buf, value);
    }

    function writeKVUInt64(CBORBuffer memory buf, string memory key, uint64 value) internal pure {
        writeString(buf, key);
        writeUInt64(buf, value);
    }

    function writeKVInt64(CBORBuffer memory buf, string memory key, int64 value) internal pure {
        writeString(buf, key);
        writeInt64(buf, value);
    }

    function writeKVBool(CBORBuffer memory buf, string memory key, bool value) internal pure {
        writeString(buf, key);
        writeBool(buf, value);
    }

    function writeKVNull(CBORBuffer memory buf, string memory key) internal pure {
        writeString(buf, key);
        writeNull(buf);
    }

    function writeKVUndefined(CBORBuffer memory buf, string memory key) internal pure {
        writeString(buf, key);
        writeUndefined(buf);
    }

    function writeKVMap(CBORBuffer memory buf, string memory key) internal pure {
        writeString(buf, key);
        startMap(buf);
    }

    function writeKVArray(CBORBuffer memory buf, string memory key) internal pure {
        writeString(buf, key);
        startArray(buf);
    }

    function writeFixedNumeric(
        CBORBuffer memory buf,
        uint8 major,
        uint64 value
    ) private pure {
        if (value <= 23) {
            buf.buf.appendUint8(uint8((major << 5) | value));
        } else if (value <= 0xFF) {
            buf.buf.appendUint8(uint8((major << 5) | 24));
            buf.buf.appendInt(value, 1);
        } else if (value <= 0xFFFF) {
            buf.buf.appendUint8(uint8((major << 5) | 25));
            buf.buf.appendInt(value, 2);
        } else if (value <= 0xFFFFFFFF) {
            buf.buf.appendUint8(uint8((major << 5) | 26));
            buf.buf.appendInt(value, 4);
        } else {
            buf.buf.appendUint8(uint8((major << 5) | 27));
            buf.buf.appendInt(value, 8);
        }
    }

    function writeIndefiniteLengthType(CBORBuffer memory buf, uint8 major)
        private
        pure
    {
        buf.buf.appendUint8(uint8((major << 5) | 31));
    }

    function writeDefiniteLengthType(CBORBuffer memory buf, uint8 major, uint64 length)
        private
        pure
    {
        writeFixedNumeric(buf, major, length);
    }

    function writeContentFree(CBORBuffer memory buf, uint8 value) private pure {
        buf.buf.appendUint8(uint8((MAJOR_TYPE_CONTENT_FREE << 5) | value));
    }
}
// File: @chainlink/contracts/src/v0.8/functions/v1_0_0/libraries/FunctionsRequest.sol


pragma solidity ^0.8.19;


/// @title Library for encoding the input data of a Functions request into CBOR
library FunctionsRequest {
  using CBOR for CBOR.CBORBuffer;

  uint16 public constant REQUEST_DATA_VERSION = 1;
  uint256 internal constant DEFAULT_BUFFER_SIZE = 256;

  enum Location {
    Inline, // Provided within the Request
    Remote, // Hosted through remote location that can be accessed through a provided URL
    DONHosted // Hosted on the DON's storage
  }

  enum CodeLanguage {
    JavaScript
    // In future version we may add other languages
  }

  struct Request {
    Location codeLocation; // ════════════╸ The location of the source code that will be executed on each node in the DON
    Location secretsLocation; // ═════════╸ The location of secrets that will be passed into the source code. *Only Remote secrets are supported
    CodeLanguage language; // ════════════╸ The coding language that the source code is written in
    string source; // ════════════════════╸ Raw source code for Request.codeLocation of Location.Inline, URL for Request.codeLocation of Location.Remote, or slot decimal number for Request.codeLocation of Location.DONHosted
    bytes encryptedSecretsReference; // ══╸ Encrypted URLs for Request.secretsLocation of Location.Remote (use addSecretsReference()), or CBOR encoded slotid+version for Request.secretsLocation of Location.DONHosted (use addDONHostedSecrets())
    string[] args; // ════════════════════╸ String arguments that will be passed into the source code
    bytes[] bytesArgs; // ════════════════╸ Bytes arguments that will be passed into the source code
  }

  error EmptySource();
  error EmptySecrets();
  error EmptyArgs();
  error NoInlineSecrets();

  /// @notice Encodes a Request to CBOR encoded bytes
  /// @param self The request to encode
  /// @return CBOR encoded bytes
  function encodeCBOR(Request memory self) internal pure returns (bytes memory) {
    CBOR.CBORBuffer memory buffer = CBOR.create(DEFAULT_BUFFER_SIZE);

    buffer.writeString("codeLocation");
    buffer.writeUInt256(uint256(self.codeLocation));

    buffer.writeString("language");
    buffer.writeUInt256(uint256(self.language));

    buffer.writeString("source");
    buffer.writeString(self.source);

    if (self.args.length > 0) {
      buffer.writeString("args");
      buffer.startArray();
      for (uint256 i = 0; i < self.args.length; ++i) {
        buffer.writeString(self.args[i]);
      }
      buffer.endSequence();
    }

    if (self.encryptedSecretsReference.length > 0) {
      if (self.secretsLocation == Location.Inline) {
        revert NoInlineSecrets();
      }
      buffer.writeString("secretsLocation");
      buffer.writeUInt256(uint256(self.secretsLocation));
      buffer.writeString("secrets");
      buffer.writeBytes(self.encryptedSecretsReference);
    }

    if (self.bytesArgs.length > 0) {
      buffer.writeString("bytesArgs");
      buffer.startArray();
      for (uint256 i = 0; i < self.bytesArgs.length; ++i) {
        buffer.writeBytes(self.bytesArgs[i]);
      }
      buffer.endSequence();
    }

    return buffer.buf.buf;
  }

  /// @notice Initializes a Chainlink Functions Request
  /// @dev Sets the codeLocation and code on the request
  /// @param self The uninitialized request
  /// @param codeLocation The user provided source code location
  /// @param language The programming language of the user code
  /// @param source The user provided source code or a url
  function initializeRequest(
    Request memory self,
    Location codeLocation,
    CodeLanguage language,
    string memory source
  ) internal pure {
    if (bytes(source).length == 0) revert EmptySource();

    self.codeLocation = codeLocation;
    self.language = language;
    self.source = source;
  }

  /// @notice Initializes a Chainlink Functions Request
  /// @dev Simplified version of initializeRequest for PoC
  /// @param self The uninitialized request
  /// @param javaScriptSource The user provided JS code (must not be empty)
  function initializeRequestForInlineJavaScript(Request memory self, string memory javaScriptSource) internal pure {
    initializeRequest(self, Location.Inline, CodeLanguage.JavaScript, javaScriptSource);
  }

  /// @notice Adds Remote user encrypted secrets to a Request
  /// @param self The initialized request
  /// @param encryptedSecretsReference Encrypted comma-separated string of URLs pointing to off-chain secrets
  function addSecretsReference(Request memory self, bytes memory encryptedSecretsReference) internal pure {
    if (encryptedSecretsReference.length == 0) revert EmptySecrets();

    self.secretsLocation = Location.Remote;
    self.encryptedSecretsReference = encryptedSecretsReference;
  }

  /// @notice Adds DON-hosted secrets reference to a Request
  /// @param self The initialized request
  /// @param slotID Slot ID of the user's secrets hosted on DON
  /// @param version User data version (for the slotID)
  function addDONHostedSecrets(Request memory self, uint8 slotID, uint64 version) internal pure {
    CBOR.CBORBuffer memory buffer = CBOR.create(DEFAULT_BUFFER_SIZE);

    buffer.writeString("slotID");
    buffer.writeUInt64(slotID);
    buffer.writeString("version");
    buffer.writeUInt64(version);

    self.secretsLocation = Location.DONHosted;
    self.encryptedSecretsReference = buffer.buf.buf;
  }

  /// @notice Sets args for the user run function
  /// @param self The initialized request
  /// @param args The array of string args (must not be empty)
  function setArgs(Request memory self, string[] memory args) internal pure {
    if (args.length == 0) revert EmptyArgs();

    self.args = args;
  }

  /// @notice Sets bytes args for the user run function
  /// @param self The initialized request
  /// @param args The array of bytes args (must not be empty)
  function setBytesArgs(Request memory self, bytes[] memory args) internal pure {
    if (args.length == 0) revert EmptyArgs();

    self.bytesArgs = args;
  }
}

// File: @chainlink/contracts/src/v0.8/functions/v1_0_0/interfaces/IFunctionsClient.sol


pragma solidity ^0.8.19;

/// @title Chainlink Functions client interface.
interface IFunctionsClient {
  /// @notice Chainlink Functions response handler called by the Functions Router
  /// during fullilment from the designated transmitter node in an OCR round.
  /// @param requestId The requestId returned by FunctionsClient.sendRequest().
  /// @param response Aggregated response from the request's source code.
  /// @param err Aggregated error either from the request's source code or from the execution pipeline.
  /// @dev Either response or error parameter will be set, but never both.
  function handleOracleFulfillment(bytes32 requestId, bytes memory response, bytes memory err) external;
}

// File: @chainlink/contracts/src/v0.8/functions/v1_0_0/libraries/FunctionsResponse.sol


pragma solidity ^0.8.19;

/// @title Library of types that are used for fulfillment of a Functions request
library FunctionsResponse {
  // Used to send request information from the Router to the Coordinator
  struct RequestMeta {
    bytes data; // ══════════════════╸ CBOR encoded Chainlink Functions request data, use FunctionsRequest library to encode a request
    bytes32 flags; // ═══════════════╸ Per-subscription flags
    address requestingContract; // ══╗ The client contract that is sending the request
    uint96 availableBalance; // ═════╝ Common LINK balance of the subscription that is controlled by the Router to be used for all consumer requests.
    uint72 adminFee; // ═════════════╗ Flat fee (in Juels of LINK) that will be paid to the Router Owner for operation of the network
    uint64 subscriptionId; //        ║ Identifier of the billing subscription that will be charged for the request
    uint64 initiatedRequests; //     ║ The number of requests that have been started
    uint32 callbackGasLimit; //      ║ The amount of gas that the callback to the consuming contract will be given
    uint16 dataVersion; // ══════════╝ The version of the structure of the CBOR encoded request data
    uint64 completedRequests; // ════╗ The number of requests that have successfully completed or timed out
    address subscriptionOwner; // ═══╝ The owner of the billing subscription
  }

  enum FulfillResult {
    FULFILLED, // 0
    USER_CALLBACK_ERROR, // 1
    INVALID_REQUEST_ID, // 2
    COST_EXCEEDS_COMMITMENT, // 3
    INSUFFICIENT_GAS_PROVIDED, // 4
    SUBSCRIPTION_BALANCE_INVARIANT_VIOLATION, // 5
    INVALID_COMMITMENT // 6
  }

  struct Commitment {
    bytes32 requestId; // ═════════════════╸ A unique identifier for a Chainlink Functions request
    address coordinator; // ═══════════════╗ The Coordinator contract that manages the DON that is servicing a request
    uint96 estimatedTotalCostJuels; // ════╝ The maximum cost in Juels (1e18) of LINK that will be charged to fulfill a request
    address client; // ════════════════════╗ The client contract that sent the request
    uint64 subscriptionId; //              ║ Identifier of the billing subscription that will be charged for the request
    uint32 callbackGasLimit; // ═══════════╝ The amount of gas that the callback to the consuming contract will be given
    uint72 adminFee; // ═══════════════════╗ Flat fee (in Juels of LINK) that will be paid to the Router Owner for operation of the network
    uint72 donFee; //                      ║ Fee (in Juels of LINK) that will be split between Node Operators for servicing a request
    uint40 gasOverheadBeforeCallback; //   ║ Represents the average gas execution cost before the fulfillment callback.
    uint40 gasOverheadAfterCallback; //    ║ Represents the average gas execution cost after the fulfillment callback.
    uint32 timeoutTimestamp; // ═══════════╝ The timestamp at which a request will be eligible to be timed out
  }
}

// File: @chainlink/contracts/src/v0.8/functions/v1_0_0/interfaces/IFunctionsRouter.sol


pragma solidity ^0.8.19;


/// @title Chainlink Functions Router interface.
interface IFunctionsRouter {
  /// @notice The identifier of the route to retrieve the address of the access control contract
  /// The access control contract controls which accounts can manage subscriptions
  /// @return id - bytes32 id that can be passed to the "getContractById" of the Router
  function getAllowListId() external view returns (bytes32);

  /// @notice Set the identifier of the route to retrieve the address of the access control contract
  /// The access control contract controls which accounts can manage subscriptions
  function setAllowListId(bytes32 allowListId) external;

  /// @notice Get the flat fee (in Juels of LINK) that will be paid to the Router owner for operation of the network
  /// @return adminFee
  function getAdminFee() external view returns (uint72 adminFee);

  /// @notice Sends a request using the provided subscriptionId
  /// @param subscriptionId - A unique subscription ID allocated by billing system,
  /// a client can make requests from different contracts referencing the same subscription
  /// @param data - CBOR encoded Chainlink Functions request data, use FunctionsClient API to encode a request
  /// @param dataVersion - Gas limit for the fulfillment callback
  /// @param callbackGasLimit - Gas limit for the fulfillment callback
  /// @param donId - An identifier used to determine which route to send the request along
  /// @return requestId - A unique request identifier
  function sendRequest(
    uint64 subscriptionId,
    bytes calldata data,
    uint16 dataVersion,
    uint32 callbackGasLimit,
    bytes32 donId
  ) external returns (bytes32);

  /// @notice Sends a request to the proposed contracts
  /// @param subscriptionId - A unique subscription ID allocated by billing system,
  /// a client can make requests from different contracts referencing the same subscription
  /// @param data - CBOR encoded Chainlink Functions request data, use FunctionsClient API to encode a request
  /// @param dataVersion - Gas limit for the fulfillment callback
  /// @param callbackGasLimit - Gas limit for the fulfillment callback
  /// @param donId - An identifier used to determine which route to send the request along
  /// @return requestId - A unique request identifier
  function sendRequestToProposed(
    uint64 subscriptionId,
    bytes calldata data,
    uint16 dataVersion,
    uint32 callbackGasLimit,
    bytes32 donId
  ) external returns (bytes32);

  /// @notice Fulfill the request by:
  /// - calling back the data that the Oracle returned to the client contract
  /// - pay the DON for processing the request
  /// @dev Only callable by the Coordinator contract that is saved in the commitment
  /// @param response response data from DON consensus
  /// @param err error from DON consensus
  /// @param juelsPerGas - current rate of juels/gas
  /// @param costWithoutFulfillment - The cost of processing the request (in Juels of LINK ), without fulfillment
  /// @param transmitter - The Node that transmitted the OCR report
  /// @param commitment - The parameters of the request that must be held consistent between request and response time
  /// @return fulfillResult -
  /// @return callbackGasCostJuels -
  function fulfill(
    bytes memory response,
    bytes memory err,
    uint96 juelsPerGas,
    uint96 costWithoutFulfillment,
    address transmitter,
    FunctionsResponse.Commitment memory commitment
  ) external returns (FunctionsResponse.FulfillResult, uint96);

  /// @notice Validate requested gas limit is below the subscription max.
  /// @param subscriptionId subscription ID
  /// @param callbackGasLimit desired callback gas limit
  function isValidCallbackGasLimit(uint64 subscriptionId, uint32 callbackGasLimit) external view;

  /// @notice Get the current contract given an ID
  /// @param id A bytes32 identifier for the route
  /// @return contract The current contract address
  function getContractById(bytes32 id) external view returns (address);

  /// @notice Get the proposed next contract given an ID
  /// @param id A bytes32 identifier for the route
  /// @return contract The current or proposed contract address
  function getProposedContractById(bytes32 id) external view returns (address);

  /// @notice Return the latest proprosal set
  /// @return ids The identifiers of the contracts to update
  /// @return to The addresses of the contracts that will be updated to
  function getProposedContractSet() external view returns (bytes32[] memory, address[] memory);

  /// @notice Proposes one or more updates to the contract routes
  /// @dev Only callable by owner
  function proposeContractsUpdate(bytes32[] memory proposalSetIds, address[] memory proposalSetAddresses) external;

  /// @notice Updates the current contract routes to the proposed contracts
  /// @dev Only callable by owner
  function updateContracts() external;

  /// @dev Puts the system into an emergency stopped state.
  /// @dev Only callable by owner
  function pause() external;

  /// @dev Takes the system out of an emergency stopped state.
  /// @dev Only callable by owner
  function unpause() external;
}

// File: @chainlink/contracts/src/v0.8/functions/v1_0_0/FunctionsClient.sol


pragma solidity ^0.8.19;




/// @title The Chainlink Functions client contract
/// @notice Contract developers can inherit this contract in order to make Chainlink Functions requests
abstract contract FunctionsClient is IFunctionsClient {
  using FunctionsRequest for FunctionsRequest.Request;

  IFunctionsRouter internal immutable i_router;

  event RequestSent(bytes32 indexed id);
  event RequestFulfilled(bytes32 indexed id);

  error OnlyRouterCanFulfill();

  constructor(address router) {
    i_router = IFunctionsRouter(router);
  }

  /// @notice Sends a Chainlink Functions request
  /// @param data The CBOR encoded bytes data for a Functions request
  /// @param subscriptionId The subscription ID that will be charged to service the request
  /// @param callbackGasLimit the amount of gas that will be available for the fulfillment callback
  /// @return requestId The generated request ID for this request
  function _sendRequest(
    bytes memory data,
    uint64 subscriptionId,
    uint32 callbackGasLimit,
    bytes32 donId
  ) internal returns (bytes32) {
    bytes32 requestId = i_router.sendRequest(
      subscriptionId,
      data,
      FunctionsRequest.REQUEST_DATA_VERSION,
      callbackGasLimit,
      donId
    );
    emit RequestSent(requestId);
    return requestId;
  }

  /// @notice User defined function to handle a response from the DON
  /// @param requestId The request ID, returned by sendRequest()
  /// @param response Aggregated response from the execution of the user's source code
  /// @param err Aggregated error from the execution of the user code or from the execution pipeline
  /// @dev Either response or error parameter will be set, but never both
  function fulfillRequest(bytes32 requestId, bytes memory response, bytes memory err) internal virtual;

  /// @inheritdoc IFunctionsClient
  function handleOracleFulfillment(bytes32 requestId, bytes memory response, bytes memory err) external override {
    if (msg.sender != address(i_router)) {
      revert OnlyRouterCanFulfill();
    }
    fulfillRequest(requestId, response, err);
    emit RequestFulfilled(requestId);
  }
}

// File: @chainlink/contracts@1.1.0/src/v0.8/shared/interfaces/LinkTokenInterface.sol


pragma solidity ^0.8.0;

interface LinkTokenInterface {
  function allowance(address owner, address spender) external view returns (uint256 remaining);

  function approve(address spender, uint256 value) external returns (bool success);

  function balanceOf(address owner) external view returns (uint256 balance);

  function decimals() external view returns (uint8 decimalPlaces);

  function decreaseApproval(address spender, uint256 addedValue) external returns (bool success);

  function increaseApproval(address spender, uint256 subtractedValue) external;

  function name() external view returns (string memory tokenName);

  function symbol() external view returns (string memory tokenSymbol);

  function totalSupply() external view returns (uint256 totalTokensIssued);

  function transfer(address to, uint256 value) external returns (bool success);

  function transferAndCall(address to, uint256 value, bytes calldata data) external returns (bool success);

  function transferFrom(address from, address to, uint256 value) external returns (bool success);
}

// File: smart-contracts/StekcitBM.sol



pragma solidity 0.8.19;








contract StekcitBM is FunctionsClient, VRFConsumerBaseV2Plus {
    using FunctionsRequest for FunctionsRequest.Request;

    StekcitUser[] private allStekcitUsers;
    StekcitEvent[] private allStekcitEvents;
    StekcitTicket[] private allStekcitTickets;
    StekcitPayout[] private allStekcitPayouts;
    // StekcitFunctionsError[] public allStekcitFunctionsErrors;

    address public stekcitBMOwnerAddress;

    bytes public lastFunctionsError;

    uint256 immutable vrfV2SubscriptionId;

    uint256 private currentUserId;
    uint256 private currentEventId;
    uint256 private currentTicketId;
    uint256 private currentPayoutId;
    uint256 private currentFunctionsErrorId;

    ERC20 USDC = ERC20(0x5425890298aed601595a70AB815c96711a31Bc65);

    // LINK on Fuji
    address linkAddress = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;

    // Chainlink VRF V2 - Coordinator address for Avalanche Fuji
    address vrfCoordinator = 0x5C210eF41CD1a72de73bF76eC39637bB0d3d7BEE;

    // Chainlink Functions - Router address for Avalanche Fuji
    address router = 0xA9d587a00A31A52Ed70D6026794a8FC5E2F5dCb0;

    // Chainlink VRF V2 - 300 gwei Key Hash
    bytes32 vrfV2KeyHash =
        0xc799bd1e3bd4d1a41cd4968997a4e03dfd2a3c7c04b695881138580163f42887;

    constructor(address _stekcitBMOwnerAddress, uint256 _vrfV2SubscriptionId)
        FunctionsClient(router)
        VRFConsumerBaseV2Plus(vrfCoordinator)
    {
        stekcitBMOwnerAddress = _stekcitBMOwnerAddress;
        vrfV2SubscriptionId = _vrfV2SubscriptionId;
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

        StekcitUser memory newUser = getUserById(newUserId);

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
        uint256 runningEventId = 0;
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
                eventsOfCreatingUser[runningEventId] = currentEvent;
                runningEventId++;
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
        bool _forImmediatePublishing // returns ( //     // onlyExistingUser //     // onlyCreatingUser(msg.sender) //     StekcitEvent memory // )
    ) public {
        uint256 newEventId = currentEventId;
        uint256 createdAt = block.timestamp;
        uint256 updatedAt = block.timestamp;
        uint256 amountInEthers = _amount * (10**USDC.decimals());

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

        // return getEventById(newEventId);
    }

    // function getTicketById(uint256 _ticketId)
    //     public
    //     view
    //     returns (StekcitTicket memory)
    // {
    //     return allStekcitTickets[_ticketId];
    // }

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

    // function getTicketByEventIdAndWalletAddress(
    //     uint256 _eventId,
    //     address _walletAddress
    // ) public view returns (StekcitTicket memory) {
    //     for (
    //         uint256 ticketId = 0;
    //         ticketId < allStekcitTickets.length;
    //         ticketId++
    //     ) {
    //         StekcitTicket memory currentTicket = allStekcitTickets[ticketId];
    //         if (
    //             currentTicket.eventId == _eventId &&
    //             currentTicket.attendingUserWalletAddress == _walletAddress
    //         ) {
    //             return currentTicket;
    //         }
    //     }

    //     StekcitTicket memory blankTicket;
    //     blankTicket.isBlank = true;
    //     return blankTicket;
    // }

    function setVerificationRequestIdForTicket(
        uint256 _ticketId,
        uint256 _verificationRequestId
    ) private returns (StekcitTicket memory) {
        StekcitTicket memory updatedTicket = allStekcitTickets[_ticketId];

        updatedTicket.verificationRequestId = _verificationRequestId;

        allStekcitTickets[_ticketId] = updatedTicket;

        return updatedTicket;
    }

    function setVerificationIdForTicket(
        uint256 _ticketId,
        uint256 _verificationId
    ) private returns (StekcitTicket memory) {
        StekcitTicket memory updatedTicket = allStekcitTickets[_ticketId];

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

    function createTicketForUser(
        uint256 _eventId // returns ( //     // onlyExistingUser //     StekcitTicket memory // )
    ) public {
        StekcitEvent memory currentEvent = allStekcitEvents[_eventId];

        bool ticketOfUserForThisEventExists = checkIfTicketOfUserForThisEventExists(
                _eventId
            );

        if (ticketOfUserForThisEventExists) {
            revert("Ticket already exists");
            // return getTicketByEventIdAndWalletAddress(_eventId, msg.sender);
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

        // return getTicketById(newTicketId);
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

    function processPayout(uint256 _eventId) public {
        // Check if event has already been paid out (if payout exists)
        StekcitEvent memory eventToBePaidOut = allStekcitEvents[_eventId];

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
        bool isCreatingUserPaid = USDC.transfer(
            eventToBePaidOut.creatingUserWalletAddress,
            totalAmountToBePaidOutToCreatingUser
        );

        if (isCreatingUserPaid) {
            uint256 amountToBePaidOutToStekcitBMOwner = (amountPaidToEventInEthers *
                    20) / 100;

            // Transfer to stekcitBMOwner

            bool isStekcitBMOwnerPaid = USDC.transfer(
                stekcitBMOwnerAddress,
                amountToBePaidOutToStekcitBMOwner
            );

            if (isStekcitBMOwnerPaid) {
                // Mark the event as ended and as paid out
                eventToBePaidOut.isEnded = true;
                eventToBePaidOut.isPaidOut = true;
                allStekcitEvents[_eventId] = eventToBePaidOut;

                uint256 newPayoutId = currentPayoutId;

                allStekcitPayouts.push(
                    StekcitPayout(
                        newPayoutId,
                        _eventId,
                        msg.sender,
                        totalAmountToBePaidOutToCreatingUser,
                        block.timestamp,
                        false
                    )
                );

                currentPayoutId++;
            }
        }
    }

    // function createPayout(uint256 _eventId, uint256 _amount)
    //     private
    //     returns (
    //         // onlyCreatingUserOfEvent(_eventId)
    //         StekcitPayout memory
    //     )
    // {

    //     return getPayoutById(newPayoutId);
    // }

    // function getPayoutById(uint256 _payoutId)
    //     public
    //     view
    //     returns (StekcitPayout memory)
    // {
    //     return allStekcitPayouts[_payoutId];
    // }

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
        uint256 userId = abi.decode(response, (uint256));

        StekcitUser memory updatedUser = allStekcitUsers[userId];

        if (!updatedUser.isBlank) {
            updatedUser.isWelcomeEmailSent = true;
            updatedUser.welcomeEmailVerificationId = requestId;
            allStekcitUsers[userId] = updatedUser;
        }

        lastFunctionsError = err;

        // updateWelcomeEmailVerificationId(userId, isWelcomeEmailSent, requestId);

        // createFunctionsError(err);
    }

    // function updateWelcomeEmailVerificationId(
    //     uint256 _userId,
    //     bool _isWelcomeEmailSent,
    //     bytes32 _welcomeEmailVerificationId
    // ) private returns (bool) {
    //     return false;
    // }

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

    function verifyEventAndSetVerificationRequestId(uint256 _eventId)
        public
        returns (StekcitEvent memory)
    {
        uint256 eventVerificationId = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: vrfV2KeyHash,
                subId: vrfV2SubscriptionId,
                requestConfirmations: 1,
                callbackGasLimit: 100000,
                numWords: 1,
                // Set nativePayment to true to pay for VRF requests with Sepolia ETH instead of LINK
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            })
        );

        return setVerificationRequestIdForEvent(_eventId, eventVerificationId);
    }

    function verifyTicketAndSetVerificationRequestId(uint256 _ticketId)
        public
        returns (StekcitTicket memory)
    {
        uint256 ticketVerificationId = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: vrfV2KeyHash,
                subId: vrfV2SubscriptionId,
                requestConfirmations: 1,
                callbackGasLimit: 100000,
                numWords: 1,
                // Set nativePayment to true to pay for VRF requests with Sepolia ETH instead of LINK
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            })
        );
        return
            setVerificationRequestIdForTicket(_ticketId, ticketVerificationId);
    }

    // Callback for Chainlink VRF
    function fulfillRandomWords(
        uint256 _requestId,
        uint256[] calldata _randomWords
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
