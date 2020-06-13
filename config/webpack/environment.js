const { environment } = require('@rails/webpacker')
const coffee =  require('./loaders/coffee')
const webpack = require('webpack')

environment.loaders.prepend('coffee', coffee)

environment.plugins.insert(
  'IgnorePlugin',
  new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/)
)

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
  })
)

module.exports = environment
