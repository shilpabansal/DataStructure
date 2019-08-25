import UIKit

class Queue {
    var array : [Int] = []
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    func peek() -> Int? {
        return isEmpty() ? nil : array.first
    }
    
    func enque(_ value: Int) {
        array.append(value)
    }
    
    func dequeue() -> Int? {
        return isEmpty() ? nil : array.removeFirst()
    }
}

extension Queue : CustomStringConvertible
{
    var description: String {
        return String(describing: array)
    }
}
let queue = Queue()
queue.enque(5)
queue.enque(6)
queue.enque(7)
print(queue)

queue.dequeue()
queue.dequeue()
print(queue)
queue.enque(8)
print(queue)
queue.dequeue()
queue.dequeue()
print(queue)
