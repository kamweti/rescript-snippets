open Belt

/** Utilities for array functions **/


// -------- get -----------

let letters = ["a", "b", "c"]
Js.log(letters->Array.get(0) == Some("a"))
// alternatively
Js.log(letters[0] == Some("a")) // since ReScript transforms the [] index syntax into a function Array.get()

// -------- getExn -----------

// Raise an exception if i is out of range

try {
    Js.log(letters->Array.getExn(25))
} catch {
| Assert_failure(_) => Js.log("exception thrown: index out of range")
}