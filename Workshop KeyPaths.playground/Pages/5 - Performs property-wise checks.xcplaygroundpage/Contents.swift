//: [Previous](@previous)

import Foundation

struct Predicate<Element> {
    private let evaluator: (Element) -> Bool
    
    init(evaluator: @escaping (Element) -> Bool) {
        self.evaluator = evaluator
    }
    
    func evaluate(with element: Element) -> Bool {
        self.evaluator(element)
    }
}

func == <Element, Value: Equatable>(_ keyPath: KeyPath<Element, Value>, _ constant: Value) -> Predicate<Element> {
    return Predicate(evaluator: { element in
        return element[keyPath: keyPath] == constant
    })
}

func && <Element>(_ lhs: Predicate<Element>, _ rhs: Predicate<Element>) -> Predicate<Element> {
    return Predicate { element in
        return lhs.evaluate(with: element) && rhs.evaluate(with: element)
    }
}

struct Validator<Element> {
    let validee: Element
    let predicate: Predicate<Element>
    
    func validate() -> Bool {
        return predicate.evaluate(with: validee)
    }
}

protocol Validatable { }

extension Validatable {
    func add(validation predicate: Predicate<Self>) -> Validator<Self> {
        return Validator<Self>(validee: self,
                               predicate: predicate)
    }
}

extension Validator {
    func add(validation predicate: Predicate<Element>) -> Validator<Element> {
        return Validator<Element>(validee: self.validee, predicate: self.predicate && predicate)
    }
}

struct User {
    let id: String
    let firstName: String
    let lastName: String
}
    
let user1 = User(id: "1", firstName: "John", lastName: "Lennon")
let user2 = User(id: "2", firstName: "Ringo", lastName: "Starr")

extension User: Validatable { }

user1.add(validation: \.id.isEmpty == false)
     .add(validation: \.lastName == "Lennon")
     .validate() // true

user2.add(validation: \.id.isEmpty == false)
     .add(validation: \.lastName == "Lennon")
     .validate() // false

//: [Next](@next)
