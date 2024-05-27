/* theme.ts */
import { StyleFunctionProps, extendTheme } from "@chakra-ui/react";

const config = extendTheme({
  initialColorMode: 'light',
  fonts: {
    heading: 'var(--font-dmSans)',
    body: 'var(--font-dmSans)',
  },
});

const stekcitBMTheme = extendTheme({ config })

export default stekcitBMTheme