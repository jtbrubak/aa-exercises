class DOMNodeCollection {

  constructor(arr) {
    this.arr = arr;
  }

  html(str) {
    if (typeof str === 'string') {
      this.arr.forEach((node) => node.innerHTML = str);
    } else {
      return this.arr[0].innerHTML;
    }
  }

  empty() {
    this.arr.forEach((node) => node.innerHTML = "");
  }

  append(arg) {
    if (arg instanceof DOMNodeCollection) {
      this.arr.forEach((node) => {
        arg.arr.forEach((appendedNode) => {
          node.appendChild(appendedNode.outerHTML));
        }
      }
    } else if (arg instanceof HTMLElement) {
      this.arr.forEach((node) => node.appendChild(arg.outerHTML));
    } else {
      this.arr.forEach((node) => node.innerHTML += arg);
    }
  }

}

module.exports = DOMNodeCollection;
