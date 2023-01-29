//
//  Session.swift
//  Vk client
//
//  Created by Ярослав on 28.01.2023.
//

import Foundation

class Session {
    
    private init(){}
    
    static let instance = Session()
    
    var token: String = ""
    var userId: Int = 0
    
}

