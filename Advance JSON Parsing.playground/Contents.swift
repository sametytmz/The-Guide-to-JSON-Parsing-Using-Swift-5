import UIKit

struct AnyDecodable: Decodable  {
    let value: Any
    
    init<T>(_ value:T?) {
        self.value = value ?? ()
    }
    
    init(from decoder: Decoder)throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            self.init(string)
        } else if let int = try? container.decode(Int.self) {
            self.init(int)
        } else if let bool = try? container.decode(Bool.self) {
            self.init(bool)
        } else {
            self.init(())
        }
    }
}

let json = """

{
    "foo" : "Hello",
    "bar" : 123,
    "isCheck" : true
}


""".data(using: .utf8)!

let dictionary = try! JSONDecoder().decode([String: AnyDecodable].self, from: json)
print(dictionary)
print(dictionary["isCheck"])
