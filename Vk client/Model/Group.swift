//
//  Group.swift
//  Vk client
//
//  Created by Ярослав on 03.02.2023.
//

import RealmSwift
import Foundation

final class Groups: Decodable {
    
    let count: Int
    let groups: [Group]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let response =  try container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .response)
        
        self.count = try response.decode(Int.self, forKey: .count)
        self.groups = try response.decode([Group].self, forKey: .items)
    }
    
    enum CodingKeys: CodingKey {
        case response
    }
    
    enum ResponseKeys: CodingKey {
        case count
        case items
    }
}

class Group: Decodable {
    let id: Int
    let name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo100"
    }
}
