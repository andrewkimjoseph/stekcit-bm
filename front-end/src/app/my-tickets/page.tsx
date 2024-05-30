"use client";

import {
  Spinner,
  Text,
  Heading,
  Box,
  Button,
  Card,
  CardBody,
  Stack,
  CardHeader,
  StackDivider,
} from "@chakra-ui/react";
import { useEffect, useState } from "react";
import { useAccount } from "wagmi";
import { StekcitUser } from "@/entities/stekcitUser";
import { getUserByWalletAddress } from "@/services/getUserByWalletAddress";

import { StekcitTicket } from "@/entities/stekcitTicket";
import { getAllTicketsOfUser } from "@/services/getAllTicketsOfUser";
import {useRouter} from "next/navigation";

export default function AllEvents() {


  const { address } = useAccount();

  const [stekcitUser, setSteckitUser] = useState<StekcitUser | null>(null);

  const [allTicketsOfUser, setAllTicketsOfUser] = useState<StekcitTicket[]>([]);

  const router = useRouter();

  useEffect(() => {

    const fetchUserByWalletAddress = async () => {
      const fetchedStekcitUser = await getUserByWalletAddress(address, {
        _walletAddress: address as `0x${string}`,
      });

      setSteckitUser(fetchedStekcitUser);
    };

    const getAllTicketsOfUserAndSet = async () => {
      const fetchedTickets = await getAllTicketsOfUser(address);
      setAllTicketsOfUser(fetchedTickets);
    };
    fetchUserByWalletAddress();
    getAllTicketsOfUserAndSet();
  }, [address, stekcitUser, allTicketsOfUser]);

  if (stekcitUser?.isBlank === undefined) {
    return (
      <main className="flex h-screen items-center justify-center">
        <Spinner />
      </main>
    );
  } else {
    return (
      <main className="flex flex-col items-center">
        <Heading as="h4" size="sm" paddingBottom={4} paddingTop={4}>
          Welcome to your tickets!
        </Heading>
        <Card marginTop={8} direction={"column"}>
          <CardHeader>
            <Heading size="md">All Tickets You Bought</Heading>
          </CardHeader>

          <CardBody>
            <Stack divider={<StackDivider />} spacing="4">
              {allTicketsOfUser.length === 0 && (
                <Box>
                  <Text pt="2" fontSize="sm">
                    ...will show here
                  </Text>
                </Box>
              )}
              {allTicketsOfUser.map((ticket) => (
                  <Box key={ticket.id}>
                  <Heading size="xs" textTransform="uppercase">
                    Event id: {ticket.eventId}
                  </Heading>
                  <Text pt="2" fontSize="sm">
                    Ticket Id: {ticket.id}
                  </Text>
                  <Button
                    marginTop={4}
                    variant="outline"
                    colorScheme="blue"
                    onClick={() =>
                      router.push(
                        `/events/${ticket.eventId}?eventId=${ticket.eventId}`
                      )
                    }
                  >
                    View event
                  </Button>
                </Box>
              ))}
            </Stack>
          </CardBody>
        </Card>
      </main>
    );
  }
}
