extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func subString(to: Int) -> String {
        let toIndex = self.index(from: to)
        return String(self[...toIndex])
    }
    
    func subString(from: Int) -> String {
        let fromIndex = self.index(from: from)
        return String(self[fromIndex...])
    }
    
    func subString(from: Int, to: Int) -> String {
        let fromIndex = self.index(from: from)
        let toIndex = self.index(from: to)
        return String(self[fromIndex...toIndex])
    }
    
    func charAt(index: Int) -> Character {
        let stringArray = Array(self)
        return stringArray[index]
    }
    
    func containsString(_ str: String) -> Bool {
        let char = str.charAt(index: 0)
        let searchStringLength = str.count - 1
        
        var stringFound = false
        
        var index = 0
        while index < self.count {
            let charInMainString = self.charAt(index: index)
            if charInMainString == char {
                let end = index + searchStringLength
                if end >= self.count {
                    break
                }
                let subString = self.subString(from: index, to: end)
                
                if subString == str {
                    stringFound = true
                    break
                }
            }
            index += 1
        }
       
        return stringFound
    }
    
    func indexOfString(_ str: String) -> [Int] {
        var result = [Int]()
        let char = str.charAt(index: 0)
        let searchStringLength = str.count - 1
                
        var index = 0
        while index < self.count {
            let charInMainString = self.charAt(index: index)
            if charInMainString == char {
                let end = index + searchStringLength
                if end >= self.count {
                    break
                }
                let subString = self.subString(from: index, to: end)
                
                if subString == str {
                    result.append(index)
                }
            }
            index += 1
        }
       
        return result
    }
}

func findSubstring(_ s: String, _ words: [String]) -> [Int] {
    var result = [Int]()
    var subStrings = [String]()
    
    for i in words {
        for j in words {
            var subString = ""
            for k in words {
                if j != k && i != k {
                    subString = k
                }
            }
            if i != j {
                subString = i + j + subString
                if !subStrings.contains(subString) {
                    subStrings.append(subString)
                }
            }
        }
    }
    print("subStrings: \(subStrings)")
    
    for searchingWord in subStrings {
        if s.containsString(searchingWord) {
            
            let indexes = s.indexOfString(searchingWord)
            result.append(contentsOf: indexes)

            print("searchingWord: \(searchingWord) indexes: \(indexes)")
        }
    }
    print("result: \(result)")
    return result
}

findSubstring("barfoothefoobarman", ["foo", "bar"])
