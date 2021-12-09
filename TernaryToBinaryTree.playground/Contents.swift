class Stack<Element> {
    var array = [Element]()
    
    subscript(index: Int) -> Element {
        get {
            return array[index]
        }
        set(newValue) {
            array[index] = newValue
        }
    }
    
    func pop() -> Element? {
        return array.removeLast()
    }
    
    func peek() -> Element? {
        return array.last
    }
    
    func push(_ element: Element) {
        array.append(element)
    }
}

extension Stack: CustomStringConvertible where Element: TreeNode {
    var description: String {
        var result = ""
        self.array.forEach { element in
            result += "\(element.description)\n"
        }
        return result
    }
}


extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func subString(to: Int) -> String {
        let toIndex = self.index(from: to)
        return String(self[...toIndex])
    }
    
    func subString(from: Int) -> String {
        let fromIndex = self.index(from: from)
        return String(self[fromIndex...])
    }
    
    func subString(from: Int, to: Int) -> String {
        let fromIndex = self.index(from: from)
        let toIndex = self.index(from: to)
        return String(self[fromIndex...toIndex])
    }
    
    func charAt(index: Int) -> Character {
        let stringArray = Array(self)
        return stringArray[index]
    }
}

class TreeNode: CustomStringConvertible {
    let element: Character
    var left: TreeNode?
    var right: TreeNode?

    init(_ element: Character) {
        self.element = element;
        left = nil
        right = nil
    }
    
    var description: String {
        return "value:\(element) left:[\(left?.description ?? "")] right:[\(right?.description ?? "")]"
    }
}

func tenaryToTree(expression: String) -> TreeNode? {
    if (expression.count == 0) {
        return nil
    }
      
    let char = expression.charAt(index: 0)
    let root = TreeNode(char)
    
    let stack = Stack<TreeNode>()
    stack.push(root);
    
    var i = 1
    while i < expression.count {
        let node = TreeNode(expression.charAt(index: i + 1));
        
        if expression.charAt(index: i) == "?" {
            stack.peek()?.left = node
        }
        
        if expression.charAt(index: i) == ":" {
            stack.pop()
            while (stack.peek()?.right != nil) {
              stack.pop();
            }
            stack.peek()?.right = node;
        }
        stack.push(node);
        i += 2
    }
    return root
}

//let expression = "a?b?c:d:e"
let expression = "a?b?c:d?e?f:g:i:j"
print("expression: \(expression)")
let tree = tenaryToTree(expression: expression)
if let tree = tree {
    print("ternaryRoot: \(tree)")
}
