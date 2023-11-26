import { atom } from 'recoil';
import { Alert } from '../../types/alert';

export const alertState = atom<Alert | null>({
  key: 'alert',
  default: null,
});
