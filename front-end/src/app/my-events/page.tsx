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
import { StekcitEvent } from "@/entities/stekcitEvent";
import { getAllEventsCreatedByUser } from "@/services/getAllEventsCreatedByUser";
import { useRouter } from "next/navigation";

export default function AllEvents() {

  const { address } = useAccount();

  const router = useRouter();

  const [stekcitUser, setSteckitUser] = useState<StekcitUser | null>(null);

  const [allEventsCreatedByUser, setAllEventsCreatedByUser] = useState<
    StekcitEvent[]
  >([]);

  useEffect(() => {
  
    const fetchUserByWalletAddress = async () => {
      const fetchedStekcitUser = await getUserByWalletAddress(address, {
        _walletAddress: address as `0x${string}`,
      });

      setSteckitUser(fetchedStekcitUser);
    };

    const getAllEventsCreatedByUserAndSet = async () => {
      const fetchedPublishedEvents = await getAllEventsCreatedByUser(address);
      setAllEventsCreatedByUser(fetchedPublishedEvents);
    };

    fetchUserByWalletAddress();
    getAllEventsCreatedByUserAndSet();
  }, [address, stekcitUser, allEventsCreatedByUser]);

  if (stekcitUser?.isBlank) {
    return (
      <main className="flex h-screen items-center justify-center">
        <Spinner />
      </main>
    );
  } else {
    return (
      <main className="flex flex-col items-center">
        <Heading as="h4" size="sm" paddingBottom={4} paddingTop={4}>
          Welcome to your events!
        </Heading>
        <Button
          bgColor={"#EA1845"}
          textColor={"white"}
          onClick={() => router.push("/create-event")}
          _hover={{
            bgColor: "#6600D5",
            //   color: "black",
          }}
        >
          Create event
        </Button>
        <Card marginTop={8} direction={"column"}>
          <CardHeader>
            <Heading size="md">All Events You Created</Heading>
          </CardHeader>

          <CardBody>
            <Stack divider={<StackDivider />} spacing="4">
              {allEventsCreatedByUser.length === 0 && (
                <Box>
                  <Text pt="2" fontSize="sm">
                    ...will show here
                  </Text>
                </Box>
              )}
              {allEventsCreatedByUser.map((event) => (
                <Box key={event.id}>
                  <Heading size="xs" textTransform="uppercase">
                    {event.id}: {event.title}
                  </Heading>
                  <Text pt="2" fontSize="sm">
                    {event.description}
                  </Text>
                  <Button
                    marginTop={4}
                    variant="outline"
                    color="#18A092"
                    onClick={() =>
                      router.push(`/my-events/${event.id}?eventId=${event.id}`)
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
