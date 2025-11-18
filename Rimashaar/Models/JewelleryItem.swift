import SwiftUI

struct JewelleryItem: Identifiable, Decodable {
    let id: String
    let name: String
    let image: String
    let category: String
    let price: String
    let weight: String
    let karat: String

    enum CodingKeys: String, CodingKey {
        case id = "jewellery_id"
        case name, image, category, price, weight, karat
    }
    
    var imageName: String {
        return image
    }
}
