import Foundation
import CryptoKit

func hashData(data: Data) -> String {
    let hashedData = SHA256.hash(data: data)
    let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
    return hashString
}

// Usage:
let inputData = "a".data(using: .utf8)!
let hashedString = hashData(data: inputData)
print(hashedString) // Output: 4c776e56ac9ef79641470704e02b57e41a3e395d1c5eece8a6a8d1be10e2f0f0



//@IBOutlet weak var label: UILabel!
//
//var greetings = "Hello"
//
//lazy var greet: (String) -> () = {  name in
//    
//    self.greetings += " \(name)"
//
//
//
//    self.label.text =  self.greetings
//
//}
