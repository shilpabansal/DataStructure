import UIKit

class StringHandling {

    func reverse() {
        let string = "shilpa"
        var result = ""
        for character in string {
            result = "\(character)" + result
        }
        print(result)
    }
    
    func testStringFunctions() {
        var string = "aasas"
        
        //string to array
        let splitArray = string.split(separator: "h")
        print("Split array \(splitArray)")
        
        if splitArray.count > 0 {
            //Array to string
            print("Remove Joined string " + splitArray.joined(separator: ""))
        }
       
        if let lastCharacter = string.popLast() {
            print("Pop Last \(lastCharacter)")
        }
        //Last character
        if string.count > 0 {
            print("Remove Last \(string.removeLast())")
        }
        
        if string.count >= 2 {
            string.removeLast(2)
            print("String after Removing Last two \(string)")
        }
        
        string = "aasas"
        string.removeAll{ $0 == "a" }
        print(string)
        print("string after removing vowels 'a' " + string)
        
        string = "aasasertdvvuojkhi"
        let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
        string.removeAll{ vowels.contains($0) }
        print("string after removing vowels " + string)
        
        string.forEach({print($0, terminator: " ")})
        print("\n")
        string.forEach { character in
            print(character, terminator: " ")
        }
        print("\n")
        
        
        let numbers = [3, 7, 4, -2, 9, -6, 10, 1]
        if let firstNegative = numbers.first(where: { $0 < 0 }) {
            print("The first negative number is \(firstNegative).")
        }
    }
    
    func testArrayFunctions() {
        var array = [34, 44, 66, 76, 99]
        
        print(array.sort(by: {$0 > $1}))//return nothing
        print(array)//original array is sorted
        
        array = [34, 44, 66, 76, 99]
        print(array.sorted(by: {$0 > $1}))//returns sorted array
        print(array)//array is not sorted
        
        
        let cast = ["Vivien", "Marlon", "Kim", "Karl"]
        let lowercaseNames = cast.map { $0.lowercased() }//map to other array
        print(lowercaseNames)
        print(cast)//original array is not changed
        
        print("\n Set items are: ", terminator: " ")
        let nameSet: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
        for (i, item) in nameSet.enumerated() {
            print("\(i): \(item)", terminator: " ")
        }
        
        let nameArray: Array = ["Sofia", "Camilla", "Martina", "Mateo", "Niacolás"]
        print("\n Array items are: ", terminator: " ")
        for (i, item) in nameArray.enumerated() {
            print("\(i): \(item)", terminator: " ")
        }
        
        let dic : [Int: Int] = [34 : 1, 22: 2]
        print("\n Dictionary items are: ", terminator: " ")
        for (key, value) in dic {
            print("\(key) : \(value)", terminator: " ")
        }
        
        print("\n Contains result : \(nameArray.contains{ $0 == "Sofia"})") //if atleast one elements is Sofia
        
        print("\n allSatisfy result : \(nameArray.allSatisfy{ $0.contains("a")})") //if all the elements satisfy the condition
        
        //Keep adding numbers with given initial value which is 10 in this case
        let addNumbers = [1, 2, 3, 4]
        let reduceResult = addNumbers.reduce(10, { (x, y) in
            return x + y
        })
        print("\n Result of reduce function is: \(reduceResult)", terminator: " ")
        
        
        //Return the values with difference by 2
        print("\n Result of stride function is:")
        for i in stride(from: 0, to: 7, by: 2) {
            print("\(i)", terminator: " ")
        }
        
        let testUnsafeBufferNumbers = [1, 2, 3, 4, 5]
        testUnsafeBufferNumbers.withUnsafeBufferPointer { buffer -> Int in
            print("\n buffer.startIndex: \(buffer.startIndex) buffer.endIndex: \(buffer.endIndex)")
            return 0
        }
        
        var testMutableBufferNumbers = [1, 2, 3, 4, 5]
        testMutableBufferNumbers.withUnsafeMutableBufferPointer { buffer in
            for i in stride(from: buffer.startIndex, to: buffer.endIndex - 1, by: 1) {
                buffer.swapAt(i, i + 1)
                print(buffer[i], buffer[i+1])
            }
        }
    }
}

var obj = StringHandling()
obj.reverse()
obj.testStringFunctions()
obj.testArrayFunctions()
