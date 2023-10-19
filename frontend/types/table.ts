import { Column } from './column';

export type Table = {
  id: number;
  name: string;
  comment: string;
  columns: Column[];
}
