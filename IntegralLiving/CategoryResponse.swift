import Foundation

// MARK: - CategoryResponseElement
struct CategoryResponseElement: Codable {
    let id: String
    let categoryID, parentID: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case categoryID = "id"
        case parentID = "parent_id"
        case name
    }
}

typealias CategoryResponse = [CategoryResponseElement]
