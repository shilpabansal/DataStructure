import UIKit

struct Vertex : Hashable, CustomStringConvertible {
    var data: String
    
    init(_ data: String) {
        self.data = data
    }
    
    static func ==(_ lhs: Vertex, _ rhs: Vertex) -> Bool {
        return lhs.data == rhs.data
    }
    
    var description: String {
        return("\(data)")
    }
}

struct Edge: Hashable, CustomStringConvertible {
    var weight: Int
    var source: Vertex
    var destination: Vertex
    
    
    init(_ source: Vertex,_ destination: Vertex,_ weight: Int) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }
    
    static func ==(_ lhs: Edge, _ rhs: Edge) -> Bool {
        return (lhs.source == rhs.source && lhs.destination == rhs.destination && lhs.weight == rhs.weight)
    }
    
    var description: String {
        return("\(self.source) -> \(self.destination) (\(self.weight))")
    }
}

/**
 Kruskal algo, sort all thee edges in sorted order, picks up from minimum and keep adding it in spanning Tree if cycle is not formed
 
 To check the cycle:
    Initially all parents will be pointing to self and rank will be zero
    findParent: finds the super parent of the vertex
    Union: If super parents are not same, the edge is added to spanning tree and parent and rank are updated
*/

struct Graph : CustomStringConvertible {
    var vertices : [Vertex] = []
    var edges: [Edge] = []
    var parent: [Vertex: Vertex] = [:]
    var Rank: [Vertex: Int] = [:]
    var dist: [Vertex: Int] = [:]
    
    init(_ vertices: [Vertex],_ edges: [Edge]) {
        self.vertices = vertices
        self.edges = edges
    }
    
    /**
     Finds root vertex of any vertex by using recurssion
     */
    func find(_ vertex: Vertex) -> Vertex {
        if let parent = parent[vertex], parent == vertex {
            return parent
        }
        else if let parent = parent[vertex] {
            return find(parent)
        }
        return vertex
    }
    
    /**
     Based on the rank decides who is the parent.
        If rank is bigger, its parent
        If ranks are same, consider one vertex as parent and increase the Rank for it.
     */
    mutating func Union(root1: Vertex, root2: Vertex) {
        if let rank1 = Rank[root1], let rank2 = Rank[root2] {
            if rank1 < rank2 {
                parent[root1] = root2
            }
            else if rank1 > rank2 {
                parent[root2] = root1
            }
            else {
                parent[root2] = root1
                Rank[root1]! += 1
            }
        }
    }
    
    mutating func kruskalAlgo() -> ([Edge], Int) {
        for vertex in vertices {
            parent[vertex] = vertex
            Rank[vertex] = 0
        }
        
        let edgesSorted = edges.sorted(by: {$0.weight < $1.weight})
        var spanningTreeEdges: [Edge] = []
        var cost = 0
        for edge in edgesSorted {
            let root1 = find(edge.source)
            let root2 = find(edge.destination)
            if root1 != root2 {
                spanningTreeEdges.append(edge)
                cost += edge.weight
                Union(root1: root1, root2: root2)
            }
        }
        print("parent:\(parent) \nRanks:\(Rank)")
        return (spanningTreeEdges,cost)
    }
    
    var description: String {
        return("\(self.edges)")
    }
    
    
    mutating func bellmanFordAlgo() -> Bool {
        for vertex in vertices {
            dist[vertex] = 100
        }
        dist[vertices[0]] = 0
        
        for var i in 1...vertices.count - 1 {
            for edge in edges {
                if let source = dist[edge.source], let destination = dist[edge.destination], source + edge.weight < destination {
                    dist[edge.destination] = source + edge.weight
                }
            }
        }
        for edge in edges {
            if let source = dist[edge.source], let destination = dist[edge.destination], source + edge.weight < destination {
                return true
            }
        }
        return false
    }
}

var A = Vertex("A")
var B = Vertex("B")
var C = Vertex("C")
var D = Vertex("D")
var E = Vertex("E")
var F = Vertex("F")

var edgeAB = Edge(A, B, 5)
var edgeAF = Edge(A, F, 7)
var edgeAC = Edge(A, C, 3)
var edgeCF = Edge(C, F, 8)
var edgeCB = Edge(C, B, 6)
var edgeCD = Edge(C, D, 3)
var edgeBD = Edge(B, D, 2)
var edgeBE = Edge(B, E, 4)
var edgeDE = Edge(D, E, 2)

var graph = Graph([A, B, C, D, E, F], [edgeAB, edgeAF, edgeAC, edgeCF, edgeCB, edgeCD, edgeBD, edgeBE, edgeDE])
print("Graph1: \(graph)")
print("kruskalAlgo Result: \(graph.kruskalAlgo())")



var G = Vertex("G")
var H = Vertex("H")
var I = Vertex("I")
var J = Vertex("J")
var edgeGH = Edge(G, H, 1)
var edgeHI = Edge(H, I, -1)
var edgeIJ = Edge(I, J, -1)
var edgeJG = Edge(J, G, -1)
var graph2 = Graph([G, H, I, J], [edgeGH, edgeHI, edgeIJ, edgeJG])
print("\n\nGraph2:\(graph2)")
print("Bellman result:\(graph2.bellmanFordAlgo())")


var K = Vertex("K")
var L = Vertex("L")
var M = Vertex("M")
var N = Vertex("N")
var O = Vertex("O")
var edgeKL = Edge(K, L, -1)
var edgeKM = Edge(K, M, 4)
var edgeLM = Edge(L, M, 3)
var edgeLN = Edge(L, N, 2)
var edgeLO = Edge(L, O, 2)
var edgeNL = Edge(N, L, 1)
var edgeNM = Edge(N, M, 5)
var edgeON = Edge(O, N, -3)
var graph3 = Graph([K, L, M, N, O], [edgeKL, edgeKM, edgeLM, edgeLN, edgeLO, edgeNL, edgeNM, edgeON])
print("\n\nGraph3:\(graph3)")
print("Bellman result:\(graph3.bellmanFordAlgo())")
