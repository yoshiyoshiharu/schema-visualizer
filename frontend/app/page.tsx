import Header from '../components/Header'
import Sidebar from '../components/Sidebar'
import Main from '../components/Main'

export default function Home() {
  return (
    <>
      <Header></Header>
      <div className="flex">
        <Sidebar></Sidebar>
        <Main></Main>
      </div>
    </>
  )
}
