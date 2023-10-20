import { Product } from '../types/product'
import { Table } from '../types/table'
import { useEffect, useState } from 'react'

const BASE_URL = process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000'

export default function Sidebar({ handleTargetTable }: { handleTargetTable: (table: Table) => void; }) {
  const [products, setProducts] = useState<Product[]>([])

  const fetchProducts = async () => {
    const res = await fetch(`${BASE_URL}/api/products`)
    const data = await res.json()
    setProducts(data)
  }

  useEffect(() => {
    fetchProducts()
  }, [])

  const handleClick = (table: Table) => () => {
    handleTargetTable(table)
  }

  return (
    <>
      <aside className="w-1/6 bg-gray-50">
        <h2 className="font-bold mt-3 ml-3 text-lg">Products</h2>
        <ul className="ml-5">
          {
            products.map((product: Product) => (
              <li
                key={ product.name }
                className="text-base"
              >
                { product.name }
                <ul className="ml-4">
                  { product.tables?.map((table) => (
                    <li
                      key={ table.name }
                      onClick={handleClick(table)}
                      className="cursor-pointer text-sm p-0.5 text-gray-900 hover:text-gray-500"
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
