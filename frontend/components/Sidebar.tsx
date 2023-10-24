import { Product } from '../types/product'
import SidebarTables from './Sidebar/Tables'
import SidebarColumns from './Sidebar/Columns'
import { useEffect, useState } from 'react'

const BASE_URL = process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000'

export default function Sidebar() {
  const [productsWithTables, setProductsWithTables] = useState<Product[]>([])
  const [productsWithColumns, setProductsWithColumns] = useState<Product[]>([])

  const fetchProductsWithTables = async () => {
    const res = await fetch(`${BASE_URL}/api/products/tables`)
    const data = await res.json()
    setProductsWithTables(data)
  }

  const fetchProductsWithColumns = async () => {
    const res = await fetch(`${BASE_URL}/api/products/columns?name_like=article`)
    const data = await res.json()
    setProductsWithColumns(data)
  }

  useEffect(() => {
    fetchProductsWithTables()
    fetchProductsWithColumns()
  }, [])

  return (
    <aside className="w-1/4 overflow-auto h-full bg-gray-50">
      <SidebarTables products={productsWithTables} />
      <SidebarColumns products={productsWithColumns} />
    </aside>
  )
}
