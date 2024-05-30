import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import { createPublicClient, createWalletClient, custom, http, parseTransaction } from "viem";
import { avalancheFuji } from "viem/chains";

export const makeCreatingUser = async (
    _signerAddress: `0x${string}` | undefined,
): Promise<boolean> => {
    if (window.ethereum) {
        try {
            const privateClient = createWalletClient({
                chain: avalancheFuji,
                transport: custom(window.ethereum),
            });
            const publicClient = createPublicClient({
                chain: avalancheFuji,
                transport: custom(window.ethereum),
            });
            const [address] = await privateClient.getAddresses();
            try {
                const createUserTxnHash = await privateClient.writeContract({
                    account: address,
                    address: stekcitBMContractAddress,
                    abi: stekcitBMContractABI,
                    functionName: "makeCreatingUser",
                });

                const createUserTxnReceipt = await publicClient.waitForTransactionReceipt({
                    hash: createUserTxnHash
                });

                if (createUserTxnReceipt.status == "success") {
                    await publicClient.readContract({
                        address: stekcitBMContractAddress,
                        abi: stekcitBMContractABI,
                        functionName: "getUserByWalletAddress",
                        args: [_signerAddress],
                    });
                    return true;
                }
                return false;
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


