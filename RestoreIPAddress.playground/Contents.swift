extension String {
    func index(of: Int) -> Index {
        return index(startIndex, offsetBy: of)
    }
}

class Solution {
    let validIPLength: [(min: Int, max: Int)] = [(4, 12), (3, 9), (2, 6), (1, 3)]
    
    func restoreIpAddresses(_ s: String) -> [String] {
        var result = [String]()
        
        if s.contains(where: { $0.asciiValue! < 48 || $0.asciiValue! > 57 }) ||
            s.count < validIPLength[0].min || s.count > validIPLength[0].max
        {
            return result
        }
        
        ipAddresses(s, unParsedString: "", startIndex: 0, result: &result)
        return result
    }
    
    private func ipAddresses(_ s: String, unParsedString: String, startIndex: Int, result: inout [String]) {
        var s = s
        var parsedString = ""
        if !unParsedString.isEmpty {
            parsedString = s
            s = unParsedString
        }
        
        for counter in 0..<3 {
            var preString = parsedString
            if s.count < counter+1 {
                return
            }
            
            if startIndex < 3 {
                let index = s.index(of: counter+1)
                let str1 = s[s.startIndex..<index]
                let nextString = s[index..<s.endIndex]
                
                let validLength = validIPLength[startIndex+1]
                if !isValid(ip: String(str1)) || nextString.count < validLength.min || nextString.count > validLength.max {
                    continue
                }
                
                preString += "\(str1)."
                ipAddresses(preString, unParsedString: String(nextString), startIndex: startIndex+1, result: &result)
            }
            else if isValid(ip: s) {
                preString += "\(s)"
                if startIndex == 3 && !result.contains(preString) {
                    result.append(preString)
                }
            }
        }
    }
    
    private func isValid(ip: String) -> Bool {
        guard let intValue = Int(ip),
              (ip.count == 1 ||
               (ip.count > 1 && Array(ip)[0] != "0")) else { return false}
        return intValue >= 0 && intValue <= 255
    }
}

let input = "25525511135"
let solution = Solution()
let result = solution.restoreIpAddresses(input)

print("Result: \(result)")
