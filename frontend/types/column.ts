import { Table } from './table';

export type Column = {
  id: number;
  name: string;
  comment: string;
  type: string;
  table: Table;
}
