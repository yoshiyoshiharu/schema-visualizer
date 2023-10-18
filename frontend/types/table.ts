import { Column } from './column';

export type Table = {
  name: string;
  comment: string;
  columns?: Column[] | null;
}
