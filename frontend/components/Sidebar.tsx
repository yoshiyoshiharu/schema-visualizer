import { Product } from '../types/product'
import SidebarTables from './Sidebar/Tables'
import { useEffect, useState } from 'react'

const BASE_URL = process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000'

export default function Sidebar() {
  const [products, setProducts] = useState<Product[]>([])

  const fetchProducts = async () => {
    const res = await fetch(`${BASE_URL}/api/products`)
    const data = await res.json()
    setProducts(data)
  }

  useEffect(() => {
    fetchProducts()
  }, [])

  return (
    <aside className="w-1/4 overflow-auto h-full bg-gray-50">
      <SidebarTables products={products} />
    </aside>
  )
}
