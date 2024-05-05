//
//  SeriesHero.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 29/4/24.
//

import Foundation
struct Serie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail

    // Implementación personalizada de la función hash
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(thumbnail)
    }
    
    // Método de equidad personalizado
    static func == (lhs: Serie, rhs: Serie) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.description == rhs.description &&
               lhs.thumbnail == rhs.thumbnail
    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable, Hashable {
    let path: String
        let imageExtension: ImageExtension

        enum CodingKeys: String, CodingKey {
            case path
            case imageExtension = "extension"
        }
        
        // Implementación de hash para Thumbnail
        func hash(into hasher: inout Hasher) {
            hasher.combine(path)
            hasher.combine(imageExtension)
        }
}

// MARK: - ImageExtension
enum ImageExtension: String, Codable {
    case jpg = "jpg"
}

// MARK: - SeriesResponse
struct SeriesResponse: Codable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let etag: String
    let data: SerieData
}

// MARK: - SerieData
struct SerieData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Serie]
}

// MARK: - Character
struct Character: Codable {
    let available: Int
    let collectionURI: String
    let items: [CharacterItem]
    let returned: Int
}

// MARK: - CharacterItem
struct CharacterItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Creator
struct Creator: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorItem]
    let returned: Int
}

// MARK: - CreatorItem
struct CreatorItem: Codable {
    let resourceURI: String
    let name, role: String
}

// MARK: - TypeEnum
enum TypeEnum: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}
