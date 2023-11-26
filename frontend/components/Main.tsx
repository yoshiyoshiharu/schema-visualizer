import { Table } from '../types/table'
import { Column } from '../types/column'
import PrimaryKey from '../components/Key/Primary'
import ForeignKey from '../components/Key/Foreign'
import ColumnMemoForm from '../components/ColumnMemoForm'
import { useEffect, useState } from 'react'
import { useRecoilValue } from 'recoil'
import { targetTableState } from '../recoil/atom/target_table_state'

import {
  Tag,
  Table as ChakraTable,
  Thead,
  Tbody,
  Tr,
  Th,
  Td,
  TableContainer,
  Center
} from '@chakra-ui/react'

const BASE_URL = process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000'

export default function Main() {
  const targetTable = useRecoilValue(targetTableState)

  const [columns, setColumns] = useState<Column[]>([])

  const fetchColumms = async (table: Table | null) => {
    if (!table) return

    const res = await fetch(`${BASE_URL}/api/tables/${table.id}/columns`)

    if (res.status !== 200) return

    const data = await res.json()
    setColumns(data)
  }

  useEffect(() => {
    fetchColumms(targetTable)
  }, [targetTable])

  return (
    <main className="w-3/4 overflow-auto">
      {
        targetTable &&
          <>
            <TableContainer className="p-3">
              <Tag>{targetTable?.product.name} / {targetTable.name}</Tag>
              <ChakraTable size='sm' className="mt-1">
                <Thead>
                  <Tr>
                    <Th>Name</Th>
                    <Th>Type</Th>
                    <Th>Key</Th>
                    <Th>
                      <Center>
                        Nullable
                      </Center>
                    </Th>
                    <Th>Comment</Th>
                    <Th>Memo</Th>
                  </Tr>
                </Thead>
                <Tbody>
                  {columns.map((column) => (
                    <Tr key={column.name}>
                      <Td>{column.name}</Td>
                      <Td>{column.type}</Td>
                      <Td>
                        {column.primary_key && <PrimaryKey></PrimaryKey>}
                        {
                          column.foreign_key_table &&
                            <ForeignKey
                              product={targetTable.product}
                              table={column.foreign_key_table} />
                        }
                      </Td>
                      <Td>
                        <Center>
                          {column.nullable ? '○' : '×'}
                        </Center>
                      </Td>
                      <Td>{column.comment}</Td>
                      <Td><ColumnMemoForm column={column}></ColumnMemoForm></Td>
                    </Tr>
                  ))}
                </Tbody>
              </ChakraTable>
            </TableContainer>
          </>
        }
    </main>
  )
}
