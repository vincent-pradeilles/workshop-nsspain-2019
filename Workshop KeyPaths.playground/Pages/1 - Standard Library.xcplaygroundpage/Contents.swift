//: [Previous](@previous)

import Foundation

// Swift makes a heavy use of closures within its standard library
// Think of function like filter(), map(), sort(), etc.

// How about we try to make these function work with KeyPaths?

// Let's begin with filter()!

extension Sequence {
    func filter(_ keyPath: KeyPath<Element, Bool>) -> [Element] {
        return self.filter { $0[keyPath: keyPath] }
    }
}

let data = [1, 2, 3, 4, 5, 6, 7 ,8, 9]

extension Int {
    var isEven: Bool { return (self % 2) == 0}
}

data.filter(\.isEven)

// Let's move on to map() 💪

extension Sequence {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return self.map { $0[keyPath: keyPath] }
    }
}

data.map(\.description)

// That's pretty cool, but we need to write a wrapper for each function 😔

// However, notice how the two following expressions implement the same requirement

let getterWithKeyPath = \String.count

let getterWithClosure = { (string: String) in string.count }

// How about we try to turn a KeyPath into a getter function?

func get<Root, Value>(_ keyPath: KeyPath<Root, Value>) -> (Root) -> Value {
    return { (root: Root) -> Value in
        return root[keyPath: keyPath]
    }
}

data.map(get(\.description))

// And we can even aim for a shorter syntax!

prefix operator ^

prefix func ^<Root, Value>(_ keyPath: KeyPath<Root, Value>) -> (Root) -> Value {
    return get(keyPath)
}

data.map(^\.description)

// By adding a single character, many functions of the Standard Library now work with KeyPaths 🥳

//: [Next](@next)
