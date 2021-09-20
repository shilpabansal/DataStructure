import UIKit

struct Stack<T> {
    private var storage: [T] = [T]()
    
    mutating func push(_ element: T) {
        storage.append(element)
    }
    
    mutating func pop() -> T? {
        if storage.isEmpty {
            return nil
        }
        return storage.popLast()
    }
    
    func isEmpty() -> Bool {
        return storage.isEmpty
    }
}

func isParantheseBalanced(in string: String) -> Bool {
    var stack = Stack<Character>()
    
    for character in string {
        if character == "(" {
            stack.push(character)
        }
        else if character == ")" {
            if stack.pop() == nil {
                return false
            }
        }
    }
    return stack.isEmpty()
}

print("String 1: \(isParantheseBalanced(in: "(A+B)"))")
print("String 2: \(isParantheseBalanced(in: "((A+B))"))")
print("String 3: \(isParantheseBalanced(in: "(A+B))"))")
print("String 4: \(isParantheseBalanced(in: "((A+B)"))")
print("String 5: \(isParantheseBalanced(in: "(((((A+B))"))")




