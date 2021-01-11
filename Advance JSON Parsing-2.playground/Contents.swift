import UIKit

public class Car: Decodable {
    var make: String = ""
    var model: String = ""
    
    init() {
        
    }
}

class ElectricCar: Car {
    var range: Double
    var hasAutoPilot: Bool
    
    private enum CodingKeys: String, CodingKey {
        case range
        case hasAutoPilot
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.range = try container.decode(Double.self, forKey: .range)
        self.hasAutoPilot = try container.decode(Bool.self, forKey: .hasAutoPilot)
        try super.init(from: decoder)
    }
}


let json = """

{
    "make" : "Tesla",
    "model" : "Model X",
    "range" : 400,
    "hasAutoPilot" : true
}

""".data(using: .utf8)!

let electricCar = try! JSONDecoder().decode(ElectricCar.self, from: json)
electricCar.make
electricCar.model
electricCar.range
electricCar.hasAutoPilot
