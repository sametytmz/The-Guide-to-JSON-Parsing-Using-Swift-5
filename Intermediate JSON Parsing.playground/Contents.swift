import UIKit

struct PlacesResponse: Decodable {
    var places: [Place]
}

struct Place: Decodable {
    var name: String
    var latitude: Double
    var longitude: Double
    var visited: Bool
}

let json = """

{
    "places":[
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
    }
    ]
}

""".data(using: .utf8)!

let placesResponse = try! JSONDecoder().decode(PlacesResponse.self, from: json)
print(placesResponse.places)

//let placesDictionary = try! JSONDecoder().decode(([String:[Place]]).self, from: json)
//print(placesDictionary)
//let places = placesDictionary["places"]!
//print(places)
