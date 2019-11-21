import styles from './index.css'
import { Layout, Menu, Icon } from 'antd'
import Link from 'umi/link';

const { Header, Content, Footer } = Layout;

function BasicLayout(props) {
  return (
    <Layout>
      <Header className={styles.header}>
        <h1 className={styles.title}>
          IPAG
        </h1>
        <p className={styles.subtitle}>
          Integrated Platform for Analyzes on Genetics and Genomics
        </p>
        <Menu
          theme="dark"
          mode="horizontal"
          selectedKeys={[props.location.pathname]}
          className={styles.menu}
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
            <Link to="/users"><Icon type="setting" theme="filled" />Settings</Link>
          </Menu.Item>
        </Menu>
      </Header>
      <Content className={styles.container}>
        {props.children}
      </Content>
      <Footer style={{ textAlign: "center" }}>
        IPAG ©2019 Created by Xiaolei Team
      </Footer>
    </Layout>
  );
}

export default BasicLayout;
