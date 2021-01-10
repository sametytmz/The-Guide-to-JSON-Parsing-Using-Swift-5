import UIKit

struct Customer {
    var firstName: String
    var lastName: String
    var age: Int
}

extension Customer {
    init?(dictionary: [String:Any]) {
        guard let firstName = dictionary["firstName"] as? String,
              let lastName = dictionary["lastName"] as? String,
              let age = dictionary["age"] as? Int else { return nil }
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}

let json = """

{
    "firstName" : "Samet",
    "lastName" : "Yatmaz",
    "age" : 31
}

""".data(using: .utf8)!

if let dictionary = try? JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:Any] {
    if let customer = Customer(dictionary: dictionary) {
        print(customer)
    }
}


let jsonList = """

[
    {
        "firstName" : "Samet",
        "lastName" : "Yatmaz",
        "age" : 31
    },
    {
        "firstName" : "Aykut",
        "lastName" : "Kocaman",
        "age" : 55
    },
    {
        "firstName" : "Ridvan",
        "lastName" : "Dilmen",
        "age" : 58
    }
]

""".data(using: .utf8)!

if let customerList = try? JSONSerialization.jsonObject(with: jsonList, options: .allowFragments) as? [[String:Any]] {
    let customers = customerList.map(Customer.init)
    print(customers)
}
