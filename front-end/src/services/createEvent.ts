import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import {
    createPublicClient,
    createWalletClient,
    custom,
} from "viem";
import { avalancheFuji } from "viem/chains";


export const createEvent = async (
    _signerAddress: `0x${string}` | undefined,
    {
        _title,
        _description,
        _link,
        _amount,
        _dateAndTime,
        _forImmediatePublishing,
    }: CreateEventProps
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
            const createEventTxnHash = await privateClient.writeContract({
                account: address,
                address: stekcitBMContractAddress,
                abi: stekcitBMContractABI,
                functionName: "createEvent",
                args: [
                    _title,
                    _description,
                    _link,
                    _amount,
                    _dateAndTime,
                    _forImmediatePublishing,
                ],
            });

            const createEventTxnReceipt =
                await publicClient.waitForTransactionReceipt({
                    hash: createEventTxnHash,
                });

            if (createEventTxnReceipt.status == "success") {
                return true;
            }
            return false;
        } catch (err) {
            console.error(err);
            return false;
        }

    }
    return false;
};

export type CreateEventProps = {
    _title: string;
    _description: string;
    _link: string;
    _amount: number;
    _dateAndTime: number;
    _forImmediatePublishing: boolean;
};
