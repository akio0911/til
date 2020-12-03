import UIKit

func group(_ a: [Int]) -> [[Int]] {
    if a.isEmpty {
        return []
    } else {
        let x = a.first!
        let xs = a.dropFirst()
        let eq: (Int) -> Bool = { $0 == x }
        let r1 = [[x] + xs.prefix(while: eq)]
        let r2 = group([Int](xs.drop(while: eq)))
        return r1 + r2
    }
}

group([1,1,1,2,2,3,4,4,4,1,1])
