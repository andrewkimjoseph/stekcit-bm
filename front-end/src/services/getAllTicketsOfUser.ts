import { createPublicClient,custom } from "viem";
import { StekcitTicket } from "@/entities/stekcitTicket";
import { avalancheFuji } from "viem/chains";
import { stekcitBMContractAddress } from "@/utils/addresses/stekcitBMContractAddress";
import { stekcitBMContractABI } from "@/utils/abis/stekcitBMContractABI";

export const getAllTicketsOfUser = async (
  _signerAddress: `0x${string}` | undefined
): Promise<StekcitTicket[]> => {
  let allTicketsOfUser: StekcitTicket[] = [];
  if (window.ethereum) {
    const publicClient = createPublicClient({
      chain: avalancheFuji,
      transport: custom(window.ethereum),
    });
    try {
      const fetchedTickets = await publicClient.readContract({
        address: stekcitBMContractAddress,
        abi: stekcitBMContractABI,
        functionName: "getAllTicketsOfUser",
        args: [_signerAddress]
      }) as Array<any>;

      for (let ticketId = 0; ticketId < fetchedTickets.length; ticketId++) {
        const ticketToBeParsed = fetchedTickets[ticketId];

        const createdTicket: StekcitTicket = {
          id: Number(ticketToBeParsed["id"]),
          eventId: Number(ticketToBeParsed["eventId"]),
          attendingUserWalletAddress: ticketToBeParsed["attendingUserWalletAddress"],
          amountPaidInEthers: Number(ticketToBeParsed["amountPaidInEthers"]),
          isBlank: ticketToBeParsed["isBlank"],
          isPublished: ticketToBeParsed["isPublished"]
        }

        allTicketsOfUser.push(createdTicket);
      }

      return allTicketsOfUser;
    } catch (err) {
      console.info(err);
      return allTicketsOfUser;
    }
  }
  return allTicketsOfUser;
};
