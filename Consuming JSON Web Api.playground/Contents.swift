import UIKit
import PlaygroundSupport

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
}

struct Address: Decodable {
    let street: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Decodable {
    let latitude: String
    let longitude: String
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}


let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
URLSession.shared.dataTask(with: url) { data, response, error in
    guard error == nil,
        let data = data else {
            print(error)
            return
    }
    
    let users = try? JSONDecoder().decode([User].self, from: data)
    if let users = users {
        //print(users)
        print(users[0].name)
        print(users[0].address.street)
        print(users[0].address.geo.latitude)
    }
}.resume()

PlaygroundPage.current.needsIndefiniteExecution = true
