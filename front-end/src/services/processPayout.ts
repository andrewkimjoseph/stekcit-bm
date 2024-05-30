import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import {
    createPublicClient,
    createWalletClient,
    custom
} from "viem";
import { avalancheFuji } from "viem/chains";

export const processPayout = async (
    _signerAddress: `0x${string}` | undefined,
    { _eventId }: ProcessPayoutProps
): Promise<boolean> => {
    if (window.ethereum) {

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
            const processPayoutTxnHash = await privateClient.writeContract({
                account: address,
                address: stekcitBMContractAddress,
                abi: stekcitBMContractABI,
                functionName: "processPayout",
                args: [_eventId],
            });

            const processPayoutTxnReceipt =
                await publicClient.waitForTransactionReceipt({
                    hash: processPayoutTxnHash,
                });

            if (processPayoutTxnReceipt.status == "success") {
                return true;
            }
            return false;

        } catch (error) {
            return false;
        }
    }
    return false;
};

type ProcessPayoutProps = {
    _eventId: number;
};
