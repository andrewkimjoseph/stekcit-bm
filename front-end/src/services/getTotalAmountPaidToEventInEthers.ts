import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import { createPublicClient, createWalletClient, custom, http } from "viem";
import { avalancheFuji } from "viem/chains";

export const getTotalAmountPaidToEventInEthers = async (
  _signerAddress: `0x${string}` | undefined,
  { _eventId }: GetTotalAmountPaidToEventInEthersProps
): Promise<number> => {
  let fetchedTotalAmountPaidToEventInEthers: number = 0;
  if (window.ethereum) {
    const publicClient = createPublicClient({
      chain: avalancheFuji,
      transport: custom(window.ethereum),
    });
    try {
      fetchedTotalAmountPaidToEventInEthers = Number(
        (await publicClient.readContract({
          address: stekcitBMContractAddress,
          abi: stekcitBMContractABI,
          functionName: "getTotalAmountPaidToEventInEthers",
          args: [_eventId],
        })) ?? 0
      );

      return fetchedTotalAmountPaidToEventInEthers;
    } catch (err) {
      console.info(err);
      return fetchedTotalAmountPaidToEventInEthers;
    }
  }
  return fetchedTotalAmountPaidToEventInEthers;
};

export type GetTotalAmountPaidToEventInEthersProps = {
  _eventId: number;
};
