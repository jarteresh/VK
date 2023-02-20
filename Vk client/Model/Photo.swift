//
//  Photo.swift
//  Vk client
//
//  Created by Ярослав on 09.02.2023.
//

import RealmSwift
import Foundation

final class Photos: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let responce = try container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .response)
        
        self.count = try responce.decode(Int.self, forKey: .count)
        
        self.photos = try responce.decode([Photo].self, forKey: .items)
    }
    
    let count: Int
    let photos: [Photo]
    

    enum CodingKeys: CodingKey {
        case response
    }

    enum ResponseKeys: CodingKey {
        case count
        case items
    }
}

final class Photo: Decodable {
    
    init(from decoder: Decoder) throws {
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
    
    let albumId: Int
    let date: Int
    let id: Int
    let ownerId: Int
    let height: Int
    let width: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case albumId
        case date
        case id
        case ownerId
        case sizes
    }
}

class Sizes: Decodable {
    var height: Int
    var width: Int
    var url: String
}


