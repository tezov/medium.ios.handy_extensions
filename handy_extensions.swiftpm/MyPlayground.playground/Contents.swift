import Foundation

// MARK: 1- Type converter extensions

//Character as Int
let input = "123"
for char in input {
    if let number = char.integer {
        //use number
    }
}

//some variables received as Int
let a:Int = 3
let b:Int = 2
//then need to be used as double in division for exmaple
let c:Double = a.double / b.double

//coming from json xml objective C legacy
if let isTrue = "yes".boolean {
    //do some stuff
}

//doing a coding game and wanna go fast
if "13355423".isOnlyDigits {
    //do some stuff
}

//If you want work without optional and suppply a fallback value
let r:Bool = "wrong value".boolean(fallback: false)
let t:Int = "wrong value".integer(fallback: 0)
let y:Double = "wrong value".double(fallback: 0.0)





// MARK: 2- Hexadecimal / Binary

print(2.26.hex) //4002147AE147AE14
print("4002147AE147AE14".hexToDouble!) //2.26

print(155245.hex) //25E6D
print(155245.hex(byteWidth: 8)!) //00025E6D **
print("25E6D".hexToInt!) //155245

print(64.binary) //1000000
print("1000000".binaryToInt!) //64

// Yeah, force unwrap is ugly :)
print("Wrong value".hexToInt(fallback: 0))
print("Wrong value".hexToDouble(fallback: 0.0))





// MARK: 3- Safely retrieving Values from Collections

print([0,1,2].getOrNil(at: 5) ?? "no value") // index is invalid so the result is "no value"

//Since the extension, is done on Collection, it's supposed to work on String too
//let s = "hello"
//print(s.getOrNil(at: s.index(s.startIndex, offsetBy: 10)) ?? "no value")







// MARK: 4- Count, Partition and Slice for Collections

//- Count
print([0,1,2,3,4].count { $0 % 2 == 0 }.accepted) //3
print([0,1,2,3,4].count { $0 % 2 == 0 }.refused) //2


//- Partition
let p = [0,1,2,3,4].partitioned { $0 % 2 == 0 }
print(p.accepted) // [0, 2, 4]
print(p.refused) // [1, 3]


//- Slice
print([0,1,2,3,4].sliced(of: 2)) // [[0,1],[2,3],[4]]
print([0,1,2,3,4,5,6,7,8,9].sliced(of: [1,2,1])) // [[0],[1,2],[3],[4],[5,6],[7],[8],[9]]
print([0,1,2,3,4,5,6,7,8,9].sliced(of: [1,2,1], sizeForRemaining: Int.max)) // [[0],[1,2],[3],[4,5,6,7,8,9]]




// MARK: 5- String.Index as Integer
var s = "hello world"
print(s[4]) //o

s[6] = "W"
print(s) //hello World

s[insertAt: 6] = "beautiful "
print(s) // hello beautiful World

print(s.intIndex(of: "l")!) //2

var n = "12345678"
print(n.intIndex { $0.integer! % 2 == 0 } ?? "not found") //1

let s2 = "nothing usefull"
print(s2.getOrNil(at: 488) ?? "failure") //failure





// MARK: 6- Simplified Regex
//example 1: extract matching part in string
let input1 = "|prefix|12|sperator|17|"
let matches1 = "\\|(.*?)(?=\\|)".toRegex.matches(input1)
var output1:[String] = []
matches1.forEach { match in
    if let range = match.getOrNil(at: 1) {
        output1.append(input1[range])
    }
}
print(output1) // prefix, 12, sperator, 17

//example 2: replace matching part in string
let input2 = "extension #-# are #-# so #-# cool"
let matches2 = "#-#".toRegex.matches(input2)
var output2 = input2
for match in matches2.reversed() {
    output2.replaceSubrange(match.range, with: "really")
}
print(output2) //extension really are really so really cool

