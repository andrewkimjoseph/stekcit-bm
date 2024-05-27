import { createPublicClient, createWalletClient, custom, http } from "viem";
import { celoAlfajores } from "viem/chains";
import { privateKeyToAccount } from "viem/accounts";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";

export const checkIfUserExists = async (
  _signerAddress: `0x${string}` | undefined
): Promise<boolean> => {
  if (window.ethereum) {
    try {
      const publicClient = createPublicClient({
        chain: celoAlfajores,
        transport: custom(window.ethereum),
      });
      try {
        const userExists = await publicClient.readContract({
          address: stekcitBMContractAddress as `0x${string}`,
          abi: stekcitBMContractABI,
          functionName: "checkIfUserExists",
          args: [_signerAddress],
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
