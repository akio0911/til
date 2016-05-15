//: Playground - noun: a place where people can play

import UIKit


protocol NameGettable {
    var name: String { get }
}

struct Person: NameGettable {
    var name: String
}

var s1 = Person(name: "sato")
s1.name = "x"

var p1: NameGettable = s1
// error: cannot assign to property: 'name' is a get-only property
p1.name = "x"
