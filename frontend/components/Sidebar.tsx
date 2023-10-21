import { Product } from '../types/product'
import { Table } from '../types/table'
import { useEffect, useState } from 'react'

import {
  Accordion,
  AccordionItem,
  AccordionButton,
  AccordionPanel,
  AccordionIcon,
  Box
} from '@chakra-ui/react'

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
    <aside className="w-1/4 overflow-auto h-full bg-gray-50">
      <Accordion allowMultiple>
        {products.map((product) => (
          <AccordionItem key={product.id}>
            <h2>
              <AccordionButton>
                <Box>
                  {product.name}({product.tables.length})
                </Box>
                <AccordionIcon />
              </AccordionButton>
            </h2>
            <AccordionPanel pb={4}>
              <ul className="ml-4">
                {product.tables.map((table) => (
                  <li
                    key={table.id}
                    onClick={handleClick(table)}
                    className="cursor-pointer hover:text-gray-500"
                  >
                    {table.name}
                  </li>
              ))}
            </ul>
            </AccordionPanel>
          </AccordionItem>
        ))}
      </Accordion>
    </aside>
  )
}
