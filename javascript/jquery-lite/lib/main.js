var DOMNodeCollection = require('./dom_node_collection.js');

window.$l = function(arg) {
  if (arg instanceof HTMLElement) {
    return new DOMNodeCollection([arg]);
  } else {
    var arr =  Array.prototype.slice.call(document.querySelectorAll(arg));
    return new DOMNodeCollection(arr);
  }
}
