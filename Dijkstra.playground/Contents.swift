import UIKit

/**
 from unvisited to visited array
 if d[u] +c(u,v) < d[v] {
    d[v] = d[u] + c(u,v)
 }
 */

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

class Graph : CustomStringConvertible {
    var vertices : [Vertex] = []
    var edges: [Edge] = []
    var visitedVertices: [Vertex] = []
    var unvisitedVertices: [Vertex] = []
    
    init(_ vertices: [Vertex],_ edges: [Edge]) {
        self.vertices = vertices
        self.edges = edges
    }
    
    var description: String {
        return("\(self.edges)")
    }
    
    func dijkstraAlgo() -> ([Edge], Int) {
        //var visitDictionary : [Vertex: ]
        var spanningTreeEdges : [Edge] = []
        var cost = 0
        for vertex in vertices {
            unvisitedVertices.append(vertex)
        }
        
        visitedVertices.append(unvisitedVertices[0])
        unvisitedVertices.remove(at: 0)
        
        
        while unvisitedVertices.count > 0 {
            
            var connectedEdges :[Edge] = []
            for visitedVertex in visitedVertices {
                let nodeA = visitedVertex
                connectedEdges.append(contentsOf:(edges.filter({return $0.source == nodeA && !visitedVertices.contains($0.destination)})))
            }
            var minimumWeight = 100000
            var minimalEdge :Edge?
            for edge in connectedEdges {
                if edge.weight < minimumWeight {
                    minimumWeight = edge.weight
                    minimalEdge = edge
                }
            }
            if let minimalEdge = minimalEdge {
                spanningTreeEdges.append(minimalEdge)
                cost += minimalEdge.weight
                visitedVertices.append(minimalEdge.destination)
                if let visitVertexIndex = unvisitedVertices.firstIndex(where: {$0 == minimalEdge.destination}) {
                    unvisitedVertices.remove(at: visitVertexIndex)
                }
            }
        }
        return(spanningTreeEdges, cost)
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
print("Dijkstra Result: \(graph.dijkstraAlgo())")


var K = Vertex("K")
var L = Vertex("L")
var M = Vertex("M")
var N = Vertex("N")
var O = Vertex("O")
var edgeKL = Edge(K, L, 1)
var edgeKM = Edge(K, M, 4)
var edgeLM = Edge(L, M, 3)
var edgeLN = Edge(L, N, 2)
var edgeLO = Edge(L, O, 2)
var edgeNL = Edge(N, L, 1)
var edgeNM = Edge(N, M, 5)
var edgeON = Edge(O, N, 3)
var graph2 = Graph([K, L, M, N, O], [edgeKL, edgeKM, edgeLM, edgeLN, edgeLO, edgeNL, edgeNM, edgeON])
print("\n\nGraph2:\(graph3)")
print("Dijkstra result:\(graph2.dijkstraAlgo())")
