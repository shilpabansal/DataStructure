class Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        var ans = [String]()
        addParenthesis(open: n, close: n, ans: &ans, cur: "")
        return ans
    }
    
    private func addParenthesis(open: Int, close: Int, ans: inout [String], cur: String) {
        guard open != 0 || close != 0 else {
            ans.append(cur)
            return
        }
        
        if open > 0 {
            addParenthesis(open: open - 1, close: close, ans: &ans, cur: "\(cur)(")
        }
        
        if close > 0, close > open {
            addParenthesis(open: open, close: close - 1, ans: &ans, cur: "\(cur))")
        }
    }
}

let solution = Solution()
let result = solution.generateParenthesis(3)
print("Result is :\(result)")
