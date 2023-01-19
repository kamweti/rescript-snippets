let letters = ["a", "b", "c"]
// let x = letters[10] // Raises an exception 'index out of bounds'

// Js.log(Js.String.toUpperCase(letters[0])) // A


// Belt avoids exceptions and returns option instead

open Belt
let x = letters[10]
Js.log(x == None) // true

// Js.String.toUpperCase(letters[0]) // Type error array item is of typ option<string>

// correct way
Js.log( 
    switch letters[0] {
    | Some(y) => Js.String.toUpperCase(y)
    | None => ""
    }
)