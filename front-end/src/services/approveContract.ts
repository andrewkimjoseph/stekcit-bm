import { USDCFujiContractABI } from "@/utils/abis/USDCFujiContractABI";
import { USDCFujiContractAddress } from "@/utils/addresses/USDCFujiContractAddress";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import { createPublicClient, createWalletClient, custom, parseEther } from "viem";
import { avalancheFuji } from "viem/chains";


export const approveContract = async (
    _signerAddress: `0x${string}` | undefined, { _amount }: ApproveContractProps
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
                const approveContractTxnHash = await privateClient.writeContract({
                    account: address,
                    address: USDCFujiContractAddress,
                    abi: USDCFujiContractABI,
                    functionName: "approve",
                    args: [stekcitBMContractAddress, (_amount * (10**6))],
                });

                const approveContractTxnReceipt = await publicClient.waitForTransactionReceipt({
                    hash: approveContractTxnHash
                });

                if (approveContractTxnReceipt.status == "success") {
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



export type ApproveContractProps = {
    _amount: number;
};
