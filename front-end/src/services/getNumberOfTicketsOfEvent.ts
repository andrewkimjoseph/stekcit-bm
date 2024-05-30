import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import { createPublicClient, custom, } from "viem";
import { avalancheFuji } from "viem/chains";

export const getNumberOfTicketsOfEvent = async (
  _signerAddress: `0x${string}` | undefined,
  { _eventId }: GetNumberOfTicketsOfEvent
): Promise<number> => {
  let fetchedNumberOfTicketsOfEvent: number = 0;
  if (window.ethereum) {
    const publicClient = createPublicClient({
      chain: avalancheFuji,
      transport: custom(window.ethereum),
    });
    try {
      fetchedNumberOfTicketsOfEvent = Number(
        (await publicClient.readContract({
          address: stekcitBMContractAddress,
          abi: stekcitBMContractABI,
          functionName: "getNumberOfTicketsOfEvent",
          args: [_eventId],
        })) ?? 0
      );

      return fetchedNumberOfTicketsOfEvent;
    } catch (err) {
      console.info(err);
      return fetchedNumberOfTicketsOfEvent;
    }
  }
  return fetchedNumberOfTicketsOfEvent;
};

 type GetNumberOfTicketsOfEvent = {
  _eventId: number;
};
