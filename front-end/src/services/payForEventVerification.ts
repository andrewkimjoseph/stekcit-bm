import { USDCFujiContractABI } from "@/utils/abis/USDCFujiContractABI";
import { USDCFujiContractAddress } from "@/utils/addresses/USDCFujiContractAddress";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import {
    createPublicClient,
    createWalletClient,
    custom,

} from "viem";
import { avalancheFuji } from "viem/chains";

export const payForEventVerification = async (
    _signerAddress: `0x${string}` | undefined,
    { _amount }: PayForVerificationProps
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
            const payForEventVerificationTxnHash = await privateClient.writeContract({
                account: address,
                address: USDCFujiContractAddress,
                abi: USDCFujiContractABI,
                functionName: "transfer",
                args: [stekcitBMContractAddress, _amount],
            });

            const payForEventVerificationTxnReceipt =
                await publicClient.waitForTransactionReceipt({
                    hash: payForEventVerificationTxnHash,
                });

            if (payForEventVerificationTxnReceipt.status == "success") {
                return true;
            }
            return false;

        } catch (error) {
            return false;
        }
    }
    return false;
};

type PayForVerificationProps = {
    _amount: number;
};
