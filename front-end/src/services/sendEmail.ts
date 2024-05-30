import {
  createPublicClient,
  createWalletClient,
  custom,
  http,
  parseTransaction,
  stringToHex,
} from "viem";
import { avalancheFuji } from "viem/chains";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";
import { Contract, ethers } from "ethers";

export const sendEmailViaChainlinkFunctions = async (
  _signerAddress: `0x${string}` | undefined,
  {
    _source,
    _encryptedSecretsUrls,
    _donHostedSecretsSlotId,
    _donHostedSecretsVersion,
    _args,
    _bytesArgs,
    _subscriptionId,
    _gasLimit,
    _donId,
  }: SendEmailProps
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

      console.log("Got here");
      const [address] = await privateClient.getAddresses();

      const provider = new ethers.providers.Web3Provider(window.ethereum);

      const signer = provider.getSigner(_signerAddress);

      const stekcitBMContract = new Contract(
        stekcitBMContractAddress,
        stekcitBMContractABI,
        signer
      );

      console.log("Got here also");

      const sendEmailRequestTxn = await stekcitBMContract.getEventByEventId(
        _source,
        _encryptedSecretsUrls,
        _donHostedSecretsSlotId,
        _donHostedSecretsVersion,
        _args,
        _bytesArgs,
        _subscriptionId,
        _gasLimit,
        // stringToHex(_donId, { size: 32 }),
        ethers.utils.formatBytes32String(_donId)
      );

      const sendEmailRequestTxnResult = await sendEmailRequestTxn.wait();

      console.log("Got here too");

      //   const returnValue = ethers.utils.defaultAbiCoder.decode(
      //     ["bool"],
      //   );

      const sendEmailTxnReceipt = await publicClient.waitForTransactionReceipt({
        hash: sendEmailRequestTxnResult["transactionHash"],
      });

      if (sendEmailTxnReceipt.status == "success") {
        return true;
      }

      // const sendEmailTxnHash = await privateClient.writeContract({
      //     account: address,
      //     address: stekcitBMContractAddress as `0x${string}`,
      //     abi: stekcitBMContractABI,
      //     functionName: "sendRequest",
      //     args: [
      //         _source,
      //         _encryptedSecretsUrls,
      //         _donHostedSecretsSlotId,
      //         _donHostedSecretsVersion,
      //         _args,
      //         _bytesArgs,
      //         _subscriptionId,
      //         _gasLimit,
      //         stringToHex(_donId, { size: 32 })
      //     ],
      // });

      // const sendEmailTxnReceipt =
      //     await publicClient.waitForTransactionReceipt({
      //         hash: sendEmailTxnHash,
      //     });

      // if (sendEmailTxnReceipt.status == "success") {
      //     return true;
      // }
      return false;
    } catch (error) {
      return false;
    }
  }
  return false;
};

export type SendEmailProps = {
  _source: string;
  _encryptedSecretsUrls: string;
  _donHostedSecretsSlotId: number;
  _donHostedSecretsVersion: number;
  _args: string[];
  _bytesArgs: string[];
  _subscriptionId: number;
  _gasLimit: number;
  _donId: string;
};
