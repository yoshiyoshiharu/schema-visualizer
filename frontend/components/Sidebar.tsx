import { Product } from '../types/product'
import { Table } from '../types/table'
import { useEffect, useState } from 'react'
import { useSetRecoilState } from 'recoil'
import { targetTableState } from '../recoil/atom/target_table_state'

import {
  Accordion,
  AccordionItem,
  AccordionButton,
  AccordionPanel,
  AccordionIcon,
  Box
} from '@chakra-ui/react'

const BASE_URL = process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000'

export default function Sidebar() {
  const [products, setProducts] = useState<Product[]>([])
  const setTargetTable = useSetRecoilState(targetTableState)

  const fetchProducts = async () => {
    const res = await fetch(`${BASE_URL}/api/products`)
    const data = await res.json()
    setProducts(data)
  }

  useEffect(() => {
    fetchProducts()
  }, [])

  const handleClick = (product: Product, table: Table) => () => {
    setTargetTable({
      ...table,
      product: product
    })
  }

  return (
    <aside className="w-1/4 overflow-auto h-full bg-gray-50">
      <h2 className="font-bold p-4">Tables</h2>
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
                    onClick={handleClick(product, table)}
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
