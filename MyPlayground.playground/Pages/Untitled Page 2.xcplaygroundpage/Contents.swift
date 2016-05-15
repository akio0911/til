import Foundation


protocol NameGettable {
    func getName() -> String
}

struct Person: NameGettable {
    private var name: String
    
    func getName() -> String {
        return name
    }
    
    mutating func setName(name: String) {
        self.name = name
    }
}

var s1 = Person(name: "akio")
s1.getName() // 🙆🏻
s1.setName("suzuki") // 🙆🏻

var p1: NameGettable = s1
p1.getName() // 🙆🏻
p1.setName("tanaka") // 🙅🏻

