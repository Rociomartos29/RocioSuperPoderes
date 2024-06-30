//
//  HerosModel.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 26/4/24.
//

import Foundation
struct SuperHeroResponse: Codable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let etag: String
    let data: SuperHeroData?
}

// MARK: - SuperHeroData
struct SuperHeroData: Codable {
    let offset, limit, total, count: Int
    let results: [SuperHero]
}

// MARK: - SuperHero
struct SuperHero: Codable, Identifiable, Hashable, Equatable {
    let id: Int
    let title: String?// optional para Series
    let name: String? // opcional para heros
    let description: String? // Puede o no venir vacío
    let thumbnail: SuperHeroThumbnail
    let resourceURI: String?
    
    init(id: Int, title: String?, name: String?, description: String?, thumbnail: SuperHeroThumbnail, resourceURI: String?) {
            self.id = id
            self.title = title
            self.name = name
            self.description = description
            self.thumbnail = thumbnail
            self.resourceURI = resourceURI
        }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: SuperHero, rhs: SuperHero) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - SuperHeroThumbnail
struct SuperHeroThumbnail: Codable {
    let path: String
    let `extension`: String

    enum CodingKeys: String, CodingKey {
        case path
        case `extension` = "extension"
    }
    init(path: String, extension: String) {
            self.path = path
            self.extension = `extension`
        }

    
    enum ThumbnailType: String {
        case portrait = "portrait_incredible"
        case standard = "standard_xlarge"
        case landscape = "landscape_amazing"
    }

    func url(type: ThumbnailType) -> String {
        return "\(path)/\(type.rawValue).\(self.extension)"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
}
// MARK: - SuperHeroComics
struct SuperHeroComics: Codable {
    let available: Int
    let collectionURI: String
    let items: [SuperHeroComicsItem]
    let returned: Int
}

// MARK: - SuperHeroComicsItem
struct SuperHeroComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - SuperHeroStories
struct SuperHeroStories: Codable {
    let available: Int
    let collectionURI: String
    let items: [SuperHeroStoriesItem]
    let returned: Int
}

// MARK: - SuperHeroStoriesItem
struct SuperHeroStoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: SuperHeroItemType
}

enum SuperHeroItemType: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

// MARK: - SuperHeroThumbnail


// MARK: - SuperHeroURLElement
struct SuperHeroURLElement: Codable {
    let type: SuperHeroURLType
    let url: String
}

enum SuperHeroURLType: String, Codable {
    case comiclink, detail, wiki
}

// MARK: - SuperHeroFilter
struct SuperHeroFilter: Codable {
    let name: String
}
