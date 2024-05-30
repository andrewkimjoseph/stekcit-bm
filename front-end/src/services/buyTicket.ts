import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import {
    createPublicClient,
    createWalletClient,
    custom
} from "viem";
import { avalancheFuji } from "viem/chains";

export const buyTicket = async (
    _signerAddress: `0x${string}` | undefined,
    { _eventId }: BuyTicketProps
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
            const buyTicketTxnHash = await privateClient.writeContract({
                account: address,
                address: stekcitBMContractAddress,
                abi: stekcitBMContractABI,
                functionName: "createTicketForUser",
                args: [_eventId],
            });

            const buyTicketTxnReceipt =
                await publicClient.waitForTransactionReceipt({
                    hash: buyTicketTxnHash,
                });

            if (buyTicketTxnReceipt.status == "success") {

                
                return true;
            }
            return false;

        } catch (error) {
            return false;
        }
    }
    return false;
};

type BuyTicketProps = {
    _eventId: number;
};
