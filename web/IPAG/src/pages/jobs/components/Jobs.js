import { connect } from 'dva';
import { Table, Pagination, Popconfirm, Badge, Icon, Input, Button } from 'antd';
import styles from './Jobs.css';
import { PAGE_SIZE, STATUS_MAP } from '../constants';
import { routerRedux } from 'dva/router';
// import Highlighter from 'react-highlight-words';

function Jobs({ dispatch, list: dataSource, loading, total, page: current }) {
  function deleteHandler(id) {
    dispatch({
      type: 'jobs/remove',
      payload: id,
    });
  }

  // function editHandler(id, values) {
  //   dispatch({
  //     type: 'jobs/patch',
  //     payload: { id, values },
  //   });
  // }

  // function createHandler(values) {
  //   dispatch({
  //     type: 'jobs/create',
  //     payload: values,
  //   });
  // }

  function pageChangeHandler(page) {
    dispatch(routerRedux.push({
      pathname: '/jobs',
      query: { page },
    }));
  }

  function getColumnSearchProps(dataIndex) {
    return {
      filterDropdown: ({ setSelectedKeys, selectedKeys, confirm, clearFilters }) => (
        <div style={{ padding: 8 }}>
          <Input
            ref={node => {
              this.searchInput = node;
            }}
            placeholder={`Search ${dataIndex}`}
            value={selectedKeys[0]}
            onChange={e => setSelectedKeys(e.target.value ? [e.target.value] : [])}
            onPressEnter={() => handleSearch(selectedKeys, confirm)}
            style={{ width: 188, marginBottom: 8, display: 'block' }}
          />
          <Button
            type="primary"
            onClick={() => handleSearch(selectedKeys, confirm)}
            icon="search"
            size="small"
            style={{ width: 90, marginRight: 8 }}
          >
            Search
          </Button>
          <Button onClick={() => handleReset(clearFilters)} size="small" style={{ width: 90 }}>
            Reset
          </Button>
        </div>
      ),
      filterIcon: filtered => (
        <Icon type="search" style={{ color: filtered ? '#1890ff' : undefined }} />
      ),
      onFilter: (value, record) =>
        record[dataIndex]
          .toString()
          .toLowerCase()
          .includes(value.toLowerCase()),
      onFilterDropdownVisibleChange: visible => {
        if (visible) {
          setTimeout(() => this.searchInput.select());
        }
      },
      render: text => (
        // <Highlighter
        //   highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
        //   searchWords={[this.state.searchText]}
        //   autoEscape
        //   textToHighlight={text.toString()}
        // />
        text.toString()
      ),
    }
  };

  function handleSearch(selectedKeys, confirm) {
    confirm();
    this.setState({ searchText: selectedKeys[0] });
  };

  function handleReset(clearFilters) {
    clearFilters();
    this.setState({ searchText: '' });
  };

  const columns = [
    {
      title: 'ID',
      dataIndex: 'id',
      key: 'id',
      // render: text => <a href="">{text}</a>,
      // ...getColumnSearchProps('id')
    },
    {
      title: 'Name',
      dataIndex: 'name',
      key: 'name',
    },
    {
      title: 'Status',
      dataIndex: 'status',
      key: 'status',
      render: status => <Badge status={STATUS_MAP[status]["status"]} text={STATUS_MAP[status]["text"]} />
    },
    {
      title: 'Creation time',
      dataIndex: 'creation_time',
      key: 'creation_time',
    },
    {
      title: 'End time',
      dataIndex: 'end_time',
      key: 'end_time',
    },
    {
      title: 'Operation',
      key: 'operation',
      render: (text, record) => (
        <span className={styles.operation}>
          {/* <JobModal record={record} onOk={editHandler.bind(null, record.id)}>
            <a>Edit</a>
          </JobModal> */}
          <Popconfirm title="Confirm to delete?" onConfirm={deleteHandler.bind(null, record.id)}>
            <a href="">Delete</a>
          </Popconfirm>
        </span>
      ),
    },
  ];

  return (
    <div>
      <div>
        {/* <div className={styles.create}>
          <JobModal record={{}} onOk={createHandler}>
            <Button type="primary">Create Job</Button>
          </JobModal>
        </div> */}
        <Table
          loading={loading}
          columns={columns}
          dataSource={dataSource}
          rowKey={record => record.id}
          pagination={false}
        />
        <Pagination
          className="ant-table-pagination"
          total={total}
          current={current}
          pageSize={PAGE_SIZE}
          onChange={pageChangeHandler}
        />
      </div>
    </div>
  );
}

function mapStateToProps(state) {
  const { list, total, page } = state.jobs;
  return {
    list,
    total,
    page,
    loading: state.loading.models.jobs,
  };
}

export default connect(mapStateToProps)(Jobs);