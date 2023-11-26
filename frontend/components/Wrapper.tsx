import Header from './Header'
import Alert from './Alert'
import Sidebar from './Sidebar'
import Main from './Main'


export default function Wrapper() {
  return (
    <>
      <Header></Header>
      <Alert></Alert>
      <div className="flex h-[calc(100vh-3rem)]">
        <Sidebar></Sidebar>
        <Main></Main>
      </div>
    </>
  )
}
