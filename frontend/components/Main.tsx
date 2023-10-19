import { Table } from '../types/table'
import { Column } from '../types/column'
import MainTable from './MainTable'
import { useEffect, useState } from 'react'

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
    <main className="min-h-screen">
      <h2 className="text-xl font-bold">{ table?.name }テーブル</h2>
      <table className="table-auto">
        <thead>
          <tr>
            <th className="border px-4 py-2">カラム名</th>
            <th className="border px-4 py-2">型</th>
            <th className="border px-4 py-2">コメント</th>
          </tr>
        </thead>
        <tbody>
          { columns?.map((column: Column) => (
            <tr key={column.name}>
              <td className="border px-4 py-2">{ column.name }</td>
              <td className="border px-4 py-2">{ column.type }</td>
              <td className="border px-4 py-2">{ column.comment }</td>
            </tr>
          )) }
        </tbody>
      </table>
    </main>
  )
}
