import { Table } from './table';
import { ColumnMemo } from './column_memo';

export type Column = {
  id: number;
  name: string;
  comment: string;
  type: string;
  nullable: boolean;
  primary_key: boolean;
  table: Table;
  foreign_key_table: Table;
  memo: ColumnMemo;
}
