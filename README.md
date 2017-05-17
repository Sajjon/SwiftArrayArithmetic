## Why?
```swift
// Because given this array:
let intHolders: [IntValue] = [...] // type holding `Int` value

// It is cooler to write this:
let sum = intHolders+ // sum has type `Int`

// ...than this:
let sum = intHolders.reduce(0, { $0 + $1.value }) // sum has type `Int` 
```

## What?
This project makes it super convenience to apply addition, subtraction or what ever function you would like to arrays containting `Int`, `Float`, `Double` or your own types!

```swift
let integers = [1, 2, 3, 4]

// vanilla sum
let sum = integers.reduce(0, +)

// now
let sum = integers.addition(initial: 0)

// or if initial value is 0
let sum = integers.addition()

// and even shorter, using the power of postfix operator (assuming initial value of zero)
let sum = integers+
```

It does not get much more concise than that.

### Custom types
Using `reduce` with custom types (that have some type of value of interest) is a bit more work.

```swift

struct IntHolder {
    let value: Int
    init(_ value: Int) { self.value = value }
}

let intHolders = [1, 2, 3, 4].map { IntHolder($0) }

// vanilla sum
let sum = intHolders.reduce(0, { $0 + $1.value })
```

Surely we can sorten it, if we declare this `func +`
```swift
func +(lhs: Int, rhs: IntHolder) -> Int {
    return lhs + rhs.value
}
```

Then we can write like this

```swift
let sum = intHolders.reduce(0, +)
```

But how fun is that really? And would it not be cool if we could write?

```swift
let sum = intHolders.addition(initial: 0)
```

Or in those situations (most cases) where `0` is the initial value:


```swift
let sum = intHolders+
```

## How?
The only thing you have to do in order to allow this is to write:
```swift
extension IntHolder: Adding {}
```

Where the protocol `Adding` looks like this:

```swift
protocol Adding {
    associatedtype Value: Addable
    var value: Value { get }
}
```

Where `Int` already conforms to `Addable`

```swift
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
```