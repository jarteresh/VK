//
//  RealmObjects.swift
//  Vk client
//
//  Created by Ярослав on 20.02.2023.
//

import Foundation
import RealmSwift

class RealmUsers: Object {
    @Persisted var count: Int
    @Persisted var users: List<RealmUser>
}

class RealmUser: Object {
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var id: Int
    @Persisted var avatar: String
}

class RealmPhotos: Object {
    @Persisted var count: Int
    @Persisted var photos: List<RealmPhoto>
}

class RealmPhoto: Object {
    @Persisted var albumId: Int
    @Persisted var date: Int
    @Persisted var id: Int
    @Persisted var ownerId: Int
    @Persisted var height: Int
    @Persisted var width: Int
    @Persisted var url: String
}

class RealmGroups: Object {
    @Persisted var count: Int
    @Persisted var groups: List<RealmGroup>
}

class RealmGroup: Object {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var avatar: String
}
