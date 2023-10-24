import Header from './Header'
import Sidebar from './Sidebar'
import Main from './Main'


export default function Wrapper() {
  return (
    <>
      <Header></Header>
      <div className="flex h-[calc(100vh-3rem)]">
        <Sidebar></Sidebar>
        <Main></Main>
      </div>
    </>
  )
}
