func rearrange(a: [Int], b: [Int]) -> [Int] {
    var a = a
    var b = b
    
    var preA = 0
    var preB = 0
    var bElement = b[0]
    var aElement = a[0]
    
    var allArranged = false
    while !allArranged {
        preA = a[bElement]
        preB = b[bElement]
        
        a[bElement] = aElement
        b[bElement] = bElement
        
        bElement = preB
        aElement = preA
        
        if bElement == b[bElement] {
            for (index, element) in b.enumerated() {
                if index != element {
                    bElement = element
                    aElement = a[index]
                    break
                }
            }
            
            if bElement == preB {
                allArranged = true
            }
        }
    }
    return a
}

let result = rearrange(a: [4, 1, 3, 9, 7],
                       b: [2, 4, 3, 0, 1])
print(result)
