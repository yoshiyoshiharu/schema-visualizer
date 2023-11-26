import { Column } from '../types/column';
import {
  Textarea,
} from '@chakra-ui/react'

const BASE_URL = process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000'

export default function ColumnMemoForm({ column }: { column: Column }) {
  const  updateMemo = async (content: string) => {
    try {
      const response = await fetch(`${BASE_URL}/api/columns/${column.id}/memo`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          column_memo: {
            content: content
          }
        })
      });

      if (response.ok) {
        console.log('コメントが更新されました');
      } else {
        console.error('コメントの更新に失敗しました');
      }
    } catch (error) {
      console.error('エラー:', error);
    }
  }

  const handleKeyDown = (e) => {
    if (e.key === 'Enter' && e.ctrlKey) {
      updateMemo(e.target.value)
    }
  }

  return (
    <div>
      <Textarea
        size='xs'
        rows={2}
        placeholder='Ctrl + Enterで更新'
        defaultValue={column.memo?.content}
        onKeyDown={handleKeyDown}
      />
    </div>
  )
}
