import UIKit

class Stack {
    var array : [Int] = []
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    func pop() {
        array.removeLast()
    }
    
    func push(_ value: Int) {
        array.append(value)
    }
}

extension Stack : CustomStringConvertible
{
    var description: String {
        return String(describing: array)
    }
}
let stack = Stack()
stack.push(5)
stack.push(6)
stack.push(7)
print(stack)

stack.pop()
stack.pop()
print(stack)
stack.push(8)
print(stack)
stack.pop()
stack.pop()
print(stack)

