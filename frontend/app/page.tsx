'use client'

import Wrapper from '../components/Wrapper'
import { ChakraProvider } from '@chakra-ui/react'
import { RecoilRoot } from 'recoil'

export default function Home() {
  return (
    <>
      <RecoilRoot>
        <ChakraProvider>
          <Wrapper></Wrapper>
        </ChakraProvider>
      </RecoilRoot>
    </>
  )
}
