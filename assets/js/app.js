/* eslint-disable no-underscore-dangle, @typescript-eslint/no-var-requires, import/order, import/first, import/extensions, max-len, import/no-unresolved, react/jsx-filename-extension
*/
/* global document */

// We need to require the CSS so that Typescript will ignore
// it when parsing and then webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
const _css = require('../css/app.css');

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import 'phoenix_html';

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import '@shopify/app-bridge';
import React from 'react';
import ReactDom from 'react-dom';

import Main from './main';

ReactDom.render(
  <Main name="your new App" />,
  document.querySelector('main'),
);
