import SwiftUI

enum Tab: String, CaseIterable, Identifiable {
    case house
    case bag
    case book
    case person
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .house: return "Home"
        case .bag: return "Shop"
        case .book: return "Article"
        case .person: return "Profile"
        }
    }
}
