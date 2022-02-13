/*
 E.g. 2236
 assign the last index value to array index if the element is not zero
 If the 2 digit number with last element is valid, increment by one
 
 2 -> 1 way to decode it
 22 -> 1 way for 0th index + as 22 is valid number = 2
 223 => 2 ways to represent till 1st index + as 23 is valid = 3
 2236 => 3 ways to represent till 223 + as 36 is not valid = 3
 
 final answer to represent this number is 3 -> BBCF, VCF, BWF
 */
class Solution {
    func numDecodings(_ s: String) -> Int {
        let s = Array(s)
        var dp = Array(repeating: 0, count: s.count + 1)
        dp[0] = 1
        
        for i in 1...s.count {
            if s[i - 1] != "0" {
                dp[i] = dp[i - 1]
            }
            if i > 1 && isValid(s, i - 2, i - 1) {
                dp[i] += dp[i - 2]
            }
        }
        return dp[s.count]
    }
    
    private func isValid(_ s: [Character], _ start: Int, _ end: Int) -> Bool {
        guard let num = Int(String(s[start...end])) else {
            fatalError()
        }
        return num >= 10 && num <= 26
    }
}

let input = "2236"
let solution = Solution()
let result = solution.numDecodings(input)

print("Result: \(result)")

