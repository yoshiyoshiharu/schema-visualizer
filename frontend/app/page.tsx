'use client'
import Header from '../components/Header'
import Sidebar from '../components/Sidebar'
import Main from '../components/Main'

export default function Home() {
  const table = {
    name: 'users',
    comment: '',
    columns: [
      {
        name: 'id',
        type: 'int',
        comment: 'ユーザーID'
      },
      {
        name: 'name',
        type: 'varchar(255)',
        comment: '名前'
      },
      {
        name: 'email',
        type: 'varchar(255)',
        comment: 'メールアドレス'
      },
      {
        name: 'password',
        type: 'varchar(255)',
        comment: 'パスワード'
      },
      {
        name: 'created_at',
        type: 'timestamp',
        comment: '作成日時'
      },
      {
        name: 'updated_at',
        type: 'timestamp',
        comment: '更新日時'
      }
    ]
  }

  return (
    <>
      <Header></Header>
      <div className="flex">
        <Sidebar></Sidebar>
        <Main table = {table}></Main>
      </div>
    </>
  )
}
