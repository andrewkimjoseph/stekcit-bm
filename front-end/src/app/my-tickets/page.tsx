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
  Image,
  Flex,
  useToast,
  Badge,
  Popover,
  PopoverArrow,
  PopoverBody,
  PopoverCloseButton,
  PopoverContent,
  PopoverHeader,
  PopoverTrigger,
} from "@chakra-ui/react";
import { useEffect, useState } from "react";
import { useAccount } from "wagmi";
import { StekcitUser } from "@/entities/stekcitUser";
import { getUserByWalletAddress } from "@/services/getUserByWalletAddress";

import { StekcitTicket } from "@/entities/stekcitTicket";
import { getAllTicketsOfUser } from "@/services/getAllTicketsOfUser";
import { useRouter } from "next/navigation";
import { verifyEventAndSetVerificationRequestId } from "@/services/verifyEvent";
import { verifyTicketAndSetVerificationRequestId } from "@/services/verifyTicket";

export default function MyTickets() {
  const { address } = useAccount();

  const [stekcitUser, setSteckitUser] = useState<StekcitUser | null>(null);

  const [allTicketsOfUser, setAllTicketsOfUser] = useState<StekcitTicket[]>([]);

  const [isVerifying, setIsVerifying] = useState(false);

  const router = useRouter();

  const toast = useToast();

  const verifyTicket = async (ticketId: number) => {
    if (allTicketsOfUser[ticketId].verificationId) {
      toast({
        description: "Ticket is already verified",
        status: "info",
        duration: 9000,
        isClosable: true,
        position: "top",
      });

      return;
    }

    setIsVerifying(true);

    const ticketIsPublished = await verifyTicketAndSetVerificationRequestId(
      address,
      { _ticketId: ticketId }
    );

    if (ticketIsPublished) {
      setIsVerifying(false);
      toast({
        description: "Ticket successfully verified.",
        status: "success",
        duration: 9000,
        isClosable: true,
        position: "top",
      });
      return;
    } else {
      setIsVerifying(false);
      toast({
        description: "Ticket verification failed.",
        status: "error",
        duration: 9000,
        isClosable: true,
        position: "top",
      });
      return;
    }
  };

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
                  <Flex direction={"row"}>
                    <Heading size="xs" textTransform="uppercase">
                      Event id: {ticket.eventId}
                    </Heading>

                    {ticket.verificationRequestId ? (
                      <Popover placement="top">
                        <PopoverTrigger>
                          <Image
                            marginLeft={2}
                            height={"15px"}
                            src="/verified.png"
                            alt="Dan Abramov"
                          />
                        </PopoverTrigger>
                        <PopoverContent color="black" width={"200px"}>
                          <PopoverArrow />
                          <PopoverCloseButton />
                          <PopoverHeader pt={4} fontWeight="bold" border="0">
                            Verified ticket
                          </PopoverHeader>
                          <PopoverBody>
                            You worked for this.
                            <Badge>{ticket.verificationId}</Badge>
                          </PopoverBody>
                        </PopoverContent>
                      </Popover>
                    ) : null}
                  </Flex>

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
                  <Button
                    marginTop={4}
                    marginLeft={4}
                    // variant="outline"
                    isLoading={isVerifying}
                    loadingText="Verifying"
                    colorScheme="blue"
                    onClick={() => verifyTicket(ticket.id)}
                  >
                    Verify ticket
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
