import { Table } from '../types/table'
import MainTable from '../components/MainTable'

export default function Main() {
  // [TODO] APIから取得する
  const table: Table = {
    name: 'users',
    comment: 'ユーザー',
    columns: [
      { name: 'id', type: 'integer', comment: 'ID' },
      { name: 'name', type: 'string', comment: '名前' },
      { name: 'email', type: 'string', comment: 'メールアドレス' },
      { name: 'created_at', type: 'datetime', comment: '作成日時' },
      { name: 'updated_at', type: 'datetime', comment: '更新日時' },
    ],
  }
    
  return (
    <>
      <main className="min-h-screen">
        <MainTable table = { table }></MainTable>
      </main>
    </>
  )
}
