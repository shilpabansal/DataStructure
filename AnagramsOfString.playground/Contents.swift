import UIKit

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

//let str = "Hello, playground"
//print(str.substring(from: 7))         // playground
//print(str.substring(to: 5))           // Hello
//print(str.substring(with: 7..<11))


func checkAllAnagrams(_ inputString: String,
                      answer: String,
                      outputArray: inout [String])
{
    if inputString.isEmpty
    {
        if !outputArray.contains(answer) {
            outputArray.append(answer)
        }
        return;
    }

    inputString.enumerated().forEach { (index, character) in
        let leftString = inputString.substring(to: index)
        let rightString = inputString.substring(from: index + 1)
        
//        print("left: \(leftString) right: \(rightString) character: \(character)")
        let rest = leftString + rightString
        checkAllAnagrams(String(rest),
                         answer: answer + String(character),
                         outputArray: &outputArray)
    }
}

let answer = ""
var outputArray = [String]()
print(checkAllAnagrams("abcd",
                       answer: answer,
                       outputArray: &outputArray))
print(outputArray)

let test = "Shilpa"
print(test.dropFirst(3))
