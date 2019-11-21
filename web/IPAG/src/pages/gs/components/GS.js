import React from 'react';
import { connect } from 'dva';
import { List, Card, Steps, Button, message } from 'antd';
import styles from './GS.css';
import { Link, routerRedux } from 'dva/router';

const { Step } = Steps;
const { Meta } = Card;

const steps = [
  {
    title: 'Select Template',
    content: 'First-content',
  },
  {
    title: 'Set Parameters',
    content: 'Third-content',
  },
  {
    title: 'Select Files',
    content: 'Second-content',
  },
  
  {
    title: 'Run',
    content: 'Last-content',
  },
];

class GS extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      current: props.current_step,
    };
  }

  onChange = current => {
    this.setState({ current });
  };

  next() {
    const current = this.state.current + 1;
    this.setState({ current });
  }

  prev() {
    const current = this.state.current - 1;
    this.setState({ current });
  }

  render() {
    const { current } = this.state;
    return (
      <div>
        <Steps
          type="navigation"
          current={current}
          onChange={this.onChange}
        >
          {steps.map(item => (
            <Step key={item.title} title={item.title} description={item.description}/>
          ))}
        </Steps>
        <div className={styles.stepsContent}>
          {current === 0 && (
            <List grid={{ gutter: 16, column: 2 }}>
              <List.Item className={styles.card}>
                <Card
                  hoverable
                  style={{ width: 240 }}
                  cover={
                    <img alt="Freqentist method" src="data:image/png;base64,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" />
                  }
                >
                  <Meta 
                    title="Freqentist method" 
                    description={
                      <p>Powered by <a href="https://github.com/xiaolei-lab/rMVP" target="_blank" rel="noopener noreferrer">rMVP</a> and <a href="https://github.com/xiaolei-lab/HIBLUP" target="_blank" rel="noopener noreferrer">HIBLUP</a></p>
                    }
                  />
                </Card>
              </List.Item>
              <List.Item className={styles.card}> 
                <Card
                  hoverable
                  style={{ width: 240 }}
                  cover={
                    <div style={{ height:240, width: 240 }}>
                      <img style={{ display: 'block', width: '100%' }} alt="Bayesian method" src="data:image/png;base64,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" />
                    </div>
                  }
                >
                  <Meta 
                    title="Bayesian method" 
                    description={<p>Powered by <a href="https://github.com/reworkhow/JWAS.jl" target="_blank" rel="noopener noreferrer">JWAS.jl</a></p>}
                  />
                </Card>
              </List.Item>
            </List>
          )}
        </div>
        <div className={styles.stepsContent}>{steps[current].content}</div>
        <div className={styles.stepsAction}>
          {current < steps.length - 1 && (
            <Button type="primary" onClick={() => this.next()}>
              Next
            </Button>
          )}
          {current === steps.length - 1 && (
            <Button type="primary" onClick={() => message.success('Processing complete!')}>
              Done
            </Button>
          )}
          {current > 0 && (
            <Button style={{ marginLeft: 8 }} onClick={() => this.prev()}>
              Previous
            </Button>
          )}
        </div>
      </div>
    );
  }
}

function mapStateToProps(state) {
  const { current_step } = state.gs;
  return {
    current_step
    // loading: state.loading.models.gs,
  };
}
  
export default connect(mapStateToProps)(GS);