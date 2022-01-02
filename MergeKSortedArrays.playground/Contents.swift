public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension ListNode {
    func insert(element: Int) {
        let newNode = ListNode(element)
        if next == nil {
            next = newNode
        }
        else {
            var currentNode = next
            while currentNode?.next != nil {
                currentNode = currentNode?.next
            }
            currentNode?.next = newNode
        }
    }
    
    var count: Int {
        var index = 1
        var currentNode = next
        repeat {
            currentNode = currentNode?.next
            index += 1
        } while currentNode?.next != nil
        return index
    }
}

extension ListNode: CustomStringConvertible {
    public var description: String {
        var str = ""
        var currentNode = next
        
        if let val = currentNode?.val {
            str += "\(val) -> "
        }
        repeat {
            currentNode = currentNode?.next
            if let val = currentNode?.val {
                str += "\(val) -> "
            }
        } while currentNode?.next != nil
        
        return str
    }
}

extension ListNode: Comparable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val
    }
    
    public static func < (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val < rhs.val
    }
}

class Heap<Element> where Element: Comparable {
    private var array = [Element]()
    
    func getHeap() -> [Element] {
        return array
    }
    
    func insert(item: Element) {
        array.append(item)
        
        tickleUp(lastIndex)
    }
    
    func remove(index: Int) -> Element? {
        let deletingElement = array[index]
        swap(index, lastIndex)
        
        array.removeLast()
        tickleDown(index)
        return deletingElement
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    private var lastIndex: Int {
        return array.count - 1
    }
    
    private func tickleUp(_ index: Int) {
        var currentIndex = index
        while let parentIndex = parentIndex(for: currentIndex), array[currentIndex] < array[parentIndex] {
            swap(currentIndex, parentIndex)
            currentIndex = parentIndex
        }
    }
    
    private func tickleDown(_ index: Int) {
        var currentIndex = index
        while true {
            if let firstChildIndex = childrenIndex(for: currentIndex).0,
               array[currentIndex] > array[firstChildIndex]  {
                swap(currentIndex, firstChildIndex)
                currentIndex = firstChildIndex
            }
            else if let secondChildIndex = childrenIndex(for: currentIndex).1,
                    array[currentIndex] > array[secondChildIndex]  {
                swap(currentIndex, secondChildIndex)
                currentIndex = secondChildIndex
            }
            else {
                break
            }
        }
    }
    
    private func swap(_ firstIndex: Int,_ secondIndex: Int) {
        let temp = array[firstIndex]
        array[firstIndex] = array[secondIndex]
        array[secondIndex] = temp
    }
    
    private func parentIndex(for index: Int) -> Int? {
        let parentIndex = Int((index - 1) / 2)
        return parentIndex >= 0 ? parentIndex : nil
    }
    
    private func childrenIndex(for index: Int) -> (firstChild: Int?,secondChild: Int?) {
        var firstChildIndex: Int? = nil
        var secondChildIndex: Int? = nil
        if (2 * index + 1) < array.count {
            firstChildIndex = 2 * index + 1
        }
        if (2 * index + 2) < array.count {
            secondChildIndex = 2 * index + 2
        }
        return (firstChildIndex, secondChildIndex)
    }
}

class Solution {
    func mergeKLists(_ lists: [[Int]]) -> ListNode? {
        let nodes: [ListNode?] = lists.map { list in
            let list1 = ListNode()
            list.map { val in
                list1.insert(element: val)
            }
            return list1
        }
        return mergeKLists(nodes)
    }
    
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        if lists.count == 0 { return nil }
        
        let resultList = ListNode()
        let heap = Heap<ListNode>()
        
        var totalElements = 0
        for list in lists {
            totalElements += list?.count ?? 0
            if let node = list?.next {
                heap.insert(item: node)
            }
        }
        
        while resultList.count < totalElements {
            if let minElement = heap.remove(index: 0) {
                resultList.insert(element: minElement.val)
                
                if let newElement = minElement.next {
                    heap.insert(item: newElement)
                }
            }
        }
        return resultList
    }
}

let solution = Solution()
let list1 = ListNode()
list1.insert(element: 1)
list1.insert(element: 4)
list1.insert(element: 5)

let list2 = ListNode()
list2.insert(element: 1)
list2.insert(element: 3)
list2.insert(element: 4)


let list3 = ListNode()
list3.insert(element: 2)
list3.insert(element: 6)
if let result = solution.mergeKLists([[1,4,5],[1,3,4],[2,6]]) {
    print(result)
}
