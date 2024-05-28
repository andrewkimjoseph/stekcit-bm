import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import { createPublicClient, createWalletClient, custom, http } from "viem";
import { avalancheFuji } from "viem/chains";


export const getNumberOfTicketsOfUser = async (
  _signerAddress: `0x${string}` | undefined,
  { _walletAddress }: GetUserByWalletAddress
): Promise<number> => {
  let fetchedNumberOfTicketsOfUser: number = 0;
  if (window.ethereum) {
    const publicClient = createPublicClient({
      chain: avalancheFuji,
      transport: custom(window.ethereum),
    });
    try {
      fetchedNumberOfTicketsOfUser = Number(
        (await publicClient.readContract({
          address: stekcitBMContractAddress,
          abi: stekcitBMContractABI,
          functionName: "getNumberOfTicketsOfUser",
          args: [_walletAddress],
        })) ?? 0
      );

      return fetchedNumberOfTicketsOfUser;
    } catch (err) {
      console.info(err);
      return fetchedNumberOfTicketsOfUser;
    }
  }
  return fetchedNumberOfTicketsOfUser;
};

export type GetUserByWalletAddress = {
  _walletAddress: `0x${string}`;
};
