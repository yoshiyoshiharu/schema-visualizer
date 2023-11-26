import { alertState } from '../recoil/atom/alert_state';
import { useRecoilState } from 'recoil';
import { useEffect } from 'react';
import { Alert } from '../types/alert';

import {
  Alert as ChakraAlert,
  AlertIcon,
  AlertDescription,
  Slide,
  useDisclosure
} from '@chakra-ui/react';

export default function Alert() {
  const [alert] = useRecoilState<Alert | null>(alertState)
  const { isOpen, onOpen, onClose } = useDisclosure()

  useEffect(() => {
    if (alert) {
      onOpen()
      const timer = setTimeout(() => {
        onClose()
      }, 2000)

      return () => clearTimeout(timer)
    }
  }, [alert])

  return (
    alert && 
      <Slide direction='bottom' in={isOpen} style={{ zIndex: 10 }}>
        <ChakraAlert status={ alert.status } justifyContent='center'>
          <AlertIcon boxSize='15px'/>
          <AlertDescription fontSize='14px'>{ alert.message }</AlertDescription>
        </ChakraAlert>
      </Slide>
  )
}
