"use client";

import { ReactNode, useEffect, useState } from "react";
import {
  Box,
  Flex,
  HStack,
  Link,
  IconButton,
  useDisclosure,
  useColorModeValue,
  Stack,
  useColorMode,
} from "@chakra-ui/react";
import { HamburgerIcon, CloseIcon, MoonIcon, SunIcon } from "@chakra-ui/icons";
import { ConnectButton } from "@rainbow-me/rainbowkit";
import { StekcitBMLogo } from "./logo";

const Links = [
  {
    "title": "Home",
    "href": "/"
  },
  {
    "title": "My Event",
    "href": "/my-events"
  },
  {
    "title": "My Event",
    "href": "/my-tickets"
  },
  {
    "title": "FAQ",
    "href": "/faq"
  }

];

const NavLink = ({ children }: { children: ReactNode }) => (
  <Link
    px={2}
    py={1}
    rounded={"md"}
    textColor={"white"}
    _hover={{
      textColor: "black",
      textDecoration: "none",
      bg: "white",
    }}
    href={"/"}
  >
    {children}
  </Link>
);

export default function StekcitNavBar() {
  const { isOpen, onOpen, onClose } = useDisclosure();

  const [isMiniPay, setIsMiniPay] = useState(false);

  useEffect(() => {
    if (window.ethereum && window.ethereum.isMiniPay) {
      setIsMiniPay(true);
    }
  }, []);

  return (
    <>
      <Box
        bg={useColorModeValue("#18A092", "#18A092")}
        px={4}
        className="sticky top-0"
      >
        <Flex h={16} alignItems={"center"} justifyContent={"space-between"}>
          <IconButton
            // _hover={{
            //   bgColor: "#FFD62C",
            //   color: "black",
            // }}
            bgColor={"white"}
            color={"black"}
            size={"md"}
            icon={isOpen ? <CloseIcon /> : <HamburgerIcon color={"black"} />}
            aria-label={"Open Menu"}
            display={{ md: "none" }}
            onClick={isOpen ? onClose : onOpen}
          />
          <HStack spacing={8} alignItems={"center"}>
            <StekcitBMLogo />
            <HStack
              as={"nav"}
              spacing={4}
              display={{ base: "none", md: "flex" }}
            >
              {Links.map((link) => (
                <NavLink key={link.href}>{link.title}</NavLink>
              ))}
            </HStack>
          </HStack>
          <Flex alignItems={"center"}>
            {/* <IconButton
              _hover={{
                bgColor: "#FFD62C",
              }}
              color={"white"}
              bgColor={"white"}
              size={"md"}
              icon={
                colorMode === "light" ? (
                  <MoonIcon color={"black"} />
                ) : (
                  <SunIcon color={"black"} />
                )
              }
              aria-label={"Change Color Mode"}
              // display={{ md: "none" }}
              onClick={toggleColorMode}
              marginRight={4}
            /> */}

            {!isMiniPay ? (
              <ConnectButton
                chainStatus="none"
                accountStatus={{
                  smallScreen: "avatar",
                  largeScreen: "avatar",
                }}
                showBalance={{
                  smallScreen: false,
                  largeScreen: true,
                }}
                label="Connect"
              />
            ) : (
              <div style={{ visibility: "hidden", pointerEvents: "none" }}>
                <ConnectButton
                  chainStatus="none"
                  accountStatus={{
                    smallScreen: "avatar",
                    largeScreen: "avatar",
                  }}
                  showBalance={{
                    smallScreen: false,
                    largeScreen: true,
                  }}
                  label="Connect"
                />
              </div>
            )}
          </Flex>
        </Flex>

        {isOpen ? (
          <Box pb={4} display={{ md: "none" }}>
            <Stack as={"nav"} spacing={4}>
              {Links.map((link) => (
                <NavLink  key={link.href}>{link.title}</NavLink>
              ))}
            </Stack>
          </Box>
        ) : null}
      </Box>

      {/* <Box p={4}>Main Content Here</Box> */}
    </>
  );
}