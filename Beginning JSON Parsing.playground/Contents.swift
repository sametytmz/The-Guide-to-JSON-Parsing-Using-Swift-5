import UIKit

struct Customer: Codable {
    var firstName: String
    var lastName: String
    var age: Int
}

extension Customer {
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ResultCodingKeys.self)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(self.age, forKey: .age)
    }
}

// Decoding...
let json = """

{
    "firstName" : "Samet",
    "lastName" : "Yatmaz",
    "age" : 31
}

""".data(using: .utf8)!


let customer = try! JSONDecoder().decode(Customer.self, from: json)
print(customer)


// Encoding...
let customerEncodable = Customer(firstName: "Samet", lastName: "Yatmaz", age: 31)
let encodedCustomerJSON = try! JSONEncoder().encode(customerEncodable)
print(encodedCustomerJSON)
print(String(data: encodedCustomerJSON, encoding: .utf8)!)
