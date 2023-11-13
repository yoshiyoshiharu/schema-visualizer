import { Table } from './table';

export type Column = {
  id: number;
  name: string;
  comment: string;
  type: string;
  nullable: boolean;
  primary_key: boolean;
  table: Table;
  foreign_key_table: Table;
}
