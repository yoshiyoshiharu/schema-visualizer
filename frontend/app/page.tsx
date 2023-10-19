'use client'
import Header from '../components/Header'
import Sidebar from '../components/Sidebar'
import Main from '../components/Main'
import { Table } from '../types/table'

import React, { useState } from 'react'

export default function Home() {
  const [targetTable, setTargetTable] = useState<Table | null>(null)

  const handleTargetTable = (table: Table) => {
    setTargetTable(table)
  }

  return (
    <>
      <Header></Header>
      <div className="flex">
        <Sidebar handleTargetTable={handleTargetTable}></Sidebar>
        <Main table={targetTable}></Main>
      </div>
    </>
  )
}
