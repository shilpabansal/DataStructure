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
            var firstString: String?
            var secondString: String?
            var thirdString: String?
            if let first = isValid(inputString, firstStartIndex, firstStartIndex + firstStringLength) {
                firstString = first
                
                let secondStartIndex = firstStartIndex + firstStringLength + 1
                for secondStringLength in 0..<3 {
                    if let second = isValid(inputString, secondStartIndex, secondStartIndex + secondStringLength) {
                        secondString = second
                    }
                    else {
                        secondString = nil
                    }
                    
                    let thirdStartIndex = secondStartIndex + secondStringLength + 1
                    for thirdStringLength in 0..<3 {
                        if let third = isValid(inputString, thirdStartIndex, thirdStartIndex + thirdStringLength) {
                            thirdString = third
                        }
                        else {
                            thirdString = nil
                        }
                        
                        let fourthStartIndex = thirdStartIndex + thirdStringLength + 1
                        if fourthStartIndex > inputString.count {
                            break
                        }
                        
                        if let fourthString = isValid(inputString, fourthStartIndex, inputString.count-1),
                           let firstString = firstString,
                              let secondString = secondString,
                              let thirdString = thirdString {
                                validIPAddress.append("\(firstString).\(secondString).\(thirdString).\(fourthString)")
                        }
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
