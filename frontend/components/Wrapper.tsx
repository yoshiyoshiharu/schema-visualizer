import React, { useState } from 'react'
import Header from './Header'
import Sidebar from './Sidebar'
import Main from './Main'
import { Table } from '../types/table'


export default function Wrapper() {
  const [targetTable, setTargetTable] = useState<Table | null>(null)

  const handleTargetTable = (table: Table) => {
    setTargetTable(table)
  }

  return (
    <>
      <Header></Header>
      <div className="flex h-[calc(100vh-3rem)]">
        <Sidebar handleTargetTable={handleTargetTable}></Sidebar>
        <Main table={targetTable}></Main>
      </div>
    </>
  )
}
