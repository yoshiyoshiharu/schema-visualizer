import { Table } from '../types/table'
import { Column } from '../types/column'
import { useEffect, useState } from 'react'

import {
  Table as ChakraTable,
  Thead,
  Tbody,
  Tr,
  Th,
  Td,
  TableContainer,
} from '@chakra-ui/react'

const BASE_URL = process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000'

export default function Main({ table }: { table: Table | null}) {
  const [columns, setColumns] = useState<Column[]>([])

  const fetchColumms = async (table: Table | null) => {
    if (!table) return

    const res = await fetch(`${BASE_URL}/api/columns?table_id=${table.id}`)

    if (res.status !== 200) return

    const data = await res.json()
    setColumns(data)
  }

  useEffect(() => {
    fetchColumms(table)
  }, [table])

  return (
    <main className="w-3/4 overflow-auto">
      <TableContainer className="p-3">
        <ChakraTable size='sm' className="table-fixed">
          <Thead>
            <Tr>
              <Th>Name</Th>
              <Th>Type</Th>
              <Th>Comment</Th>
            </Tr>
          </Thead>
          <Tbody>
            {columns.map((column) => (
              <Tr>
                <Td>{column.name}</Td>
                <Td>{column.type}</Td>
                <Td>{column.comment}</Td>
              </Tr>
            ))}
          </Tbody>
        </ChakraTable>
      </TableContainer>
    </main>
  )
}
