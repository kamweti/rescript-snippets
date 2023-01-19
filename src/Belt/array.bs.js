// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Caml_obj = require("rescript/lib/js/caml_obj.js");
var Belt_Array = require("rescript/lib/js/belt_Array.js");
var Caml_js_exceptions = require("rescript/lib/js/caml_js_exceptions.js");

var letters = [
  "a",
  "b",
  "c"
];

console.log(Caml_obj.equal(Belt_Array.get(letters, 0), "a"));

console.log(Caml_obj.equal(Belt_Array.get(letters, 0), "a"));

try {
  console.log(Belt_Array.getExn(letters, 25));
}
catch (raw_exn){
  var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  if (exn.RE_EXN_ID === "Assert_failure") {
    console.log("exception thrown: index out of range");
  } else {
    throw exn;
  }
}

var x = letters[32];

console.log(x);

console.log(false);

var x$1 = letters[0];

console.log(Caml_obj.equal(x$1, "a"));

exports.letters = letters;
exports.x = x$1;
/*  Not a pure module */
