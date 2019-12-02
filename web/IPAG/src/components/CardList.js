import React, { Component } from 'react';
import { connect } from 'dva';
import { List, Card, Pagination, Button, message } from 'antd';
import styles from './GS.css';
import { Link, routerRedux } from 'dva/router';


// class CardList extends Component {

//   render() {
//     return (
//       <div>
//         <List
//           grid={{
//             gutter: 16,
//             xs: 1,
//             sm: 2,
//             md: 4,
//             lg: 4,
//             xl: 6,
//             xxl: 3,
//           }}
//           dataSource={this.props.dataSource}
//           renderItem={item => (
//             <List.Item>
//               <Card 
//                 title={item.title}
//                 extra={<a href="#">Edit</a>}
//               >
//                 {item.description}
//               </Card>
//             </List.Item>
//           )}
//         />
//       </div>
//     );
//   }
// }
  
// export default CardList;