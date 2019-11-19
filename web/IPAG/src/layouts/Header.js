import { Layout, Menu, Icon } from 'antd';
import Link from 'umi/link';
function Header({ location }) {
  return (
    <Layout style={{ height: '188px', background: '#5b8c00' }}>
      <h1 style={{ color: "rgb(255, 255, 255)", fontSize: "38px", lineHeight: "46px", marginBottom: "12px", paddingTop: "24px" }}>
        IPAG
      </h1>
      <p style={{ color: "rgba(255, 255, 255, 0.65)", fontSize: "20px", lineHeight: "28px", marginBottom: "32px" }}>
        Integrated Platform for Analyzes on Genetics and Genomics
      </p>
      <Menu
        theme="dark"
        mode="horizontal"
        selectedKeys={[location.pathname]}
        style={{ background: '#5b8c00' }}
      >
        <Menu.Item key="/">
          <Link to="/"><Icon type="home" theme="filled" />Home</Link>
        </Menu.Item>
        <Menu.Item key="/data">
          <Link to="/data"><Icon type="folder-open" theme="filled" />Data Management</Link>
        </Menu.Item>
        <Menu.Item key="/jobs">
          <Link to="/jobs"><Icon type="play-square" theme="filled" />My Jobs</Link>
        </Menu.Item>
        <Menu.Item key="/gs">
          <Link to="/gs"><Icon type="trophy" theme="filled" />GS/GP</Link>
        </Menu.Item>
        <Menu.Item key="/gwas">
          <Link to="/gwas"><Icon type="funnel-plot" theme="filled" />GWAS</Link>
        </Menu.Item>
        <Menu.Item key="/simulation">
          <Link to="/simulation"><Icon type="control" theme="filled" />Simulation</Link>
        </Menu.Item>
        <Menu.Item key="/users">
          <Link to="/users"><Icon type="info-circle" theme="filled" />About</Link>
        </Menu.Item>
      </Menu>
    </Layout>
    // <Menu
    //   selectedKeys={[location.pathname]}
    //   mode="horizontal"
    //   theme="dark"
    // >
    //   <Menu.Item key="/">
    //     <Link to="/"><Icon type="home" />Home</Link>
    //   </Menu.Item>
    //   <Menu.Item key="/users">
    //     <Link to="/users"><Icon type="bars" />Users</Link>
    //   </Menu.Item>
    //   <Menu.Item key="/umi">
    //     <a href="https://github.com/umijs/umi" target="_blank" rel="noopener noreferrer">umi</a>
    //   </Menu.Item>
    //   <Menu.Item key="/dva">
    //     <a href="https://github.com/dvajs/dva" target="_blank" rel="noopener noreferrer">dva</a>
    //   </Menu.Item>
    //   <Menu.Item key="/404">
    //     <Link to="/page-you-dont-know"><Icon type="frown" />404</Link>
    //   </Menu.Item>
    // </Menu>
  );
}
export default Header; 