//
//  Photo.swift
//  Vk client
//
//  Created by Ярослав on 09.02.2023.
//

import Foundation

struct DataForPhoto: Decodable{
    let response: ResponceForPhoto
}
struct ResponceForPhoto: Decodable {
    let count: Int
    let items: [ItemsForPhoto]
}
struct ItemsForPhoto: Decodable {
    let albumId: Int
    let date: Int
    let id: Int
    let ownerId: Int
    let photo: [Photo]
    enum CodingKeys: String, CodingKey {
        case albumId
        case date
        case id
        case ownerId
        case photo = "sizes"
    }
}

struct Photo: Decodable {
    let height: Int
    let width: Int
    let url: String
}
