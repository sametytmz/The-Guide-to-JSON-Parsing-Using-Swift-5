import UIKit

struct Customer: Decodable {
    var firstName: String
    var lastName: String
    var age: Int
    
    private enum ResultCodingKeys: String, CodingKey {
        case firstName
        case lastName
        case age
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultCodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.age = try container.decode(Int.self, forKey: .age)
    }
}

let json = """

{
    "firstName" : "Samet",
    "lastName" : "Yatmaz",
    "age" : 31
}

""".data(using: .utf8)!


let customer = try! JSONDecoder().decode(Customer.self, from: json)
print(customer)
