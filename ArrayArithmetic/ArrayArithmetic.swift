//
//  ArrayArithmetic.swift
//  ArrayArithmetic
//
//  Created by Alexander Cyon on 2017-05-17.
//  Copyright © 2017 ArrayArithmetic. All rights reserved.
//

import Foundation

protocol Identity: Comparable, Equatable {
    static var identity: Self { get }
}

protocol Addable: Identity {
    static func +(lhs: Self, rhs: Self) -> Self
}

protocol Subtractable: Identity {
    static func -(lhs: Self, rhs: Self) -> Self
}

typealias Countable = Identity & Addable & Subtractable

extension Int: Countable {
    static var identity: Int = 0
}

extension Double: Countable {
    static var identity: Double = 0
}

extension Float: Countable {
    static var identity: Float = 0
}

//MARK: - Reducable Protocol
typealias Next<Value, Artimetic> = (Value, Artimetic) -> Value
protocol Reducable {
    associatedtype Value: Identity
    var value: Value { get }
    static var next: Next<Value, Self> { get }
}

extension Collection where Iterator.Element: Reducable {
    func reduce(_ initial: Iterator.Element.Value = .identity) -> Iterator.Element.Value {
        return reduce(initial, Iterator.Element.next)
    }
}

//MARK: - Adding Protocol
protocol Adding {
    associatedtype Value: Addable
    var value: Value { get }
}

extension Adding {
    static var addition: Next<Value, Self> {
        return { return $0 + $1.value }
    }
}

extension Collection where Iterator.Element: Adding {
    func addition(initial: Iterator.Element.Value = .identity) -> Iterator.Element.Value {
        return reduce(initial, Iterator.Element.addition)
    }
}

//MARK: - Subtracting Protocol
protocol Subtracting {
    associatedtype Value: Subtractable
    var value: Value { get }
}

extension Subtracting {
    static var subtraction: Next<Value, Self> {
        return { return $0 - $1.value }
    }
}

extension Collection where Iterator.Element: Subtracting {
    func subtraction(initial: Iterator.Element.Value = .identity) -> Iterator.Element.Value {
        return reduce(initial, Iterator.Element.subtraction)
    }
}

typealias Counting = Subtracting & Adding

//MARK: - Postfix operator `+` and `-`
postfix operator +
postfix func +<Element: Adding>(array: [Element]) -> Element.Value {
    return array.addition()
}

postfix operator -
postfix func -<Element: Subtracting>(array: [Element]) -> Element.Value {
    return array.subtraction()
}

//MARK: Int - Counting
extension Int: Counting {
    var value: Int { return self }
}

//MARK: Float - Counting
extension Float: Counting {
    var value: Float { return self }
}
