import styles from './index.less';
import { Row, Col, Layout, Card, Table, Divider, Tag, Button, Icon } from 'antd'
import Link from 'umi/link';

const { Meta } = Card;
const { Content } = Layout;

const TAGS_COLOR = {
  "rMVP": "volcano",
  "HIBLUP": "green",
  "JWAS": "blue",
  "soybean": "orange",
  "breeding": "geekblue",
  "swine": "gold",
  "Simer": "purple"
}

const template = [
  {
    "title": "Three Model with 3PC",
    "category": "GWAS",
    "description": "Built-in GWAS analysis template, using GLM, MLM and FarmCPU, and adding three principal components as covariates.",
    "tags": ["rMVP"],
  },
  {
    "title": "SSBLUP - A",
    "category": "GS/GP",
    "description": "Built-in GS/GP analysis template with SSBLUP model based on additive effect model.",
    "tags": ["HIBLUP"],
  },
  {
    "title": "BayesCπ",
    "category": "GS/GP",
    "description": "The built-in GWAS analysis template uses a general linear model with three principal components as covariates.",
    "tags": ["JWAS"],
  },
]

const columns = [
  {
    title: 'Name',
    dataIndex: 'name',
    key: 'name',
    width: 200,
    render: text => <a>{text}</a>,
  },
  {
    title: 'Description',
    dataIndex: 'description',
    key: 'description',
    ellipsis: true,
  },
  {
    title: 'Tags',
    key: 'tags',
    dataIndex: 'tags',
    width: 180,
    render: tags => (
      <span>
        {tags.map(tag => (
          <Tag color={TAGS_COLOR[tag]}>{tag}</Tag>
        ))}
      </span>
    ),
  },
  {
    title: 'Action',
    key: 'action',
    // fixed: 'right',
    width: 100,
    render: (text, record) => (
      <span>
        <a>Edit</a>
        <Divider type="vertical" />
        <a>Delete</a>
      </span>
    ),
  },
];

const data = [
  {
    key: '1',
    name: 'Gmax_DB2017_485',
    description: 'For soybean breeding',
    tags: ['soybean', 'breeding'],
  },
  {
    key: '2',
    name: 'GS accuracy paper',
    description: '14 traits from four data sets of three species (maize, cattle, and pig)',
    tags: ['HIBLUP'],
  },
  {
    key: '3',
    name: 'Simulation_20191121',
    description: 'swine population simulation and breeding plan comparison in the genomic era',
    tags: ['swine', 'Simer'],
  },
];


export default function() {
  return (
    <Row gutter={24}>
      <Col xl={16} lg={16} md={24} sm={24} xs={24}>
        {/* <Card 
          title="Quick Start"
          style={{ marginBottom: 24 }}
        >
          <div className={styles.welcome} />
          <ul className={styles.list}>
            <li>To get started, edit <code>src/pages/index.js</code> and save to reload.</li>
            <li>
              <a href="https://umijs.org/guide/getting-started.html">
                Getting Started
              </a>
            </li>
          </ul>
        </Card> */}
        <Card 
          title="Quick Start"
          className={styles.templateList}
          style={{ marginBottom: 24 }}
          bodyStyle={{ padding: 0 }}
          bordered={false}
          extra={<Link to="/">All</Link>}
        >
          {template.map(item => (
                <Card.Grid className={styles.projectGrid} key={item.id}>
                  <Card bodyStyle={{ padding: 0 }} bordered={false}>
                    <Card.Meta
                      title={
                        <div className={styles.cardTitle}>
                          [<Link to={item.href}>{item.category}</Link>] <Link to={item.href}>{item.title}</Link>
                        </div>
                      }
                      description={item.description}
                    />
                    <div className={styles.projectItemContent}>
                      {item.tags.map(tag =>(
                        <Tag color={TAGS_COLOR[tag]}>{tag || ''}</Tag>
                      ))}
                    </div>
                  </Card>
                </Card.Grid>
              ))}
        </Card>
        <Card 
          title="Project List"
          // style={{ marginBottom: 24 }}
          bordered={false}
          extra={
            <Link to="/">All</Link>
            // <Button type="primary">New</Button>
          }
        >
          <Table 
            // tableLayout='auto'
            columns={columns} 
            dataSource={data}
          />
        </Card>
      </Col>
      <Col xl={8} lg={8} md={24} sm={24} xs={24}>
        <Card 
          title="Contact us"
          style={{ marginBottom: 24 }}
          bordered={false}
          extra={
            <a target="_blank" rel="noopener noreferrer" href="https://github.com/xiaolei-lab/IPAG">
              <Icon type="github" /> Github
            </a>
          }
        >
          <p style={{ fontWeight: "bold", marginBottom: 0}}>Email: <a href="mailto:xiaoleiliu@mail.hzau.edu.cn">xiaoleiliu@mail.hzau.edu.cn</a></p>
        </Card>
        <Card 
          title="News"
          style={{ marginBottom: 24 }}
          // bodyStyle={{ paddingLeft: 16 }}
          bordered={false}
          extra={
            <a href="#" >More</a>
          }
        >
          <ul style={{ paddingLeft: 16 }}>
            <li>HIBLUP 1.3 released (Nov 22, 2019)</li>
          </ul>
        </Card>
        <Card 
          title="Related Links"
          style={{ marginBottom: 24 }}
          bordered={false}
        >
          <ul style={{ paddingLeft: 16 }}>
            <li><a href="https://github.com/xiaolei-lab">xiaolei-lab</a></li>
            <li><a href="http://www.wutbiolab.com/">WUTbiolab</a></li>
            <li><a href="http://qtl.rocks/">QTL ROCKS</a></li>
          </ul>
        </Card>
        <Card 
          title="Publications"
          bordered={false}
        >
          ...
        </Card>
      </Col>
    </Row>
  );
}
