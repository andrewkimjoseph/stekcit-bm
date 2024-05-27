// app/providers.tsx
'use client'

import { ChakraProvider } from '@chakra-ui/react'
import stekcitBMTheme from '../utils/themes/theme'

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  return <ChakraProvider theme={stekcitBMTheme}
  >{children}</ChakraProvider>
}