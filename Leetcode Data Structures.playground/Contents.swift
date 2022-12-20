import UIKit
import Darwin


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

public class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public var next: Node?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
        self.next = nil
    }
}

struct MatrixNode: Comparable {
    var x: Int
    var y: Int
    var val: Int = Int.max
    static func < (lhs: MatrixNode, rhs: MatrixNode) -> Bool {
        lhs.val < rhs.val
    }
    static func > (lhs: MatrixNode, rhs: MatrixNode) -> Bool {
        lhs.val > rhs.val
    }
}

class Stack<T> {
    private var list = [T]()
    private var index = -1
    
    func push(_ element: T) {
        index += 1
        list.append(element)
    }
    
    func pop() -> T {
        let element = list.remove(at: index)
        index -= 1
        return element
    }
    
    func peek() -> T {
        return list[index]
    }
    
    func isEmpty() -> Bool {
        return list.isEmpty
    }
}

class Queue<T> {
    var list = [T]()
    private var index = 0
    
    func push(_ element: T) {
        list.append(element)
    }
    
    func pop() -> T? {
        if index >= list.count {
            return nil
        }
        let element = list.remove(at: index)
        return element
    }
    
    func peek() -> T? {
        if index >= list.count {
            return nil
        }
        return list[index]
    }
    
    func isEmpty() -> Bool {
        return list.isEmpty
    }
}

class Solution {
    // MARK: Data Structure I
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var map: [Int: Bool] = [:]
        
        for num in nums {
            if map[num] != nil {
                return true
            } else {
                map[num] = true
            }
        }
        return false
    }
    
    func maxSubArray(_ nums: [Int]) -> Int {
        var isAllNegative = true
                for num in nums {
                    if num > 0 {
                        isAllNegative = false
                        break
                    }
                }
                if isAllNegative {
                    return nums.max()!
                }
        var sum = 0, maxSum = 0
        for num in nums {
            sum += num
            sum = sum < 0 ? 0 : sum
            maxSum = max(sum, maxSum)
        }
        return maxSum
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var map: [Int: Int] = [:]
        for (i, num) in nums.enumerated() {
            if let other = map[target - num] {
                return [i, other]
            } else {
                map[num] = i
            }
        }
        return []
    }
    
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var temp = [Int]()
        var i1 = 0, i2 = 0, iTemp = 0
        for i in nums1.indices {
            if i >= m {
                nums1[i] = Int.max
            }
        }
        for _ in nums1.indices {
            print("Indices: ", i1, i2, iTemp)
            print("Arrays: ", nums1, nums2, temp)
            let mini: Int
            if !temp.isEmpty && i2 < nums2.count {
                mini = min(nums1[i1], nums2[i2], temp[iTemp])
                print(nums1[i1], nums2[i2], temp[iTemp])
            } else if i2 < nums2.count {
                mini = min(nums1[i1], nums2[i2])
                print(nums1[i1], nums2[i2])
            } else if !temp.isEmpty {
                mini = min(nums1[i1], temp[iTemp])
                print(nums1[i1], temp[iTemp])
            }
            else {
                mini = nums1[i1]
                print(nums1[i1])
            }
            
            if i2 < nums2.count && mini == nums2[i2] {
                temp.append(nums1[i1])
                nums1[i1] = nums2[i2]
                i2 += 1
            } else if !temp.isEmpty && mini == temp[iTemp] {
                temp.append(nums1[i1])
                nums1[i1] = temp[iTemp]
                iTemp += 1
            }
            i1 += 1
            
        }
    }
    
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var map1 = [Int: Int](), map2 = [Int: Int]()
        var res = [Int]()
        
        for num in nums1 {
            map1[num] = (map1[num] ?? 0) + 1
        }
        for num in nums2 {
            map2[num] = (map2[num] ?? 0) + 1
        }
        
        if map1.count >= map2.count {
            for entry in map1 {
                if map2[entry.key] != nil {
                    res.append(contentsOf: [Int](repeating: entry.key, count: min(entry.value, map2[entry.key]!)))
                }
            }
        }
        
        else {
            for entry in map2 {
                if map1[entry.key] != nil {
                    res.append(contentsOf: [Int](repeating: entry.key, count: min(entry.value, map1[entry.key]!)))
                }
            }
        }
        
        return res
    }
    
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count == 1 {
            return 0
        }
        
        var minPrice = Int.max, maxProfit = 0
        for price in prices {
            if price < minPrice {
                minPrice = price
            } else if price - minPrice > maxProfit {
                maxProfit = price - minPrice
            }
        }
        
        return maxProfit
    }
    
    func matrixReshape(_ mat: [[Int]], _ r: Int, _ c: Int) -> [[Int]] {
        var vector = [Int]()
        for row in mat {
            for num in row {
                vector.append(num)
            }
        }
        
        if r * c != vector.count {
            return mat
        }
        
        var res = [[Int]](repeating: [Int](repeating: 0, count: c), count: r)
        var row = 0, col = 0
        for num in vector {
            res[row][col] = num
            col += 1
            if col == c {
                col = 0
                row += 1
            }
        }
        
        return res
    }
    
    func generate(_ numRows: Int) -> [[Int]] {
        var res: [[Int]] = []
        
        for i in 1...numRows {
            res.append([Int](repeating: 1, count: i))
            for j in res[i - 1].indices {
                if j != 0 && j != res[i - 1].count - 1 {
                    res[i - 1][j] = res[i - 2][j - 1] + res[i - 2][j]
                }
            }
        }
        
        return res
    }
    
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        var map: [Character: Bool] = [:]
        
        for row in board {
            for char in row {
                if char != "." && map[char] != nil {
                    return false
                }
                map[char] = true
            }
            map = [:]
        }
        
        for i in 0...8 {
            for row in board {
                if row[i] != "." && map[row[i]] != nil {
                    return false
                }
                map[row[i]] = true
            }
            map = [:]
        }
        
        for k in 0...8 {
            for i in k/3*3..<k/3*3+3 {
                for j in k%3*3..<k%3*3+3 {
                    if board[i][j] != "." && map[board[i][j]] != nil {
                        print(k, i, j, "Number: ", board[i][j])
                        return false
                    }
                    map[board[i][j]] = true
                }
            }
            map = [:]
        }
        
        
        return true
    }
    
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        for row in matrix {
            if target <= row.last! {
                var l = 0, r = row.count - 1
                while l <= r {
                    let mid = l + (r - l)/2
                    if row[mid] > target {
                        r = mid - 1
                    } else if row[mid] < target {
                        l = mid + 1
                    } else {
                        return true
                    }
                }
                break
            }
        }
        return false
    }
    
    func firstUniqChar(_ s: String) -> Int {
        var map: [Character: Int] = [:]
        
        for (index, char) in s.enumerated() {
            if map[char] == nil {
                map[char] = index
            } else {
                map[char] = Int.max
            }
        }
        
        var minIndex = Int.max
        for entry in map {
            if map[entry.key]! < minIndex {
                minIndex = map[entry.key]!
            }
        }
        return minIndex == Int.max ? -1 : minIndex
    }
    
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var ransomMap: [Character: Int] = [:]
        var magazineMap: [Character: Int] = [:]
        
        for char in ransomNote {
            ransomMap[char] = (ransomMap[char] ?? 0) + 1
        }
        for char in magazine {
            magazineMap[char] = (magazineMap[char] ?? 0) + 1
        }
        
        for entry in ransomMap {
            if entry.value > magazineMap[entry.key] ?? -1 {
                return false
            }
        }
        return true
        
    }
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        var arr = [Int](repeating: 0, count: 26)
        
        for char in s {
            arr[Int(char.asciiValue!) - 97] += 1
        }
        
        for char in t {
            arr[Int(char.asciiValue!) - 97] -= 1
        }
        
        return arr.allSatisfy { num in
            num == 0
        }
    }
    
    func hasCycle(_ head: ListNode?) -> Bool {
        var pointer = head
        
        while pointer != nil {
            if pointer!.val == Int.max {
                return true
            }
            pointer!.val = Int.max
            pointer = pointer!.next
        }
        return false
    }
    
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        var pointer = head
        var head = head
        
        while true {
            if pointer?.val == val {
                head = head?.next
                pointer = pointer?.next
            } else {
                break
            }
        }
        
        while pointer?.next != nil {
            if pointer!.next!.val == val {
                pointer?.next = pointer?.next?.next
            } else {
                pointer = pointer!.next
            }
        }
        return head
    }
    
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var pointer = head
        
        while pointer?.next != nil {
            if pointer?.next?.val == pointer?.val {
                pointer?.next = pointer?.next?.next
            } else {
                pointer = pointer?.next
            }
        }
        return head
    }
    
    func isValid(_ s: String) -> Bool {
        let stack = Stack<Character>()
        
        for char in s {
            if char == "(" || char == "[" || char == "{" {
                stack.push(char)
            } else {
                if !stack.isEmpty() && isMatchinParenthesis(c1: stack.peek(), c2: char) {
                    stack.pop()
                } else {
                    return false
                }
            }
        }
        return stack.isEmpty()
    }
    
    private func isMatchinParenthesis(c1: Character, c2: Character) -> Bool {
        if c1 == "(" && c2 == ")" {
            return true
        }
        if c1 == "{" && c2 == "}" {
            return true
        }
        if c1 == "[" && c2 == "]" {
            return true
        }
        return false
    }
    
    class MyQueue {
        var s1 = Stack<Int>()
        var s2 = Stack<Int>()
        
        init() {
            
        }
        
        func push(_ x: Int) {
            s1.push(x)
            s2.push(x)
        }
        
        func pop() -> Int {
            var first = 0
            while !s2.isEmpty() {
                first = s2.pop()
            }
            
            while !s1.isEmpty() && s1.peek() != first {
                s2.push(s1.pop())
            }
            
            s1 = Stack<Int>()
            
            while !s2.isEmpty() {
                s1.push(s2.pop())
            }
            
            let sTemp = Stack<Int>()
            while !s1.isEmpty() {
                sTemp.push(s1.pop())
            }
            while !sTemp.isEmpty() {
                s1.push(sTemp.peek())
                s2.push(sTemp.pop())
            }
            
            return first
        }
        
        func peek() -> Int {
            var first = 0
            while !s2.isEmpty() {
                first = s2.pop()
            }
            
            let sTemp = Stack<Int>()
            while !s1.isEmpty() {
                sTemp.push(s1.pop())
            }
            while !sTemp.isEmpty() {
                s1.push(sTemp.peek())
                s2.push(sTemp.pop())
            }
            
            return first
        }
        
        func empty() -> Bool {
            s1.isEmpty()
        }
    }
    
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        
        preorderTraversal(root, nodes: &res)
        
        return res
    }
    
    private func preorderTraversal(_ root: TreeNode?, nodes: inout [Int]) {
        if root != nil {
            nodes.append(root!.val)
            preorderTraversal(root!.left, nodes: &nodes)
            preorderTraversal(root!.right, nodes: &nodes)
        }
    }
    
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        
        inorderTraversal(root, nodes: &res)
        
        return res
    }
    
    private func inorderTraversal(_ root: TreeNode?, nodes: inout [Int]) {
        if root != nil {
            inorderTraversal(root!.left, nodes: &nodes)
            nodes.append(root!.val)
            inorderTraversal(root!.right, nodes: &nodes)
        }
    }
    
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        
        postorderTraversal(root, nodes: &res)
        
        return res
    }
    
    private func postorderTraversal(_ root: TreeNode?, nodes: inout [Int]) {
        if root != nil {
            postorderTraversal(root!.left, nodes: &nodes)
            postorderTraversal(root!.right, nodes: &nodes)
            nodes.append(root!.val)
        }
    }
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var queue = [TreeNode]()
        var nodes: [[Int]] = []
        if let root = root {
            queue.append(root)
            queue.append(TreeNode(Int.max))
            nodes.append([root.val])
        }
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if node.val == Int.max {
                if queue.isEmpty {
                    break
                } else {
                    var temp = [Int]()
                    for node in queue {
                        temp.append(node.val)
                    }
                    print("HOW")
                    nodes.append(temp)
                    queue.append(TreeNode(Int.max))
                    continue
                }
            }
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        
        return nodes
    }
    
    func maxDepth(_ root: TreeNode?) -> Int {
        var queue = [TreeNode]()
        var nodes: [[Int]] = []
        if let root = root {
            queue.append(root)
            queue.append(TreeNode(Int.max))
            nodes.append([root.val])
        }
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if node.val == Int.max {
                if queue.isEmpty {
                    break
                } else {
                    var temp = [Int]()
                    for node in queue {
                        temp.append(node.val)
                    }
                    print("HOW")
                    nodes.append(temp)
                    queue.append(TreeNode(Int.max))
                    continue
                }
            }
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        
        return nodes.count
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        isSymmetric(root?.left, root?.right)
    }
    
    private func isSymmetric(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        if root1 == nil && root2 == nil {
            return true
        } else if root1 == nil {
            return false
        } else if root2 == nil {
            return false
        }
        if root1?.val != root2?.val {
            return false
        }
        return isSymmetric(root1?.left, root2?.right) && isSymmetric(root1?.right, root2?.left)
    }
    
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        var root = root
        invertTreeR(&root)
        return root
    }
    
    private func invertTreeR(_ root: inout TreeNode?) {
        if root?.left == nil && root?.right == nil {
            return
        }
        let temp = root!.left
        root!.left = root!.right
        root!.right = temp
        
        invertTreeR(&root!.left)
        invertTreeR(&root!.right)
    }
    
    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        if root == nil {
            return false
        }
        if root!.left == nil && root!.right == nil {
            return targetSum == root!.val
        }
        return hasPathSum(root!.left, targetSum - root!.val) || hasPathSum(root!.right, targetSum - root!.val)
    }
    
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        var pointer = root
        
        while true {
            if pointer == nil {
                return nil
            }
            if val < pointer!.val {
                pointer = pointer!.left
            } else if val > pointer!.val {
                pointer = pointer!.right
            } else {
                return pointer
            }
        }
    }
    
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        var pointer = root
        while true {
            if pointer == nil {
                return TreeNode(val)
            }
            if val < pointer!.val {
                if pointer!.left == nil {
                    pointer!.left = TreeNode(val)
                    break
                }
                pointer = pointer!.left
            } else if val > pointer!.val {
                if pointer!.right == nil {
                    pointer!.right = TreeNode(val)
                    break
                }
                pointer = pointer!.right
            }
        }
        return root
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValidBST(root, Int(Int32.min)..<Int(Int32.max) + 1)
    }
    
    private func isValidBST(_ root: TreeNode?, _ range: Range<Int>) -> Bool {
        if root == nil {
            return true
        }
        if root!.val > (root!.left?.val ?? Int.min) &&
            root!.val < (root!.right?.val ?? Int.max) &&
            range.contains(root!.val) {
        } else {
            return false
        }
        return isValidBST(root!.left, range.lowerBound..<root!.val) &&
        isValidBST(root!.right, (root!.val + 1)..<range.upperBound)
    }
    
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        var map: [Int: Int] = [:]
        var found = false
        findTarget(root, k, &map, &found)
        return found
    }
    
    private func findTarget(_ root: TreeNode?, _ k: Int, _ map: inout [Int: Int], _ found: inout Bool) {
        if root != nil {
            findTarget(root!.left, k, &map, &found)
            if map[root!.val] != nil {
                found = true
            } else {
                map[k - root!.val] = 1
            }
            findTarget(root!.right, k, &map, &found)
        }
    }
    
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        var root = root
        if p == nil && q == nil {
            return nil
        } else if p == nil {
            return q
        } else if q == nil {
            return p
        }
        while true {
            if root == nil {
                return root
            }
            if root!.val == p!.val {
                return p
            } else if root!.val == q!.val {
                return q
            } else if (root!.val > p!.val && root!.val < q!.val) || (root!.val < p!.val && root!.val > q!.val) {
                return root
            } else if root!.val > p!.val && root!.val > q!.val {
                root = root!.left
            } else {
                root = root!.right
            }
        }
    }
    
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        return [
            nums.firstIndex(where: { $0 == target }) ?? -1,
            nums.lastIndex(where: { $0 == target }) ?? -1
        ]
    }
}

print(Solution().findTarget(TreeNode(2, TreeNode(1), TreeNode(3)), 4))
