class Solution {
    func add(x: Int, y: Int) -> Int {
        var x = x
        var y = y
        // Iterate till there is no carry
        while y != 0 {
            let sum = x ^ y
            let carry = x & y
            x = sum
            y = carry << 1
        }
        return x;
    }
}

let solution = Solution()
let result = solution.add(x: 15, y: 32)
print("result: \(result)")
