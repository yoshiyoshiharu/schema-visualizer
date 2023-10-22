import { atom } from 'recoil';
import { Table } from '../../types/table';

export const targetTableState = atom<Table | null>({
  key: 'targetTable',
  default: null,
});
