//
//  ContentResponse.swift
//  IntegralLiving
//
//  Created by Debashis.Ghosh on 8/16/20.
//  Copyright © 2020 IntegralLiving. All rights reserved.
//

import Foundation

// MARK: - ContentResponseElement
struct ContentResponseElement: Codable {
    let id: String
    let contentResponseID, categoryID: Int
    let content: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case contentResponseID = "id"
        case categoryID = "category_id"
        case content = "Content"
    }
}

typealias ContentResponse = [ContentResponseElement]
