import UIKit

public struct Vertex<T: Hashable> : Hashable {
    var data : T
    
    init(_ data: T) {
        self.data = data
    }
    
    static public func ==(_ lhs: Vertex<T>, _ rhs: Vertex<T>) -> Bool {
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

public struct Edge<T: Hashable> : Hashable {
    var source : Vertex<T>
    var destination: Vertex<T>
    let weight: Double
    
    init(source: Vertex<T>, destination: Vertex<T>, weight: Double) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }
    
    static public func ==(_ lhs: Edge<T>, _ rhs: Edge<T>) -> Bool {
        return (lhs.weight == rhs.weight && lhs.source == rhs.source && lhs.destination == rhs.destination)
    }
    
    var description : CustomStringConvertible {
        return String(describing: destination)
    }
}

public class Graph<T> where T: Hashable {
    public var adjacencyDict : [Vertex<T>: [Edge<T>]] = [:]
    
    func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(data)
        
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
        
        return vertex
    }
    
    fileprivate func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencyDict[source]?.append(edge) // 2
    }
    
    fileprivate func addUndirectedEdge(node1: Vertex<T>, node2: Vertex<T>, weight: Double) {
        addDirectedEdge(from: node1, to: node2, weight: weight)
        addDirectedEdge(from: node2, to: node1, weight: weight)
    }
    
    fileprivate func getWeight(from source: Vertex<T>, to destination: Vertex<T>) -> Double {
        if let edgeArray = adjacencyDict[source] {
            for edge in edgeArray {
                if edge.destination == destination {
                    return edge.weight
                }
            }
        }
        return 0.0
    }
    
    fileprivate func edges(for vertex: Vertex<T>) -> [Edge<T>]? {
        return adjacencyDict[vertex]
    }
    
    public func add(_ type: EdgeType, from source: Vertex<T>, to destination: Vertex<T>, weight: Double) {
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
}

var graph = Graph<String>()

let singapore = graph.createVertex(data: "Singapore")
let tokyo = graph.createVertex(data: "Tokyo")
let hongKong = graph.createVertex(data: "Hong Kong")
let detroit = graph.createVertex(data: "Detroit")
let sanFrancisco = graph.createVertex(data: "San Francisco")
let washingtonDC = graph.createVertex(data: "Washington DC")
let austinTexas = graph.createVertex(data: "Austin Texas")
let seattle = graph.createVertex(data: "Seattle")

graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
graph.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
graph.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
graph.add(.undirected, from: detroit, to: austinTexas, weight: 50)
graph.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
graph.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
graph.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
graph.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
graph.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)

print(graph.description)
