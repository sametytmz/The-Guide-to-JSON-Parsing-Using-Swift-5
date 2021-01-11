import UIKit

typealias Temperature = Double

extension Temperature {
    func toCelsius() -> Temperature {
        return (self - 32 * 5/9) + 32
    }
    func toFahrenheit() -> Temperature {
        return (self * 9/5)
    }
}

private enum TemperatureEncodingStrategy {
    case fahrenheit
    case celsius
}

extension CodingUserInfoKey {
    static let temperatureEncodingStrategy = CodingUserInfoKey.init(rawValue: "temperatureEncodingStrategy")
}

struct Thermostat: Encodable {
    var readings: [Temperature]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch (encoder.userInfo[CodingUserInfoKey.temperatureEncodingStrategy!] as? TemperatureEncodingStrategy) {
        case .celsius?:
            try container.encode(self.readings.map{ $0.toCelsius() })
        case .fahrenheit?:
            try container.encode(self.readings.map{ $0.toFahrenheit() })
        default:
            try container.encode(readings.map { $0.toCelsius() })
        }
    }
}

let readings = [12.24, 23.45, 56.78]
let encoder = JSONEncoder()
encoder.userInfo[CodingUserInfoKey.temperatureEncodingStrategy!] = TemperatureEncodingStrategy.fahrenheit
let thermostat = Thermostat(readings: readings)
let data = try! encoder.encode(thermostat)
print(String(data: data, encoding: .utf8)!)
