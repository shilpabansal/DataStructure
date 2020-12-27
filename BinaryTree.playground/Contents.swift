public indirect enum BinaryTree<T> {
  case node(BinaryTree<T>, T, BinaryTree<T>)
  case empty

  public var count: Int {
    switch self {
    case let .node(left, _, right):
      return left.count + 1 + right.count
    case .empty:
      return 0
    }
  }
}

extension BinaryTree: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .node(_, value, _):
      return "\(value)"
    case .empty:
      return ""
    }
  }
}

extension BinaryTree {
   public func traverseInOrder() -> String {
       switch(self) {
       case .empty:
           return ""
       case let .node(left, value, right):
           return left.traverseInOrder() + "\(value)" + right.traverseInOrder()
       }
    }
    
 public func traversePreOrder() -> String {
    switch(self) {
    case .empty:
        return ""
    case let .node(left, value, right):
        return "\(value)" + left.traversePreOrder() + right.traversePreOrder()
    }
 }
    
  public func traversePostOrder() -> String {
     switch(self) {
     case .empty:
         return ""
     case let .node(left, value, right):
         return  left.traversePostOrder() + right.traversePostOrder() + "\(value)"
     }
  }
}

extension BinaryTree {
  func invert() -> BinaryTree {
    if case let .node(left, value, right) = self {
      return .node(right.invert(), value, left.invert())
    } else {
      return .empty
    }
  }
}


// leaf nodes
let node5 = BinaryTree.node(.empty, "5", .empty)
let nodeA = BinaryTree.node(.empty, "a", .empty)
let node10 = BinaryTree.node(.empty, "10", .empty)
let node4 = BinaryTree.node(.empty, "4", .empty)
let node3 = BinaryTree.node(.empty, "3", .empty)
let nodeB = BinaryTree.node(.empty, "b", .empty)

// intermediate nodes on the left
let Aminus10 = BinaryTree.node(nodeA, "-", node10)
let timesLeft = BinaryTree.node(node5, "*", Aminus10)

// intermediate nodes on the right
let minus4 = BinaryTree.node(.empty, "-", node4)
let divide3andB = BinaryTree.node(node3, "/", nodeB)
let timesRight = BinaryTree.node(minus4, "*", divide3andB)

// root node
let tree = BinaryTree.node(timesLeft, "+", timesRight)

print(tree.traverseInOrder())
print(tree.traversePreOrder())
print(tree.traversePostOrder())
print(tree.count)
