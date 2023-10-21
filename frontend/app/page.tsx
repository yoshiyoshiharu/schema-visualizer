'use client'
import Header from '../components/Header'
import Sidebar from '../components/Sidebar'
import Main from '../components/Main'
import { Table } from '../types/table'

import React, { useState } from 'react'

import { ChakraProvider } from '@chakra-ui/react'

export default function Home() {
  const [targetTable, setTargetTable] = useState<Table | null>(null)

  const handleTargetTable = (table: Table) => {
    setTargetTable(table)
  }

  return (
    <>
      <ChakraProvider>
        <Header></Header>
        <div className="flex h-[calc(100vh-3rem)]">
          <Sidebar handleTargetTable={handleTargetTable}></Sidebar>
          <Main table={targetTable}></Main>
        </div>
      </ChakraProvider>
    </>
  )
}
