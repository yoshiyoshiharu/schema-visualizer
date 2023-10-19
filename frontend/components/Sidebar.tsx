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
