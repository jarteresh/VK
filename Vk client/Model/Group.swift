//
//  Group.swift
//  Vk client
//
//  Created by Ярослав on 03.02.2023.
//

import Foundation

struct DataForGroup: Decodable{
    let response: ResponceForGroup
}
struct ResponceForGroup: Decodable {
    let count: Int
    let items: [Group]
}

struct Group: Decodable {
    let id: Int
    let name: String
    let avatar: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo100"
    }
}
