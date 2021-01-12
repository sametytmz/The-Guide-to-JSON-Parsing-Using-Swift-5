import UIKit


struct Customer: Decodable {
    var firstName: String
    var lastName: String
    var dateCreated: Date
    var address: Address
}

struct Address: Decodable {
    var street: String
    var city: String
    var state: String
    var geo: Geo
    var addressType: AddressType
}

struct Geo: Decodable {
    var latitude: Double
    var longitude: Double
}

enum AddressType: String, Decodable {
    case apartment = "apartment"
    case house = "house"
    case conco = "condo"
    case townHouse = "townHouse"
}


struct CustomersResponse: Decodable {
    var customers: [Customer]
}

//reference - https://useyourloaf.com/
extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }()
}

let json = """

{
    "customers":[
        {
            "firstName" : "John",
            "lastName" : "Doe",
            "dateCreated" : "05-09-2018",
            "address" : {
                "street" : "1200 Richmond Ave",
                "city" : "Houston",
                "state" : "TX",
                "geo" : {
                    "latitude" : 34.56,
                    "longitude" : 35.65
                },
                "addressType" : "house"
            }
        }
    
    ]

}

""".data(using: .utf8)!

// Customize Decoder
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)

let customersResponse = try! decoder.decode(CustomersResponse.self, from: json)
let customers = customersResponse.customers
print(customers)
print(customers.first!.address.addressType.rawValue)
