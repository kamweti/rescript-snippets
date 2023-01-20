open Belt

/** Utilities for array functions **/


let letters = ["a", "b", "c"]

Js.log("-------- get -----------")

Js.log(letters->Array.get(0) == Some("a"))
// alternatively
Js.log(letters[0] == Some("a")) // since ReScript transforms the [] index syntax into a function Array.get()

Js.log("-------- getExn -----------")

// Raises an exception if i is out of range

try {
    Js.log(letters->Array.getExn(25))
} catch {
| Assert_failure(_) => Js.log("exception thrown: index out of range")
}


Js.log("-------- getUnsafe -----------")

// Has no bounds checking
// returns undefined if i is out of range

let x = letters->Array.getUnsafe(32)
Js.log(x) // undefined

// make it safe: wrap it in an option type
Js.log(Some(x) == None) // true

let x = letters->Array.getUnsafe(0)
Js.log(Some(x) == Some("a")) // true


Js.log("-------- getUndefined -----------")

// does the same thing as getUnsafe only that 
// returns Js.undefined if i is out of range

let x = letters->Array.getUndefined(32)
Js.log(x == Js.undefined) // true

Js.log(letters->Array.getUndefined(0))

Js.log("-------- set -----------")

// rescript arrays are mutable
// set modifies array in place
// Returns false if i is out of range


let _ = letters->Array.set(1, "z")
Js.log(letters) // [ 'a', 'z', 'c' ]


Js.log("-------- setExn -----------")

// same as set 
// returns exception if i is out of range

try {
    let _ = letters->Array.setExn(223, "z")
} catch {
| Assert_failure(_) => Js.log("exception thrown: index out of range")
}

Js.log("-------- setUnsafe -----------")

// same as set 
// returns undefined if i is out of range
// Important!: it will still set item in index 
// and fills missing indexes with undefined value


let zz = ["a", "b", "c"] 
Js.log(zz->Array.setUnsafe(20, "tes")) // undefined
Js.log(zz) // [ 'a', 'z', 'c', <17 empty items>, 'tes' ]

Js.log("-------- shuffleInPlace -----------")

// mutable shuffle
// randomly re-orders the items in arr

Js.log(letters->Array.shuffleInPlace) // undefined
Js.log(letters)


Js.log("-------- shuffle -----------")

// immutable shuffle 
// Returns a fresh array with items in original array randomly shuffled

let zz = ["a", "b", "c"] 
Js.log(zz->Array.shuffle) // shuffled array
Js.log(zz) // ["a", "b", "c"] original array unchanged

Js.log("-------- reverseInPlace -----------")

// mutable reverse 
let zz = ["a", "b", "c"]
Js.log(zz->Array.reverseInPlace) // undefined
Js.log(zz) // [ 'c', 'b', 'a' ]

Js.log("-------- reverse -----------")

// immutable reverse 

let zz = ["a", "b", "c"]
Js.log(zz->Array.reverse) // [ 'c', 'b', 'a' ]
Js.log(zz) // ["a", "b", "c"]


Js.log("-------- makeUninitialized -----------")

// let makeUninitialized: int => array<Js.undefined<'a>>
// creates an array of length n filled with undefined value
// you must specify the type of data that will eventually fill the array

let arr: array<Js.undefined<string>> = Array.makeUninitialized(3)

Js.log(arr) // [undefined, undefined, undefined]
Js.log(arr->Array.getExn(0) == Js.undefined) // true
Js.log(arr)

// setting at index
try {
    let _ = arr->Array.setExn(0, Js.Undefined.fromOption(Some("a")))
    Js.log(arr) // [ 'a', <2 empty items> ]
} catch {
| Assert_failure(_) => Js.log("exception thrown: index out of range")
}

Js.log("-------- makeUninitializedUnsafe -----------")

// similar to makeUninitialized but:
// - type of data is not enforced in annotation
// - type is activated after usage, either by setting or comparison

// be careful not to call getExn(0) == Js.undefined after initializing as this
// implicitly activates type array<Js.undefined<'a>>

let arr = Array.makeUninitializedUnsafe(3)
Js.log(arr->Array.getExn(0)) // undefined
arr->Array.setExn(0, "example")
Js.log(arr) // [ 'example', <2 empty items> ]
Js.log(arr->Array.getExn(1)) // undefined
