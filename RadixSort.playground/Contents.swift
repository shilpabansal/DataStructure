import UIKit

extension Array where Element == Int {
    func radixSort() -> [Int] {
        var baseArray = [BaseObject]()
        self.forEach { element in
            baseArray.append(BaseObject(value: element, nextValue: element))
        }
        
        while true {
            if baseArray.allSatisfy({ $0.nextValue == 0 }) {
                break
            }
            
            baseArray.sort { obj1, obj2 in
                return obj1.reminderValue < obj2.reminderValue
            }
            
            for (index, element) in baseArray.enumerated() {
                var newElement = element
                newElement.nextValue = element.nextValue / 10
                baseArray[index] = newElement
            }
        }
        
        return baseArray.map( { $0.value} )
    }
}

struct BaseObject: CustomStringConvertible {
    let value: Int
    var nextValue: Int
    
    init(value: Int,
         nextValue: Int) {
        self.value = value
        self.nextValue = nextValue
    }
    
    var reminderValue: Int {
        return nextValue % 10
    }
    
    var description: String {
        return "\(value)"
    }
}

let array = [170, 45, 75, 90, 802, 24, 2, 66]
print("UnSorted Array: \(array)")
print("Sorted Array: \(array.radixSort())")
