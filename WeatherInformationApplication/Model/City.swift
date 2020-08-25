/*
 {
 "city_name":"밀라노",
 "state":12,
 "celsius":20.3,
 "rainfall_probability":20
 },
 */
import Foundation

struct City: Codable{
    let name                : String
    let state               : Int
    let celsius             : Double
    let rainfallProbability : Double
    
    enum CodingKeys: String, CodingKey {
        case name                   = "city_name"
        case state                  = "state"
        case celsius                = "celsius"
        case rainfallProbability    = "rainfall_probability"
    }
}
