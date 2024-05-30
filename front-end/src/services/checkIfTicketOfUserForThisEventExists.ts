import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import { createPublicClient, custom } from "viem";
import { avalancheFuji } from "viem/chains";


export const checkIfUserAlreadyHasTicket = async (
  _signerAddress: `0x${string}` | undefined,
  { _eventId }: CheckIfTicketOfUserForThisEventExists
): Promise<boolean> => {
  if (window.ethereum) {
    try {
      const publicClient = createPublicClient({
        chain: avalancheFuji,
        transport: custom(window.ethereum),
      });
      try {
        const userExists = await publicClient.readContract({
          address: stekcitBMContractAddress,
          abi: stekcitBMContractABI,
          functionName: "checkIfUserAlreadyHasTicket",
          args: [_eventId, _signerAddress],
        });
        return userExists as boolean;
      } catch (err) {
        console.error(err);
        return false;
      }
    } catch (error) {
      return false;
    }
  }
  return false;
};

type CheckIfTicketOfUserForThisEventExists = {
  _eventId: number;
};
