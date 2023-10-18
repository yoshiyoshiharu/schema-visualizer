import { Product } from '../types/product'

export default function Sidebar() {
  // [TODO] APIから取得する
  const products: Product[] = [
    { 
      name: 'プロダクトA',
      tables: [
        {
          name: 'テーブルA',
          comment: 'コメントA',
          columns: [
            {
              name: 'カラムA',
              type: 'integer',
              comment: 'コメントA'
            },
            {
              name: 'カラムB',
              type: 'string',
              comment: 'コメントB'
            }
          ]
        },
        {
          name: 'テーブルB',
          comment: 'コメントB',
          columns: [
            {
              name: 'カラムC',
              type: 'integer',
              comment: 'コメントC'
            },
            {
              name: 'カラムD',
              type: 'string',
              comment: 'コメントD'
            }
          ]
        }
      ]
    }
  ]

  return (
    <>
      <aside className="w-1/6 bg-gray-50">
        <h2 className="text-xl font-bold">Products</h2>
        <ul className="ml-8">
          { products.map((product: Product) => (
            <li key={ product.name }>
              { product.name }
              <ul className="ml-5">
                { product.tables?.map((table) => (
                  <li key={ table.name }>{ table.name }</li>
                )) }
              </ul>
            </li>
          )) }
        </ul>
      </aside>
    </>
  )
}
