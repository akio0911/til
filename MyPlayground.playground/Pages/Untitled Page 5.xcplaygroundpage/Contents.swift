//: [Previous](@previous)

import Foundation


protocol Copyable {
    func copy() -> Self
}

class Data: Copyable {
    required init() {}
    
    func copy() -> Self {
        return self.dynamicType.init()
    }
}

class SpecialData: Data {}

let data1: Data        = Data().copy()
let data2: SpecialData = SpecialData().copy()

data1.dynamicType // Data.Type
data2.dynamicType // SpecialData.Type

let copyable: Copyable = data2

// error: cannot convert value of type 'Copyable' to specified type 'SpecialData'
// let copy1: SpecialData = copyable.copy() // NG 🙅🏻

let copy2: Copyable = copyable.copy()

