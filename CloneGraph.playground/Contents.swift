public class Node {
    public var val: Int
    public var neighbors: [Node?]
    public init(_ val: Int) {
        self.val = val
        self.neighbors = []
    }
}
extension Node: CustomStringConvertible {
    public var description: String {
        return "\(val) [\(neighbors)]"
    }
}

class Solution {
    var visitedNode: [Int: Node] = [:]
    
    func cloneGraph(_ node: Node?) -> Node? {
        guard let val = node?.val else { return nil }
        if let cloneNode = visitedNode[val] { return cloneNode }
        
        let root = Node(val)
        visitedNode[val] = root
        for neighbor in node?.neighbors ?? [] {
            if let cloneNeighbor = cloneGraph(neighbor) {
                root.neighbors.append(cloneGraph(neighbor))
            }
        }
        return root
    }
}

let solution = Solution()
//let node = Node(5)
//solution.cloneGraph(node)

let listArray = [[2,4],[1,3],[2,4],[1,3]]
var resultNodes = [Node]()
for index in 0..<listArray.count {
    resultNodes.append(Node(index+1))
}
for node in resultNodes {
    print(node)
}

solution.updateNeighbours(currentIndex: 0, listArray, resultNodes: resultNodes)

print("After----")
for node in resultNodes {
    print(node)
}
