import SwiftUI

struct RatesData: Decodable {
    let gold: GoldRates
    let silver: SilverRates
    let platinum: PlatinumRates
    let todayspercentage: String

    struct GoldRates: Decodable {
        let k24: String
        let k22: String
        let k21: String
        let k18: String

        enum CodingKeys: String, CodingKey {
            case k24 = "24k"
            case k22 = "22k"
            case k21 = "21k"
            case k18 = "18k"
        }
    }

    struct SilverRates: Decodable {
        let perGram: String

        enum CodingKeys: String, CodingKey {
            case perGram = "per_gram"
        }
    }

    struct PlatinumRates: Decodable {
        let perGram: String

        enum CodingKeys: String, CodingKey {
            case perGram = "per_gram"
        }
    }
}

enum Metal: String, CaseIterable, Identifiable {
    case gold = "Gold"
    case silver = "Silver"
    case platinum = "Platinum"
    
    var id: String { self.rawValue }
}
