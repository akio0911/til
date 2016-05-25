import Foundation


protocol PersonalType {
    init(name: String)
}

class Person1: PersonalType {
    var name: String
    required init(name: String) {
        self.name = name
    }
}

class Person2: Person1 {
    required init(name: String) {
        super.init(name: name)
    }
}

let p1 = Person1(name: "sato")
let p2 = Person2(name: "suzuki")

