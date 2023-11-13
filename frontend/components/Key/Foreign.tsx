import { Button } from '@chakra-ui/react'
import { Product } from '../../types/product'
import { Table } from '../../types/table'
import { targetTableState } from '../../recoil/atom/target_table_state'
import { useSetRecoilState } from 'recoil'

export default function ForeignKey({ product, table }: { product: Product, table: Table }) {
  const setTargetTable = useSetRecoilState(targetTableState)

  const handleClick = () => {
    setTargetTable({
      ...table,
      product: product
    })
  }

  return (
    <Button size='xs' colorScheme='blue' variant='outline' onClick={handleClick}>
      FK
    </Button>
  )
}
