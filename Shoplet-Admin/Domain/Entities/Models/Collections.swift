//
//  Collections.swift
//  Shoplet-Admin
//
//  Created by Macos on 19/06/2025.
//

import Foundation

// MARK: - CollectionsResponse
struct CollectionsResponse: Codable {
    let collections: [Collection]?

    enum CodingKeys: String, CodingKey {
        case collections = "smart_collections"
    }
}

// MARK: - CollectionRequest
struct CollectionRequest: Codable {
    let collection: Collection

    enum CodingKeys: String, CodingKey {
        case collection = "smart_collection"
    }
}

// MARK: - Collection
struct Collection: Codable, Identifiable {

    
    let id: Int?
    let handle: String?
    var title: String?
    let updatedAt: String?
    let bodyHTML: String?
    let publishedAt: String?
    let sortOrder: String?
    let templateSuffix: String?
    let disjunctive: Bool?
    let rules: [Rule]?
    let publishedScope: String?
    let adminGraphqlApiID: String?
    var image: CollectionImage?

    init(
            id: Int? = nil,
            handle: String? = nil,
            title: String?,
            updatedAt: String? = nil,
            bodyHTML: String? = nil,
            publishedAt: String? = nil,
            sortOrder: String? = nil,
            templateSuffix: String? = nil,
            disjunctive: Bool? = nil,
            rules: [Rule]? = nil,
            publishedScope: String? = nil,
            adminGraphqlApiID: String? = nil,
            image: CollectionImage?
        ) {
            self.id = id
            self.handle = handle
            self.title = title
            self.updatedAt = updatedAt
            self.bodyHTML = bodyHTML
            self.publishedAt = publishedAt
            self.sortOrder = sortOrder
            self.templateSuffix = templateSuffix
            self.disjunctive = disjunctive
            self.rules = [Rule(column: "title", relation: "contains", condition: title)]
            self.publishedScope = publishedScope
            self.adminGraphqlApiID = adminGraphqlApiID
            self.image = image
        }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case handle
        case title
        case updatedAt = "updated_at"
        case bodyHTML = "body_html"
        case publishedAt = "published_at"
        case sortOrder = "sort_order"
        case templateSuffix = "template_suffix"
        case disjunctive
        case rules
        case publishedScope = "published_scope"
        case adminGraphqlApiID = "admin_graphql_api_id"
        case image
    }
}

// MARK: - Rule
struct Rule: Codable {
    let column: String?
    let relation: String?
    let condition: String?
}

// MARK: - Image
struct CollectionImage: Codable {
    let createdAt: String?
    let alt: String?
    let width: Int?
    let height: Int?
    var src: String?
    
    init(createdAt: String? = nil, alt: String? = nil, width: Int? = nil, height: Int? = nil, src: String?) {
        self.createdAt = createdAt
        self.alt = alt
        self.width = width
        self.height = height
        self.src = src
    }

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case alt
        case width
        case height
        case src
    }
}
