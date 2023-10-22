import { Table } from './table';

export type Column = {
  name: string;
  comment: string;
  type: string;
  table: Table;
}
