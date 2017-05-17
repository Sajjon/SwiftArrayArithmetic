//
//  Demo.swift
//  ArrayArithmetic
//
//  Created by Alexander Cyon on 2017-05-17.
//  Copyright © 2017 ArrayArithmetic. All rights reserved.
//

import Foundation
import UIKit

//MARK: IntHolder - Reducable (Addition)
struct IntHolder {
    let value: Int
    init(_ value: Int) { self.value = value }
}

extension IntHolder: Reducable {
    static var next: Next<Int, IntHolder> {
        return { return $0 + $1.value }
    }
}

//MARK: FloatHolder - Adding/Subtracting
struct FloatHolder {
    let value: Float
    init(_ value: Float) { self.value = value }
}

extension FloatHolder: Adding {}
extension FloatHolder: Subtracting {}

extension CGFloat: Countable {
    static var identity: CGFloat = 0
}

extension CGPoint: Adding {
    var value: CGFloat { return x }
}

func demo() {
    let integers = [1, 2, 3, 4]
    print("integers adding: \(integers.addition())")
    print("integers (+): \(integers+)")
    print("integers subtracting: \(integers.subtraction())")
    print("integers (-): \(integers-)")
    
    let floats: [Float] = [1, 2, 3, 4]
    print("floats adding: \(floats.addition())")
    print("floats (+): \(floats+)")
    print("floats subtracting: \(floats.subtraction())")
    print("floats (-): \(floats-)")
    
    let intHolders = [1, 2, 3, 4].map { IntHolder($0) }
    print("IntHolder reduce (addition): \(intHolders.reduce())")
    
    let floatHolders = [1, 2, 3, 4].map { FloatHolder($0) }
    print("float addition: \(floatHolders.addition())")
    print("float (+): \(floatHolders+)")
    print("float subtraction: \(floatHolders.subtraction())")
    print("float (-): \(floatHolders-)")
    
    let points = [CGPoint(x: 1, y: 5), CGPoint(x: 2, y: 6)]
    print("points addition (+): \(points+)")
}
