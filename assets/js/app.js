// We need to require the CSS so that Typescript will ignore
// it when parsing and then webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
const _css = require("../css/app.css");

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import "@shopify/app-bridge"
