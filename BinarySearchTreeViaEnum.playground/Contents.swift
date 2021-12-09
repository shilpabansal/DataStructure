import UIKit

enum BinaryTree<T> where T: Comparable {
    case empty
    indirect case node(BinaryTree, T, BinaryTree)
    
    func numberOfNodes() -> Int {
        switch self {
        case .empty:
            return 0
        case let .node(left, _, right):
            return left.numberOfNodes() + 1 + right.numberOfNodes()
        }
    }
    
    mutating func insert(_ element: T) {
        self = inserting(element)
    }
        
    private func inserting(_ element: T) -> BinaryTree {
        switch self {
        case .empty:
            // the tree is empty, so inserting an element results in a tree containing only that element
            return .node(.empty, element, .empty)
            
        case .node(_, element, _):
            // the element is already present in the tree
            return self
            
        case let .node(left, value, right) where element < value:
            // the element should be inserted into the left subtree
            return .node(left.inserting(element), value, right)
            
        case let .node(left, value, right):
            // the element should be inserted into the right subtree
            return .node(left, value, right.inserting(element))
        }
    }
    
    func nodeHeight() -> Int {
        switch self {
        case .empty:
            return 0
        case let .node(left, _, right):
            let depth = (left.nodeHeight() > right.nodeHeight() ? left.nodeHeight() : right.nodeHeight())
            if case .empty = left, case .empty = right {
                return 0
            }
            return depth + 1
        }
    }
}

extension BinaryTree: CustomStringConvertible {
    var description: String {
        var result = ""
        switch self {
        case let .node(left, value, right):
            result += "value:\(value) left:[\(left.description)] right:[\(right.description)]"
        case .empty:
            result = ""
        }
        return result
    }
}

let nodeMinus1 = BinaryTree.node(.empty, -1, .empty)
let node1 = BinaryTree.node(nodeMinus1, 1, .empty)
let node4 = BinaryTree.node(.empty, 4, .empty)
let node3 = BinaryTree.node(.empty, 3, node4)

var root = BinaryTree.node(node1, 2, node3)

root.insert(5)
root.insert(6)
root.insert(6)
print(root)

print("numberOfNodes: \(root.numberOfNodes())")
print("root's nodeHeight: \(root.nodeHeight())")

