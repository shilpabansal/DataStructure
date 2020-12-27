import UIKit

class TreeNode<T: Equatable> : Equatable {
    var value: T
    var children : [TreeNode<T>]
    var tag: Int
    
    init(_ value: T, _ children:  [TreeNode<T>],_ tag: Int) {
        self.value = value
        self.children = children
        self.tag = tag
    }
    
    func append(_ child: TreeNode<T>) {
        self.children.append(child)
    }
    
    static func ==(lhs: TreeNode<T>, rhs: TreeNode<T>) -> Bool {
        return lhs.value == rhs.value && lhs.tag == rhs.tag
    }
    
    func removeItem(_ child: TreeNode<T>) {
        if let index = children.firstIndex(of: child) {
            children.remove(at: index)
        }
    }
    
    func depthFirstTraversal() {
        print("\(value)", terminator: " -> ")
        children.forEach({ $0.depthFirstTraversal() })
    }
    
    @discardableResult
    func depthFirstSearch(_ searchingItem: T) -> Bool {
        if searchingItem == value {
            return true
        }
        for item in children {
            let result = item.depthFirstSearch(searchingItem)
            if result == true {
                return true
            }
        }
        
        return false
    }
    
    func breathFirstTraversal(_ root: Bool? = true) {
        if root == true {
            print("\(value)", terminator: " -> ")
        }
        let queue = Queue<T>()
        children.forEach({
            queue.enqueue($0)
            print("\($0.value)", terminator: " -> ")
        })
        while !queue.isEmpty() {
            let item = queue.dequeue()
            item.breathFirstTraversal(false)
        }
    }
    
    func breathFirstSearch(_ searchingItem: T) -> Bool {
        if searchingItem == value {
            return true
        }
        let queue = Queue<T>()
        children.forEach({
            queue.enqueue($0)
        })
        while !queue.isEmpty() {
            let item = queue.dequeue()
            let itemFound = item.breathFirstSearch(searchingItem)
            if itemFound == true {
                return itemFound
            }
        }
        return false
    }
}

class Queue<T: Equatable> {
    var array : [TreeNode<T>] = []
    func enqueue(_ elemnent : TreeNode<T>) {
        array.append(elemnent)
    }
    
    func isEmpty() -> Bool {
        return array.count == 0
    }
    
    func dequeue() -> TreeNode<T> {
        return array.removeFirst()
    }
}

var beverage = TreeNode("Beverage", [], 0)

var hot = TreeNode("Hot", [], 1)
var cold = TreeNode("Cold", [], 2)

var hotCoffee = TreeNode("Hot Coffee", [], 3)
var tea = TreeNode("Tea", [], 4)
var blackTea = TreeNode("Black Tea", [], 5)
var whiteTea = TreeNode("White Tea", [], 6)

var coldCoffee = TreeNode("Cold Coffee", [], 7)
var juice = TreeNode("Juice", [], 8)
var cock = TreeNode("Cock", [], 9)
var soda = TreeNode("Soda", [], 10)
var milk = TreeNode("Milk", [], 11)

hot.children = [hotCoffee, tea]
tea.children = [blackTea, whiteTea]

cold.children = [coldCoffee, soda, milk, cock, juice]

beverage.children = [hot, cold]
print("depthFirstTraversal: ")
print("\(beverage.depthFirstTraversal())")


print("breathFirstTraversal: ")
print("\(beverage.breathFirstTraversal())")

print("\nbreathFirstSearch:\(beverage.breathFirstSearch("Tea"))")
print("\ndepthFirstSearch:\(beverage.depthFirstSearch("Tea"))")
