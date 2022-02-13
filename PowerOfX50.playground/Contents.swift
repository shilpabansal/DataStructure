/*
 below 2 formula for odd and even numbers:
 
Even -> if 2 raised to power 10(even) has to be calculated -> power(power(2, 5), 2) -> power(32, 2) -> 1024  -> 5 is 10/2
Odd -> if 2 raised to power 11(even) has to be calculated -> 2 * power(power(2, 5), 2) -> 2 * power(32, 2) -> 2 * 1024 2048 -> 5 is 11/2
 */
class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 {
            return 1;
        }
        else if n < 0 {
            return myPow(1/x,-n);
        }
        else if n == 1 {
            return x;
        }
        else if n == 2 {
            return x*x;
        }
        else if n%2 == 0 {
            return myPow(myPow(x,n/2),2);
        }
        else {
            return x*myPow(myPow(x,n/2),2);
        }
    }
}

let powSolution = Solution()

let power = powSolution.myPow(1.00000, 2147483647)
print(power)
