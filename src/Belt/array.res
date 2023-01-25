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

Js.log("-------- make -----------")

Js.log(Array.make(3, "heyo")) // [ 'heyo', 'heyo', 'heyo' ]

Js.log("-------- makeBy -----------")

// let makeBy: (int, int => 'a) => array<'a>
// makeBy(n, fn)
// returns an empty array when n is negative
Js.log(Belt.Array.makeBy(5, (i) => i)) // [ 0, 1, 2, 3, 4 ]
Js.log(Belt.Array.makeBy(-5, (i) => i)) // []

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

Js.log("-------- range -----------")

Js.log(Array.range(4, 10)) // [4, 5,  6, 7, 8, 9, 10]

Js.log("-------- rangeBy -----------")

// range with a step
Js.log(Array.rangeBy(4, 10, ~step=2)) // [4, 6, 8, 10]


Js.log("-------- map -----------")
// let map: (array<'a>, 'a => 'b) => array<'b>
// map(xs, fn)

Js.log(Array.map([2, 4], (x) => x * x))

Js.log("-------- mapWithIndex -----------")
Js.log(Array.mapWithIndex([2, 4], (index, _) => index))

Js.log("-------- reduce -----------")
// reduce(arr, init, fn)

// Applies fn to each element of arr
// fn has two parameters, an accumulator which starts with a value of init and 
// the next value from the array
// return the final value of the accumulator
// reduce(arr, init, fn)

let initial = 0
Js.log(
    Array.reduce([2, 5], initial, (accumulator, value) => accumulator + value)
)

Js.log("-------- reverse -----------")
// immutable reverse 
// returns a fresh array with items in arr in reverse order.
Js.log(
    Array.reverse([10, 11, 14, 12, 13])
)

Js.log("-------- reverseInPlace -----------")
// mutable reverse
let arr = [10, 11, 14]
let _ = Array.reverseInPlace(arr)
Js.log(arr == [14, 11, 10])

Js.log("-------- shuffle -----------")
Js.log("-------- shuffleInPlace -----------")
// suffling with similar function as reverse

Js.log("-------- sliceToEnd -----------")
Js.log(
// useful for slicing passing and not having to pass array length
    Array.sliceToEnd([10, 11, 12, 13], 2)
)
Js.log("-------- some -----------")
// let some: (array<'a>, 'a => bool) => bool
// some(xs, p)
// Returns true if at least one of the elements in xs satisfies p
// where p is a predicate: a function taking an element and returning a bool
Js.log(
    Array.some([10, 11, 14], (x) => x == 17)
)

Js.log("-------- truncateToLenghtUnsafe -----------")
// truncateToLengthUnsafe(xs, n)
// mutable and unsafe truncate to length of array xs to n
// if n is greater than the length of xs; the extra elements are set to Js.Null_undefined.null
// Raises a `RangeError` if n is less than zero
let arr = ["ant", "bee", "cat"]
let _ = Array.truncateToLengthUnsafe(arr, 5)
Js.log(arr) // [ 'ant', 'bee', 'cat', <2 empty items> ]
let _ = Array.truncateToLengthUnsafe(arr, 2)
Js.log(arr == ["ant", "bee"])

Js.log("-------- zip -----------")
// let zip: (array<'a>, array<'b>) => array<('a, 'b)>
// zip(a, b)
// Create an array of pairs from corresponding elements of arrays a and b
// Stop with the shorter array
Js.log(
    Array.zip(["kitty", "bus"], ["cat", "stop", "ball"])
) // [("kitty", "cat"), ("bus", "stop")]

Js.log("-------- unzip -----------")
// takes an array of pairs and creates a pair of arrays
Js.log([("kitty", "cat"), ("bus", "stop")])

// Js.log("-------- blit -----------")
// Js.log("-------- blitUnsafe -----------")
// Js.log("-------- cmp -----------")
// Js.log("-------- concat -----------")
// Js.log("-------- concatMany -----------")
// Js.log("-------- copy -----------")
// Js.log("-------- eq -----------")
// Js.log("-------- every -----------")
// Js.log("-------- fill -----------")
// Js.log("-------- forEach -----------")
// Js.log("-------- forEachWithIndex -----------")
// Js.log("-------- keep -----------")
// Js.log("-------- keepMap -----------")
// Js.log("-------- keepMapWithIndex -----------")