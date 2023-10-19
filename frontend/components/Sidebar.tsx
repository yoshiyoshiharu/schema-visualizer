import { Product } from '../types/product'
import { Table } from '../types/table'

export default function Sidebar({ handleTargetTable }: { handleTargetTable: (table: Table) => void; }) {
  // [TODO] APIから取得する
  const products: Product[] = [
    {
      id: 1,
      name: 'プロダクトA',
      tables: [
        {
          id: 1,
          name: 'テーブルA',
          comment: 'コメントA',
          columns: []
        },
        {
          id: 2,
          name: 'テーブルB',
          comment: 'コメントB',
          columns: []
        }
      ]
    }
  ]

  const handleClick = (table: Table) => () => {
    handleTargetTable(table)
  }

  return (
    <>
      <aside className="w-1/6 bg-gray-50">
        <h2 className="text-xl font-bold">Products</h2>
        <ul className="ml-8">
          {
            products.map((product: Product) => (
              <li key={ product.name }>
                { product.name }
                <ul className="ml-5">
                  { product.tables?.map((table) => (
                    <li
                      key={ table.name }
                      onClick={handleClick(table)}
                    >{ table.name }</li>
                  )) }
                </ul>
              </li>
            ))
          }
        </ul>
      </aside>
    </>
  )
}
