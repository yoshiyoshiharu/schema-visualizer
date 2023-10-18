import { Table } from '../types/table'
import { Column } from '../types/column'

export default function MainTable({ table }: { table: Table }) {
  return (
    <>
      <h2 className="text-xl font-bold">{ table.name }テーブル</h2>
      <table className="table-auto">
        <thead>
          <tr>
            <th className="border px-4 py-2">カラム名</th>
            <th className="border px-4 py-2">型</th>
            <th className="border px-4 py-2">コメント</th>
          </tr>
        </thead>
        <tbody>
          { table.columns.map((column: Column) => (
            <tr key={ column.name }>
              <td className="border px-4 py-2">{ column.name }</td>
              <td className="border px-4 py-2">{ column.type }</td>
              <td className="border px-4 py-2">{ column.comment }</td>
            </tr>
          )) }
        </tbody>
      </table>
    </>
  )
}
