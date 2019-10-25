import React, { Component } from 'react'
import { Container, Row, Col, Card, CardBody } from 'reactstrap'

import BinsInput from '../components/BinsInput'
import Histogram from '../components/Histogram'

class Test extends Component {
  constructor(props) {
    super(props)
    this.state = {
      bins: 30,
      histogramData: null
    }
  }

  componentDidMount() {
    window.$(document).on('shiny:connected', () => {
      this.setInputValues()
    })

    window.Shiny.addCustomMessageHandler('histogramData', histogramData =>
      this.setState({ histogramData })
    )
  }

  componentDidUpdate() {
    this.setInputValues()
  }

  setInputValues() {
    window.Shiny.onInputChange('bins', this.state.bins)
  }

  handleBinsChange= (value) => {
    this.setState({ bins: value })
  }

  render() {
    const { bins, histogramData } = this.state
    return (
      <div style={{ background: '#fff', padding: 24, margin: '16px 0', minHeight: 480 }}>
        <Container fluid>
          <h2 className="mt-3">Old Faithful Geyser Data</h2>
          <Row>
            <Col sm="4">
              <Card style={{ backgroundColor: '#f5f5f5' }}>
                <CardBody>
                  <BinsInput
                    value={bins}
                    options={[10, 20, 30, 40, 50]}
                    onChange={this.handleBinsChange}
                  />
                </CardBody>
              </Card>
            </Col>
            <Col sm="8">
              {histogramData && (
                <Histogram {...histogramData} xAxisLabel="Waiting time to next eruption (mins)" />
              )}
            </Col>
          </Row>
        </Container>
      </div >
    )
  }
}

export default Test
