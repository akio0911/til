import Foundation



protocol P1 {
    
}

struct S1: P1 {
    
}

let s1: S1? = S1()

let x1: P1 = s1 as! P1

// Treating a forced downast to 'P1' as optional will never produce 'nil'
let x2: P1? = s1 as! P1
