import UIKit

struct Customer: Decodable {
    var firstName: String
    var lastName: String
    var age: Int
}

let json = """

{
    "first_name" : "Samet",
    "last_name" : "Yatmaz",
    "age" : 34
}

""".data(using: .utf8)!

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

let customer = try! decoder.decode(Customer.self, from: json)
print(customer)


struct Personel: Decodable {
    var firstName: String
    var lastName: String
    var age: Int
    var address: Address?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "FIRSTNAME"
        case lastName = "LASTNAME"
        case age = "AGE"
        case address = "ADDRESS"
    }
}

struct Address: Decodable {
    var street: String
    var state: String
    var zipCode: String
    
    private enum CodingKeys: String, CodingKey {
        case street = "STREET"
        case state = "STATE"
        case zipCode = "ZIPCODE"
    }
}

let json2 = """

{
    "FIRSTNAME" : "Samet",
    "LASTNAME" : "Yatmaz",
    "AGE" : 34,
    "ADDRESS": {
        "STREET" : "1200 Richmond Ave",
        "STATE" : "TX",
        "ZIPCODE" : "77042"
    }
}

""".data(using: .utf8)!

let decoder2 = JSONDecoder()
let personel = try! decoder2.decode(Personel.self, from: json2)
print(personel)
