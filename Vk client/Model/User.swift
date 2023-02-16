//
//  User.swift
//  Vk client
//
//  Created by Ярослав on 02.02.2023.
//

import Foundation

struct DataForUser: Decodable{
    let response: ResponceForUser
}
struct ResponceForUser: Decodable {
    let count: Int
    let items: [User]
}
struct User: Decodable {
    let firstName: String
    let lastName: String
    let id: Int
    let avatar: String
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case id
        case avatar = "photo100"
    }
}

var allUsers = [User]()





