//: [Previous](@previous)

import Foundation

// Foundation contains a type calles NSPredicate

class Person: NSObject {
    @objc let age: Int
    
    init(age: Int) {
        self.age = age
    }
}

let nsarray: NSArray = [Person(age: 45), Person(age: 12), Person(age: 23), Person(age: 86), Person(age: 16)]

let predicate = NSPredicate(format: "age > 18")

nsarray.filtered(using: predicate)

// But it only works with classes that inherit from NSObject
// and on properties exposed to ObjC.
// It's also stringly types and throws runtime error 😭

// Let's try to improve this by defining our own type-safe predicate system!

// Here's the kind of syntax that we want to achieve:
// people.filter(where: \.age > 18)

struct Predicate<Element> {
    private let evaluator: (Element) -> Bool
    
    init(evaluator: @escaping (Element) -> Bool) {
        self.evaluator = evaluator
    }
    
    func evaluate(with element: Element) -> Bool {
        self.evaluator(element)
    }
}

func > <Element, Value: Comparable>(_ keyPath: KeyPath<Element, Value>, _ constant: Value) -> Predicate<Element> {
    return Predicate(evaluator: { element in
        return element[keyPath: keyPath] > constant
    })
}

extension Sequence {
    func filter(where predicate: Predicate<Element>) -> [Element] {
        return self.filter { element in
            return predicate.evaluate(with: element)
        }
    }
}

let people = [Person(age: 45), Person(age: 12), Person(age: 23), Person(age: 86), Person(age: 16)]

people.filter(where: \.age > 18)

// Kind of cool, isn't it?

// Now let's try to compose predicates together!

func && <Element>(_ lhs: Predicate<Element>, _ rhs: Predicate<Element>) -> Predicate<Element> {
    return Predicate { element in
        return lhs.evaluate(with: element) && rhs.evaluate(with: element)
    }
}

func < <Element, Value: Comparable>(_ keyPath: KeyPath<Element, Value>, _ constant: Value) -> Predicate<Element> {
    return Predicate(evaluator: { element in
        return element[keyPath: keyPath] < constant
    })
}

people.filter(where: \.age > 18 && \.age < 80)

//: [Next](@next)
