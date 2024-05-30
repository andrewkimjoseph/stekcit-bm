"use client";

import {
  Spinner,
  Text,
  Heading,
  Button,
  Stack,
  Input,
  InputGroup,
  InputLeftAddon,
  useToast,
} from "@chakra-ui/react";
import { useEffect, useState } from "react";
import { useAccount } from "wagmi";
import { StekcitUser } from "@/entities/stekcitUser";
import { getUserByWalletAddress } from "@/services/getUserByWalletAddress";
import { useRouter } from "next/navigation";
import { approveContract } from "@/services/approveContract";

export default function ApproveUs() {

  const { address } = useAccount();

  const toast = useToast();

  const [amount, setAmount] = useState(250);

  const router = useRouter();

  const [stekcitUser, setSteckitUser] = useState<StekcitUser | null>(null);

  const [isApproving, setIsApproving] = useState(false);

  const approveStekcitBMContract = async () => {
    setIsApproving(true);

    const amountIsApproved = await approveContract(address, {
      _amount: amount,
    });

    if (amountIsApproved) {
      setIsApproving(false);
      toast({
        description: `Approval for ${amount} USDC accepted.`,
        status: "success",
        duration: 9000,
        isClosable: true,
        position: "top",
      });
    } else {
      setIsApproving(false);

      toast({
        description: "Failed. Please try again.",
        status: "error",
        duration: 9000,
        isClosable: true,
        position: "top",
      });
    }
  };

  useEffect(() => {


    const fetchUserByWalletAddress = async () => {
      const fetchedStekcitUser = await getUserByWalletAddress(address, {
        _walletAddress: address as `0x${string}`,
      });

      setSteckitUser(fetchedStekcitUser);
    };

    fetchUserByWalletAddress();
  }, [address, stekcitUser]);

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
          Welcome to our approval screen!
        </Heading>
        <Stack spacing={8} m={8}>
          <Text>Our smart contract needs approval from your account...</Text>
          <Text>...even before you make any transaction.</Text>
          <Text>How cool is that?</Text>

          <InputGroup>
            <InputLeftAddon>Amount (USDC)</InputLeftAddon>
            <Input
              type={"number"}
              placeholder="in USDC"
              value={amount}
              onChange={(e) => setAmount(Number(e.target.value))}
            />
          </InputGroup>
          <Button
            bgColor={"#EA1845"}
            textColor={"white"}
            onClick={approveStekcitBMContract}
            loadingText="Approving"
            isLoading={isApproving}
            _hover={{
              bgColor: "#6600D5",
              //   color: "black",
            }}
          >
            Approve
          </Button>
        </Stack>
      </main>
    );
  }
}
