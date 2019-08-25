import UIKit

//considering Max heap
class Heap<T> where T : Comparable {
    var array : [T] = []
    
    func insert(_ element : T) {
        if array.contains(element) {
            return
        }
        array.append(element)
        
        //Check if parent is smaller than added node, heapify with tickle up
        var currentIndex = array.count - 1
        while currentIndex != 0 {
            let parentIndex = (currentIndex - 1 ) / 2
            if array[currentIndex] > array[parentIndex] {
                let temp = array[currentIndex]
                array[currentIndex] = array[parentIndex]
                array[parentIndex] = temp
            }
            else {
                break
            }
            currentIndex = parentIndex
            
        }
    }
    
    func deletion(at index : Int) {
        var currentIndex = index
        let lastIndex = array.count - 1
        array[currentIndex] = array[lastIndex]
        array.removeLast()
        
        //tickle down, from index to adjust heap again
        var firstChild = 2 * currentIndex + 1
        var secondChild = 2 * currentIndex + 2
        
        while (array.count > firstChild && array[currentIndex] < array[firstChild]) || (array.count > secondChild && array[currentIndex] < array[secondChild]) {
            let childIndex = array[currentIndex] < array[firstChild] ? firstChild : secondChild
            let temp = array[currentIndex]
            array[currentIndex] = array[childIndex]
            array[childIndex] = temp
            
            currentIndex = childIndex
            firstChild = 2 * currentIndex + 1
            secondChild = 2 * currentIndex + 2
        }
    }
    
    func printHeap() {
        print(String(describing: array))
    }
}

let heapObject = Heap<Int>()
heapObject.insert(100)
heapObject.insert(110)
heapObject.insert(22)
heapObject.insert(150)
heapObject.insert(100)
heapObject.insert(20)
heapObject.insert(200)
heapObject.insert(220)
heapObject.insert(300)
heapObject.insert(130)
heapObject.printHeap()

heapObject.deletion(at: 0)
heapObject.printHeap()

heapObject.deletion(at: 1)
heapObject.printHeap()
