import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import {
    createPublicClient,
    createWalletClient,
    custom
} from "viem";
import { avalancheFuji } from "viem/chains";

export const verifyTicketAndSetVerificationRequestId = async (
    _signerAddress: `0x${string}` | undefined,
    { _ticketId }: VerifyTicketProps
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
            const verifyEventTxnHash = await privateClient.writeContract({
                account: address,
                address: stekcitBMContractAddress,
                abi: stekcitBMContractABI,
                functionName: "verifyTicketAndSetVerificationRequestId",
                args: [_ticketId],
            });

            console.log(verifyEventTxnHash);



        const verifyEventTxnReceipt = await
                 publicClient.waitForTransactionReceipt({
                    hash: verifyEventTxnHash
                    
                });

                console.log(verifyEventTxnReceipt);

            if (verifyEventTxnReceipt.status == "success") {
                return true;
            }
            return false;

        } catch (error) {
            return false;
        }
    }
    return false;
};

export type VerifyTicketProps = {
    _ticketId: number;
};
