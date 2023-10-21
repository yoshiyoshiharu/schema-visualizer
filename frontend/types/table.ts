import { Product } from './product';
import { Column } from './column';

export type Table = {
  id: number;
  name: string;
  comment: string;
  product: Product;
  columns: Column[];
}
