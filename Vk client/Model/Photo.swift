//
//  Photo.swift
//  Vk client
//
//  Created by Ярослав on 09.02.2023.
//

import RealmSwift
import Foundation

class Photos: Decodable {

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let responce = try container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .response)
        
        self.count = try responce.decode(Int.self, forKey: .count)
        
        self.photos = try responce.decode([Photo].self, forKey: .items)
    }
    
    var count: Int
    var photos: [Photo]

    enum CodingKeys: CodingKey {
        case response
    }

    enum ResponseKeys: CodingKey {
        case count
        case items
    }
}

class Photo: Decodable {
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.albumId = try container.decode(Int.self, forKey: .albumId)
        self.date = try container.decode(Int.self, forKey: .date)
        self.id = try container.decode(Int.self, forKey: .id)
        self.ownerId = try container.decode(Int.self, forKey: .ownerId)
        
        let sizes = try container.decode([Sizes].self, forKey: .sizes)
    
        self.height = sizes[3].height
        self.width = sizes[3].width
        self.url = sizes[3].url
    }
    
    var albumId: Int
    var date: Int
    var id: Int
    var ownerId: Int
    var height: Int
    var width: Int
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case albumId
        case date
        case id
        case ownerId
        case sizes
    }
}

class Sizes: Object, Decodable {
    @Persisted var height: Int
    @Persisted var width: Int
    @Persisted var url: String
}
