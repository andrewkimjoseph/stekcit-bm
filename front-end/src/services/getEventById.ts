import { createPublicClient, custom } from "viem";
import { avalancheFuji } from "viem/chains";
import { StekcitEvent } from "@/entities/stekcitEvent";
import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";

export const getEventById = async (
  _signerAddress: `0x${string}` | undefined,
  { _eventId }: GetEventByIdProps
): Promise<StekcitEvent | null> => {
  let stekcitEvent: StekcitEvent | null = null;
  if (window.ethereum) {
    const publicClient = createPublicClient({
      chain: avalancheFuji,
      transport: custom(window.ethereum),
    });
    try {
      const fetchedStekcitEvent = await publicClient.readContract({
        address: stekcitBMContractAddress,
        abi: stekcitBMContractABI,
        functionName: "getEventById",
        args: [_eventId],
      }) as any;

      stekcitEvent = {
          id: Number(fetchedStekcitEvent["id"]),
          creatingUserWalletAddress: fetchedStekcitEvent["creatingUserWalletAddress"],
          title: fetchedStekcitEvent["title"],
          description: fetchedStekcitEvent["description"],
          link: fetchedStekcitEvent["link"],
          amountInEthers: Number(fetchedStekcitEvent["amountInEthers"]),
          createdAt: Number(fetchedStekcitEvent["createdAt"]),
          updatedAt: Number(fetchedStekcitEvent["updatedAt"]),
          dateAndTime: Number(fetchedStekcitEvent["dateAndTime"]),
          isBlank: fetchedStekcitEvent["isBlank"],
          isPublished: fetchedStekcitEvent["isPublished"],
          isVerified: fetchedStekcitEvent["isVerified"],
          verificationAmountInEthers: Number(fetchedStekcitEvent["verificationAmountInEthers"]),
          isEnded: fetchedStekcitEvent["isEnded"],
          isPaidOut: fetchedStekcitEvent["isPaidOut"],
          verificationId: Number(fetchedStekcitEvent["verificationId"]),
          verificationRequestId:  Number(fetchedStekcitEvent["verificationRequestId"])
      }

      return stekcitEvent;
    } catch (err) {
      console.info(err);
      return stekcitEvent;
    }
  }
  return null;
};

export type GetEventByIdProps = {
    _eventId: number;
};
