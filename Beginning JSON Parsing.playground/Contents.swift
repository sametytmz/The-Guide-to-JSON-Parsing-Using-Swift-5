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



// Decoding Json Object Array

struct Place: Decodable {
    var name: String
    var latitude: Double
    var longitude: Double
    var visited: Bool
}

extension Place {
   private enum ResultCodingKeys: String, CodingKey {
        case name
        case latitude
        case longitude
        case visited
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultCodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.visited = try container.decode(Bool.self, forKey: .visited)
    }
}

let jsonList = """

[
    {
        "name" : "Costa Rica",
        "latitude" : 23.45,
        "longitude" : 45.23,
        "visited" : true
    },
    {
        "name" : "Puerto Rico",
        "latitude" : 23,
        "longitude" : 45,
        "visited" : true
    },
    {
        "name" : "Mexico City",
        "latitude" : 23,
        "longitude" : 45,
        "visited" : true
    },
    {
        "name" : "Iceland",
        "latitude" : 23,
        "longitude" : 45,
        "visited" : false
    }
]

""".data(using: .utf8)!

let places = try! JSONDecoder().decode([Place].self, from: jsonList)
print(places[1].name)
print(places)
