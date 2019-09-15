//: [Previous](@previous)

import Foundation

// We're doing pretty good, but let's try an keep pushing the limits!

// Consider the following data:

struct Person {
    let firstName: String
    let lastName: String
}

let contacts = [
    Person(firstName: "Charlie", lastName: "Webb"),
    Person(firstName: "Alex", lastName: "Elexson"),
    Person(firstName: "Charles", lastName: "Webb"),
    Person(firstName: "Alex", lastName: "Zunino"),
    Person(firstName: "Alex", lastName: "Alexson"),
    Person(firstName: "John", lastName: "Webb"),
    Person(firstName: "Webb", lastName: "Elexson")
]

// Say that we need to implement a join operation
// We want to achieve it with this syntax:
// contacts.join(with: contacts, .where(\.firstName == \.lastName)

struct DoubleTypePredicate<Element, OtherElement> {
    
    private let evaluator: (Element, OtherElement) -> Bool
    
    public init(evaluator: @escaping (Element, OtherElement) -> Bool) {
        self.evaluator = evaluator
    }
    
    public func evaluate(for leftElement: Element, and rightElement: OtherElement) -> Bool {
        return evaluator(leftElement, rightElement)
    }
}

func == <Element, OtherElement, T: Equatable>(_ leftAttribute: KeyPath<Element, T>, _ rightAttribute: KeyPath<OtherElement, T>) -> DoubleTypePredicate<Element, OtherElement> {
    // 👩🏽‍💻👨🏼‍💻 Implement `func ==`
}

extension Sequence {
    func join<OtherElement>(with sequence: Array<OtherElement>,
                                   where predicate: DoubleTypePredicate<Element, OtherElement>) -> [(Element, OtherElement)] {
        // 👩🏽‍💻👨🏼‍💻 Implement `func join()`
    }
}

contacts.join(with: contacts, where: \.firstName == \.lastName)

//: [Next](@next)
