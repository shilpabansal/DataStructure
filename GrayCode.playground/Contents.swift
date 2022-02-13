class Solution {
    func grayCode(_ n: Int) -> [Int] {
       var array = [Int]()
        
        array.append(0)
        if n == 0 {
            return array
        }
        
        array.append(1)
        if n == 1 {
            return array
        }
        
        
        var addition = 1
        for _ in 2...n {
            addition *= 2

            var currentIndex = array.count-1
            var tempArray = [Int]()
            while currentIndex >= 0 {
                let newElement = array[currentIndex] + addition
                tempArray.append(newElement)
                currentIndex -= 1
            }
            array.append(contentsOf: tempArray)
        }
        
        return array
    }
}

let solution = Solution()
let result = solution.grayCode(1)
print(result)
