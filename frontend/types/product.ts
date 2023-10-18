import { Table } from './table';

export type Product = {
  name: string;
  tables?: Table[] | null;
}
