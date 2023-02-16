//
//  User.swift
//  Vk client
//
//  Created by Ярослав on 02.02.2023.
//

import RealmSwift
import Foundation

class Users: Decodable {
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let response = try container.nestedContainer(keyedBy: ReponseKeys.self, forKey: .response)
        
        self.count =  try response.decode(Int.self, forKey: .count)
        self.users = try response.decode([User].self, forKey: .items)
    }
    
    var users: [User]
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    enum ReponseKeys: String, CodingKey {
        case count
        case items
    }
}

class User: Object, Decodable {
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var id: Int
    @Persisted var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case id
        case avatar = "photo100"
    }
}











