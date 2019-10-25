const webpack = require('webpack')

module.exports = {
  output: {
    // Serve the bundle from /static
    publicPath: '/static/'
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: 'babel-loader'
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      },
      {
        test: /\.less$/,
        use: [{
          loader: 'style-loader',
        }, { 
          loader: 'css-loader',
        }, {
          loader: 'less-loader',
          options: {
            modifyVars: {
              'primary-color': '#7cb305',
              'link-color': '#7cb305',
              'border-radius-base': '2px',
            },
            javascriptEnabled: true,
          }
        }]
      }
    ]
  },

  plugins: [new webpack.HotModuleReplacementPlugin()],

  devServer: {
    hot: true,
    port: 4000,
    // Proxy everything besides the bundle to Shiny
    proxy: {
      '/': {
        target: 'http://localhost:3000'
      },
      '/websocket': {
        target: 'ws://localhost:3000',
        ws: true
      }
    }
  }
}
