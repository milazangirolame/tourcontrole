const { environment } = require('@rails/webpacker')

// Bootstrap 3 has a dependency over jQuery:

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery'
  })
)



// environment.config.merge({
//   module: {
//     rules: [
//      {
//         test: /\.erb$/,
//         enforce: 'pre',
//         loader: 'rails-erb-loader',
//         options: {
//           // dependenciesRoot: '../app',
//         }
//       },

//     ]
//   }
// });




module.exports = environment
