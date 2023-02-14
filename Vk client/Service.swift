//
//  Service.swift
//  Vk client
//
//  Created by Ярослав on 29.01.2023.
//

import Foundation
import Alamofire

class Service {
    
    let baseUrl = "https://api.vk.com/method"
    let session = Session.instance
    
    func getFriends(token: String) {
        let url = baseUrl + "/friends.get"
        
        let param: Parameters = [
            "access_token": token,
            "v": "5.131",
            "user_id": session.userId,
            "fields": "nickname"
        ]
        AF.request(url, method: .get, parameters: param).responseJSON {response in
            print(response)
        }
    }
    
    func getPhotos(token: String) {
        let url = baseUrl + "/photos.getAll"
        
        let param: Parameters = [
            "access_token": token,
            "v": "5.131",
            "owner_id": session.userId,
        ]
        AF.request(url, method: .get, parameters: param).responseJSON {response in
            print(response)
        }
    }
    
    func getGroups(token: String) {
        let url = baseUrl + "/groups.get"
        
        let param: Parameters = [
            "access_token": token,
            "v": "5.131",
            "user_id": session.userId,
        ]
        AF.request(url, method: .get, parameters: param).responseJSON {response in
            print(response)
        }
    }
    
    func getGroupsByName(token: String, name: String) {
        let url = baseUrl + "/groups.search"
        
        let param: Parameters = [
            "access_token": token,
            "v": "5.131",
            "q": name,
        ]
        AF.request(url, method: .get, parameters: param).responseJSON {response in
            print(response)
        }
    }
    
}
