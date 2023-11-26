import { alertState } from '../recoil/atom/alert_state';
import { useRecoilState } from 'recoil';
import { useEffect } from 'react';
import { Alert } from '../types/alert';

import {
  Alert as ChakraAlert,
  AlertIcon,
  AlertDescription,
} from '@chakra-ui/react';

export default function Alert() {
  const [alert, setAlert] = useRecoilState<Alert | null>(alertState)

  useEffect(() => {
    if (alert) {
      setTimeout(() => {
        setAlert(null)
      }, 2000)
    }
  }, [alert])

  return (
    alert && 
    <ChakraAlert status={ alert.status } justifyContent='center'>
      <AlertIcon boxSize='15px'/>
      <AlertDescription fontSize='14px'>{ alert.message }</AlertDescription>
    </ChakraAlert>
  )
}
