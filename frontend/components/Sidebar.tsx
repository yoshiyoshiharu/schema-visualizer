import { Product } from '../types/product'
import SidebarTables from './Sidebar/Tables'
import SidebarColumns from './Sidebar/Columns'
import { useEffect, useState } from 'react'
import {
  Input,
} from '@chakra-ui/react'

const BASE_URL = process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000'

export default function Sidebar() {
  const [productsWithTables, setProductsWithTables] = useState<Product[]>([])
  const [productsWithColumns, setProductsWithColumns] = useState<Product[]>([])
  const [searchTerm, setSearchTerm] = useState<string>('')

  const fetchProductsWithTables = async () => {
    const res = await fetch(`${BASE_URL}/api/products/tables?name_like=${searchTerm}`)
    const data = await res.json()
    setProductsWithTables(data)
  }

  const fetchProductsWithColumns = async () => {
    const res = await fetch(`${BASE_URL}/api/products/columns?name_like=${searchTerm}`)
    const data = await res.json()
    setProductsWithColumns(data)
  }

  const handleSearch = () => {
    fetchProductsWithTables()
    fetchProductsWithColumns()
  }

  useEffect(() => {
    fetchProductsWithTables()
    fetchProductsWithColumns()
  }, [])

  return (
    <aside className="w-1/4 overflow-auto h-full bg-gray-50">
      <div className="m-3">
        <Input
          bgColor="white"
          borderColor="gray.300"
          placeholder="Search"
          size="sm"
          onChange={(e) => setSearchTerm(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === 'Enter') {
              handleSearch()
            }
          }}
        />
      </div>

      <SidebarTables products={productsWithTables} />
      <SidebarColumns products={productsWithColumns} />
    </aside>
  )
}
