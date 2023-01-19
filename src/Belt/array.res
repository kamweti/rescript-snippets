open Belt

/** Utilities for array functions **/


let letters = ["a", "b", "c"]

// -------- get -----------

Js.log(letters->Array.get(0) == Some("a"))
// alternatively
Js.log(letters[0] == Some("a")) // since ReScript transforms the [] index syntax into a function Array.get()

// -------- getExn -----------

// Raises an exception if i is out of range

try {
    Js.log(letters->Array.getExn(25))
} catch {
| Assert_failure(_) => Js.log("exception thrown: index out of range")
}


// -------- getUnsafe -----------

// Has no bounds checking
// returns undefined if i is out of range

let x = letters->Array.getUnsafe(32)
Js.log(x) // undefined

// make it safe: wrap it in an option type
Js.log(Some(x) == None) // true

let x = letters->Array.getUnsafe(0)
Js.log(Some(x) == Some("a")) // true


// -------- getUndefined -----------

// does the same thing as getUnsafe only that 
// returns Js.undefined if i is out of range

let x = letters->Array.getUndefined(32)
Js.log(x == Js.undefined) // true

Js.log(letters->Array.getUndefined(0))