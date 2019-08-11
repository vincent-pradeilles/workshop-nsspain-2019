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
    return DoubleTypePredicate(evaluator: { lhs, rhs in lhs[keyPath: leftAttribute] == rhs[keyPath: rightAttribute] })
}

extension Sequence {
    func join<OtherElement>(with sequence: Array<OtherElement>,
                                   where predicate: DoubleTypePredicate<Element, OtherElement>) -> [(Element, OtherElement)] {
        var result: [(Element, OtherElement)] = []
        
        for leftValue in self {
            for rightValue in sequence {
                if predicate.evaluate(for: leftValue, and: rightValue) {
                    result.append((leftValue, rightValue))
                }
            }
        }
        
        return result
    }
}

contacts.join(with: contacts, where: \.firstName == \.lastName)

//: [Next](@next)
