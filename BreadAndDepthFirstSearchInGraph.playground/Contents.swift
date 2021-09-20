import UIKit

struct Queue<T: Hashable> {
    var queue = [T?]()
    
    var front = -1
    var rear = -1
    
    mutating func enqueue(element: T) {
        rear = rear + 1
        queue.append(element)
    }
    
    mutating func dequeue() -> T? {
        if front < queue.count - 1 && front != rear {
            front = front + 1
            let element = queue[front]
            queue[front] = nil
            return element
        }
        else {
            front = -1
            rear = -1
            return nil
        }
    }
    
    func contains(_ element: T) -> Bool {
        return queue.contains(element)
    }
}

struct Vertex<T: Hashable>:  Hashable {
    static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.element.hashValue == rhs.element.hashValue
    }
    
    let element: T
}

extension Vertex: CustomStringConvertible where T == String {
    var description: String {
        return "\(element)"
    }
}

struct Edge<T: Hashable> {
    let source: Vertex<T>
    let destination: Vertex<T>
    let weight: Double
}

enum EdgeType {
    case directed
    case indirected
}

protocol Graphable {
    associatedtype Element: Hashable
    func createVertex(with element: Element) -> Vertex<Element>
    
    func weight(from source: Vertex<Element>,to destination: Vertex<Element>) -> Double
    func addEdge(edgeType: EdgeType, source: Vertex<Element>, destination: Vertex<Element>, weight: Double)
    
    func edges(from source: Vertex<Element>) -> [Edge<Element>]?
}

class AdjacencyList<T: Hashable>: Graphable {
    public typealias Element = T
    var adjacencyDict: [Vertex<T>: [Edge<T>]] = [:]
    
    func createVertex(with element: T) -> Vertex<T> {
        let vertex = Vertex(element: element)
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
        return vertex
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>]? {
        return adjacencyDict[source]
    }
    
    func weight(from source: Vertex<T>,to destination: Vertex<T>) -> Double {
        return edges(from: source)?.first(where: { $0.destination == destination })?.weight ?? 0.0
    }
    
    func addEdge(edgeType: EdgeType, source: Vertex<T>, destination: Vertex<T>, weight: Double) {
        switch edgeType {
        case .directed:
            addDirectEdge(source: source, destination: destination, weight: weight)
        case .indirected:
            addIndirectEdge(vertex1: source, vertex2: destination, weight: weight)
        }
    }
    
    private func addIndirectEdge(vertex1: Vertex<T>, vertex2: Vertex<T>, weight: Double) {
        addDirectEdge(source: vertex1, destination: vertex2, weight: weight)
        
        addDirectEdge(source: vertex2, destination: vertex1, weight: weight)
    }
    
    private func addDirectEdge(source: Vertex<T>, destination: Vertex<T>, weight: Double) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencyDict[source]?.append(edge)
    }
}

extension AdjacencyList {
    func breathFirstSearh() -> (String, Double) {
        var cost = 0.0
        var result = ""
        var queue = Queue<Vertex<T>>()
        var visited = Set<Vertex<T>>()
        
        if let rootNode = adjacencyDict.keys.first {
            queue.enqueue(element: rootNode)
            result += "\(rootNode)"
        }
        
        while let element = queue.dequeue() {
            edges(from: element)?.forEach({ edge in
                if !queue.contains(edge.destination) &&
                    !visited.contains(edge.destination) {
                    
                    result += " -> \(edge.destination)"
                    cost += edge.weight
                    
                    queue.enqueue(element: edge.destination)
                }
                visited.insert(element)
            })
        }
        return (result, cost)
    }
    
    func depthFirstSearh(_ root: Vertex<T>? = nil) -> (result: String, cost: Double) {
        var cost = 0.0
        var result = ""
        var queue = Queue<Vertex<T>>()
        var visited = Set<Vertex<T>>()
        
        if let rootNode = adjacencyDict.keys.first {
            queue.enqueue(element: rootNode)
            result += "\(rootNode)"
            visited.insert(rootNode)
        }
        
        while let element = queue.dequeue() {
            depthFirstSearhHelper(element,
                            visited: &visited,
                            queue: &queue,
                            result: &result,
                            cost: &cost)
        }
        return (result, cost)
    }
    
    func depthFirstSearhHelper(_ root: Vertex<T>,
                         visited: inout Set<Vertex<T>>,
                         queue: inout Queue<Vertex<T>>,
                         result: inout String,
                         cost: inout Double) {
        edges(from: root)?.forEach({ edge in
            if !queue.contains(edge.destination) &&
                 !visited.contains(edge.destination) {
                 
                 visited.insert(edge.destination)
                 queue.enqueue(element: edge.destination)
                 
                 result += " -> \(edge.destination)"
                 cost += edge.weight
                
                depthFirstSearhHelper(edge.destination, visited: &visited, queue: &queue, result: &result, cost: &cost)
            }
        })
    }
}

let adjacencyList = AdjacencyList<String>()
let vertexA = adjacencyList.createVertex(with: "A")
let vertexB = adjacencyList.createVertex(with: "B")
let vertexC = adjacencyList.createVertex(with: "C")
let vertexD = adjacencyList.createVertex(with: "D")

adjacencyList.addEdge(edgeType: .indirected, source: vertexA, destination: vertexB, weight: 2.0)
adjacencyList.addEdge(edgeType: .indirected, source: vertexA, destination: vertexC, weight: 5.0)
adjacencyList.addEdge(edgeType: .indirected, source: vertexB, destination: vertexC, weight: 4.0)
adjacencyList.addEdge(edgeType: .indirected, source: vertexC, destination: vertexD, weight: 6.0)

let (result, cost) = adjacencyList.breathFirstSearh()
print("BreathFirstSearch: \(result) \ncost: \(cost)")

let dResult = adjacencyList.depthFirstSearh()
print("DepthFirstSearch: \(dResult.result) \ncost: \(dResult.cost)")
