// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import { fabric } from "../vendor/fabric"

window.__fabric = fabric

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import LiveSocket from "phoenix_live_view"

let liveSocket = new LiveSocket("/live")
liveSocket.connect()

class Oracle {
  constructor(canvasId, submitButtonId, resetButtonId) {
    this.canvas = new fabric.Canvas(canvasId, {
      isDrawingMode: true
    });
    this.canvas.freeDrawingBrush.width = 20;
    this.canvas.freeDrawingBrush.color = "#FFFFFF";
    this.canvas.backgroundColor = "#000000";

    let submit = document.getElementById(submitButtonId);
    submit.addEventListener("click", this.handleSubmit.bind(this));

    let reset = document.getElementById(resetButtonId);
    reset.addEventListener("click", this.handleReset.bind(this));
  }

  handleSubmit() {
    let token = document.querySelector('[name=csrf-token]').getAttribute('content');
    let img = this.canvas.toDataURL({multiplier: 0.1});

    var xhr = new XMLHttpRequest();
    var setGuess = this.setGuess;

    xhr.onload = function(body) {
      if (xhr.status >= 200 && xhr.status < 300) {
        let resp = JSON.parse(xhr.responseText);
        setGuess(resp.guess);
      } else {
        setGuess("Error :(");
      }
    };

    xhr.open('POST', "/oracle")
    xhr.setRequestHeader("X-CSRF-Token", token);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(JSON.stringify({image: img}));
  }

  setGuess(msg) {
    document.getElementById("guess").textContent = msg;
  }

  handleReset() {
    this.canvas.clear();
    this.setGuess("Send me a number")
  }
}

if (document.getElementById("mnist-oracle")) {
  setTimeout(function() {
    // wire up handwriting canvas
    window.__oracle = new Oracle("draw-here", "submit", "reset");
  }, 1000);
}
