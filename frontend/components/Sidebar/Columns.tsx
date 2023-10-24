import { Product } from '../../types/product'
import { Table } from '../../types/table'
import { targetTableState } from '../../recoil/atom/target_table_state'
import { useSetRecoilState } from 'recoil'

import {
  Accordion,
  AccordionItem,
  AccordionButton,
  AccordionPanel,
  AccordionIcon,
  Box
} from '@chakra-ui/react'

export default function SidebarColumns({ products }: { products: Product[] }) {
  const setTargetTable = useSetRecoilState(targetTableState)

  const handleClick = (product: Product, table: Table) => () => {
    setTargetTable({
      ...table,
      product: product
    })
  }

  return(
    <>
      <h2 className="font-bold p-4">Columns</h2>
      <Accordion allowMultiple>
        {products.map((product) => (
          <AccordionItem key={product.id}>
            <h2>
              <AccordionButton>
                <Box>
                  {product.name}({product.tables.map((table) => table.columns).length})
                </Box>
                <AccordionIcon />
              </AccordionButton>
            </h2>
            <AccordionPanel pb={4}>
              <ul className="ml-4">
                {product.tables.map((table) => (
                  table.columns.map((column) => (
                    <li
                      key={table.id}
                      onClick={handleClick(product, table)}
                      className="cursor-pointer hover:text-gray-500"
                    >
                      {table.name}.{column.name}
                    </li>
                  )))
              )}
            </ul>
            </AccordionPanel>
          </AccordionItem>
        ))}
      </Accordion>
    </>
  )
}
