/*
 Program to generate all possible valid IP addresses from given string
 Input: 2540678135
 Output: [“255.255.11.135”, “255.255.111.35”]
 */

extension String {
    func index(from: Int) -> Index {
       return index(startIndex, offsetBy: from)
    }
    
    func subString(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func subString(to: Int) -> String {
        let toIndex = index(startIndex, offsetBy: to)
        return String(self[...toIndex])
    }
    
    func subString(from: Int, to: Int) -> String {
        let fromIndex = index(from: from)
        let toIndex = index(startIndex, offsetBy: to)
        return String(self[fromIndex...toIndex])
    }
}

class PossibleIPAddresses {
    func ipAddress(_ inputString: String) -> [String] {
        var validIPAddress = [String]()
        let firstStartIndex = 0
        for firstStringLength in 0..<3 {
            let secondStartIndex = firstStartIndex + firstStringLength + 1
            
            for secondStringLength in secondStartIndex..<secondStartIndex+3 {
                let thirdStartIndex =  secondStringLength + 1
                
                for thirdStringLength in thirdStartIndex..<thirdStartIndex+3 {
                    let fourthStartIndex = thirdStringLength + 1
                    
               if let first = isValid(inputString, firstStartIndex, firstStartIndex + firstStringLength),
                  let second = isValid(inputString, secondStartIndex, secondStringLength),
                  let third = isValid(inputString, thirdStartIndex, thirdStringLength),
                  
                  fourthStartIndex < inputString.count,
                  let fourth = isValid(inputString, fourthStartIndex, inputString.count-1) {
                    validIPAddress.append("\(first).\(second).\(third).\(fourth)")
                    }
                }
            }
        }
       return validIPAddress
    }

    private func isValid(_ inputString: String,
                 _ firstIndex: Int,
                 _ secondIndex: Int) -> String? {
        var validString: String?
        if secondIndex > inputString.count {
            return nil
        }
        
        if let intValue = Int(inputString.subString(from: firstIndex, to: secondIndex)),
           Int(intValue) >= 0 && Int(intValue) <= 255 {
            validString = inputString.subString(from: firstIndex, to: secondIndex)
        }
        return validString
    }
}

let checkIPAddress = PossibleIPAddresses()
let validIPs = checkIPAddress.ipAddress("25525511135")
print("valid IP Addresses are: \(validIPs)")
