import React, { Component } from 'react'
import { Layout, Menu, Breadcrumb, Icon } from 'antd';
import { hot } from 'react-hot-loader'

import Test from './HomeScreen'
import { SubMenu } from '_rc-menu@7.5.2@rc-menu';

const { Header, Content, Footer } = Layout;

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      activeTab: "Home",
    }
  }

  handleTabClick = (e) => {
    this.setState({ activeTab: e.key });
  }

  CurrentTab = (props) => {
    const activeTab = props.activeTab;
    if (activeTab == "Home") {
      return <Test />;
    } else if (activeTab == "Data") {
      return <div />;
    } else if (activeTab == "Jobs") {
      return <div />;
    } else if (activeTab == "GS/GP") {
      return <div />;
    } else if (activeTab == "GWAS") {
      return <div />;
    } else if (activeTab == "Simulation") {
      return <div />;
    } else if (activeTab == "About") {
      return <div />;
    }
  }

  render() {
    const { activeTab } = this.state
    return (
      <Layout>
        <Header style={{ height: '188px', background: '#5b8c00' }}>
          <h1 style={{ color: "rgb(255, 255, 255)", fontSize: "38px", lineHeight: "46px", marginBottom: "12px", paddingTop: "24px" }}>
            IPAG
          </h1>
          <p style={{ color: "rgba(255, 255, 255, 0.65)", fontSize: "20px", lineHeight: "28px", marginBottom: "32px" }}>
            Integrated Platform for Analyzes on Genetics and Genomics
          </p>
          <Menu
            theme="dark"
            mode="horizontal"
            selectedKeys={[activeTab]}
            onClick={this.handleTabClick}
            style={{ background: '#5b8c00' }}
          >
            <Menu.Item key="Home"><Icon type="home" theme="filled" />Home</Menu.Item>
            <Menu.Item key="Data"><Icon type="folder-open" theme="filled" />Data Management</Menu.Item>
            <Menu.Item key="Jobs"><Icon type="play-square" theme="filled" />My Jobs</Menu.Item>
            <Menu.Item key="GS/GP"><Icon type="trophy" theme="filled" />GS/GP</Menu.Item>
            {/* <SubMenu key="GS/GP" title={
                <span><Icon type="trophy" theme="filled" />GS/GP</span>  
              }
            >
              <Menu.ItemGroup title="Item 1">
                <Menu.Item key="setting:1">Option 1</Menu.Item>
                <Menu.Item key="setting:2">Option 2</Menu.Item>
              </Menu.ItemGroup>
              <Menu.ItemGroup title="Item 2">
                <Menu.Item key="setting:3">Option 3</Menu.Item>
                <Menu.Item key="setting:4">Option 4</Menu.Item>
              </Menu.ItemGroup>
            </SubMenu> */}
            <Menu.Item key="GWAS"><Icon type="funnel-plot" theme="filled" />GWAS</Menu.Item>
            <Menu.Item key="Simulation"><Icon type="control" theme="filled" />Simulation</Menu.Item>
            <Menu.Item key="About"><Icon type="info-circle" theme="filled" />About</Menu.Item>
          </Menu>
        </Header>

        <Content style={{ padding: '0 50px' }}>
          <this.CurrentTab activeTab={activeTab} />
        </Content>

        <Footer style={{ textAlign: 'center' }}>IPAG ©2019 Created by Xiaolei Team</Footer>
      </Layout>
    )
  }
}

export default hot(module)(App)
