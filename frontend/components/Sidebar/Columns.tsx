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

export default function SidebarColumns({ columns }: { columns: Column[] }) {
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
      </Accordion>
    </>
  )
}
