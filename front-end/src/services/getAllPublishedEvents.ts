import { createPublicClient, custom} from "viem";
import { StekcitEvent } from "@/entities/stekcitEvent";
import { avalancheFuji } from "viem/chains";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";

export const getAllPublishedEvents = async (
  _signerAddress: `0x${string}` | undefined
): Promise<StekcitEvent[]> => {
  let allPublishedEvents: StekcitEvent[] = [];
  if (window.ethereum) {
    const publicClient = createPublicClient({
      chain: avalancheFuji,
      transport: custom(window.ethereum),
    });
    try {
      const fetchedPublishedEvents = await publicClient.readContract({
        address: stekcitBMContractAddress,
        abi: stekcitBMContractABI,
        functionName: "getAllPublishedEvents",
      }) as Array<any>;

      for (let eventId = 0; eventId < fetchedPublishedEvents.length; eventId++) {
        const eventToBeParsed = fetchedPublishedEvents[eventId];
        const publishedStekcitEvent: StekcitEvent = {
          id: Number(eventToBeParsed["id"]),
          creatingUserWalletAddress: eventToBeParsed["creatingUserWalletAddress"],
          title: eventToBeParsed["title"],
          description: eventToBeParsed["description"],
          link: eventToBeParsed["link"],
          amountInEthers: Number(eventToBeParsed["amountInEthers"]),
          createdAt: Number(eventToBeParsed["createdAt"]),
          updatedAt: Number(eventToBeParsed["updatedAt"]),
          dateAndTime: Number(eventToBeParsed["dateTime"]),
          isBlank: eventToBeParsed["isBlank"],
          isPublished: eventToBeParsed["isPublished"],
          isVerified: eventToBeParsed["isVerified"],
          verificationAmountInEthers: Number(eventToBeParsed["verificationAmountInEthers"]),
          isEnded: eventToBeParsed["isEnded"],
          isPaidOut: eventToBeParsed["isPaidOut"]
        }
        allPublishedEvents.push(publishedStekcitEvent);
      }

      return allPublishedEvents;
    } catch (err) {
      console.info(err);
      return allPublishedEvents;
    }
  }
  return allPublishedEvents;
};
