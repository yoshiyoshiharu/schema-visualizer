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
    <main className="min-h-screen w-5/6 h-full overflow-y-auto">
      <div className="mx-auto w-5/6">
        <h2 className="text-xl font-bold my-2">{ table?.name }</h2>
        <table className="table-fixed w-full text-sm">
          <thead>
            <tr>
              <th className="border px-4 py-2">name</th>
              <th className="border px-4 py-2">type</th>
              <th className="border px-4 py-2">comment</th>
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
      </div>
    </main>
  )
}
