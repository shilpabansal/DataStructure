import UIKit

public struct Vertex : Hashable{
    var data : String
    init(_ data: String) {
        self.data = data
    }
    
    static public func ==(_ lhs: Vertex, _ rhs: Vertex) -> Bool {
        return lhs.data == rhs.data
    }
}

extension Vertex : CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}

public enum EdgeType {
    case directed, undirected
}

public struct Edge : Hashable {
    var source : Vertex
    var destination: Vertex
    let weight: Double
    
    init(source: Vertex, destination: Vertex, weight: Double) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }
    
    static public func ==(_ lhs: Edge, _ rhs: Edge) -> Bool {
        return (lhs.weight == rhs.weight && lhs.source == rhs.source && lhs.destination == rhs.destination)
    }
    
    var description : CustomStringConvertible {
        return String(describing: destination)
    }
}

public class Graph {
    public var adjacencyDict : [Vertex: [Edge]] = [:]
    func createVertex(data: String) -> Vertex {
        let vertex = Vertex(data)
        
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
        
        return vertex
    }
    
    fileprivate func addDirectedEdge(from source: Vertex, to destination: Vertex, weight: Double) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencyDict[source]?.append(edge) // 2
    }
    
    fileprivate func addUndirectedEdge(node1: Vertex, node2: Vertex, weight: Double) {
        addDirectedEdge(from: node1, to: node2, weight: weight)
        addDirectedEdge(from: node2, to: node1, weight: weight)
    }
    
    fileprivate func getWeight(from source: Vertex, to destination: Vertex) -> Double {
        if let edgeArray = adjacencyDict[source] {
            for edge in edgeArray {
                if edge.destination == destination {
                    return edge.weight
                }
            }
        }
        return 0.0
    }
    
    fileprivate func edges(for vertex: Vertex) -> [Edge]? {
        return adjacencyDict[vertex]
    }
    
    public func add(_ type: EdgeType, from source: Vertex, to destination: Vertex, weight: Double) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(node1: source, node2: destination, weight: weight)
        }
    }
    
    public var description: CustomStringConvertible {
        var result = ""
        for (vertex, edges) in adjacencyDict {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ] \n ")
        }
        return result
    }
    
    
    
    //stack implementation
    func DFS() -> String {
        var stack : [Vertex] = []
        var visitedStack : [Vertex] = []
        var edgeSting = ""
        for (vertex, edges) in adjacencyDict {
            visitDFSChildren(vertex: vertex, edgeSting: &edgeSting, edges: edges, stack: &stack, visitedStack: &visitedStack)
        }
        return edgeSting
    }
    
    func visitDFSChildren( vertex: Vertex, edgeSting: inout String, edges: [Edge]?, stack: inout [Vertex], visitedStack: inout [Vertex]) {
        if !visitedStack.contains(vertex) {
            stack.append(vertex)
            visitedStack.append(vertex)
            edgeSting += " \(vertex) "
            
            if let edges = edges {
                for edge in edges {
                    visitDFSChildren(vertex: edge.destination, edgeSting: &edgeSting, edges: adjacencyDict[edge.destination], stack: &stack, visitedStack: &visitedStack)
                }
            }
        }
    }
    
    
    
    //queue implementation
    func BFS() -> String {
        var queue : [Vertex] = []
        var visitedList : [Vertex] = []
        var edgeSting = ""
        for (vertex, edges) in adjacencyDict {
            visitBFSChildren(vertex: vertex, edgeSting: &edgeSting, edges: edges, queue: &queue, visitedList: &visitedList)
        }
        return edgeSting
    }
    
    func visitBFSChildren( vertex: Vertex, edgeSting: inout String, edges: [Edge]?, queue: inout [Vertex], visitedList: inout [Vertex]) {
       
        if !visitedList.contains(vertex) {
            queue.append(vertex)
            visitedList.append(vertex)
            edgeSting += " \(vertex) "
        }
            if let edges = adjacencyDict[vertex] {
                for edge in edges {
                    
                    if !visitedList.contains(edge.destination) {
                        queue.append(edge.destination)
                        visitedList.append(edge.destination)
                        edgeSting += " \(edge.destination) "
                    }
                }
                
            }
            
        if queue.count > 0 {
            let nextVertex = queue.removeFirst()
            visitBFSChildren(vertex: nextVertex, edgeSting: &edgeSting, edges: edges, queue: &queue, visitedList: &visitedList)
        }
    }
}

var graph = Graph()

let detroit = graph.createVertex(data: "Detroit")
let sanFrancisco = graph.createVertex(data: "San Francisco")
let tokyo = graph.createVertex(data: "Tokyo")
let hongKong = graph.createVertex(data: "Hong Kong")
let singapore = graph.createVertex(data: "Singapore")
let washingtonDC = graph.createVertex(data: "Washington DC")
let austinTexas = graph.createVertex(data: "Austin Texas")
let seattle = graph.createVertex(data: "Seattle")

graph.add(.directed, from: sanFrancisco, to: washingtonDC, weight: 337)
graph.add(.directed, from: sanFrancisco, to: seattle, weight: 218)
graph.add(.directed, from: singapore, to: hongKong, weight: 300)
graph.add(.directed, from: singapore, to: tokyo, weight: 500)
graph.add(.directed, from: hongKong, to: tokyo, weight: 250)
graph.add(.directed, from: tokyo, to: detroit, weight: 450)
graph.add(.directed, from: tokyo, to: washingtonDC, weight: 300)
graph.add(.directed, from: hongKong, to: sanFrancisco, weight: 600)
graph.add(.directed, from: detroit, to: austinTexas, weight: 50)
graph.add(.directed, from: austinTexas, to: washingtonDC, weight: 292)
graph.add(.directed, from: washingtonDC, to: seattle, weight: 277)
graph.add(.directed, from: austinTexas, to: sanFrancisco, weight: 297)
graph.add(.directed, from: austinTexas, to: singapore, weight: 300)

print(graph.description)

print("DFS: \(graph.DFS())")

print("BFS: \(graph.BFS())")
