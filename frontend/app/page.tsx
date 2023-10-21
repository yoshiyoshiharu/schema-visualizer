'use client'

import Wrapper from '../components/Wrapper'
import { ChakraProvider } from '@chakra-ui/react'

export default function Home() {
  return (
    <>
      <ChakraProvider>
        <Wrapper></Wrapper>
      </ChakraProvider>
    </>
  )
}
