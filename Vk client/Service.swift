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
    
    func getFriends(completion: @escaping (DataForUser) -> Void)  {
        let url = baseUrl + "/friends.get"
        
        let param: Parameters = [
            "access_token": session.token,
            "v": "5.131",
            "user_id": session.userId,
            "order": "hints",
            "fields": "photo_100"
        ]
        AF.request(url, method: .get, parameters: param).responseData {response in
            
            guard let data = response.value else {return}
         
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let data = try decoder.decode(DataForUser.self,from: data)
                completion(data)
            } catch {
                print(error)
            }
        }
    }
    
    func getPhotos(forUser userId: Int, completion: @escaping (DataForPhoto) -> Void){
        let url = baseUrl + "/photos.getAll"
        
        let param: Parameters = [
            "access_token": session.token,
            "v": "5.131",
            "owner_id": userId,
        ]
        AF.request(url, method: .get, parameters: param).responseData {response in
            guard let data = response.value else {return}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let data = try decoder.decode(DataForPhoto.self,from: data)
                completion(data)
            } catch {
                print(error)
            }
        }
    }
    
    func getGroups(completion: @escaping (DataForGroup) -> Void) {
        let url = baseUrl + "/groups.get"
        
        let param: Parameters = [
            "access_token": session.token,
            "v": "5.131",
            "user_id": session.userId,
            "extended": 1
        ]
        AF.request(url, method: .get, parameters: param).responseData {response in
            guard let data = response.value else {return}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let data = try decoder.decode(DataForGroup.self,from: data)
                completion(data)
            } catch {
                print(error)
            }
        }
    }
    
    func getGroupsBySearch(forName name: String, completion: @escaping (DataForGroup) -> Void) {
        let url = baseUrl + "/groups.search"
        
        let param: Parameters = [
            "access_token": session.token,
            "v": "5.131",
            "q": name,
            "count": 100
        ]
        AF.request(url, method: .get, parameters: param).responseData {response in
            guard let data = response.value else {return}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let data = try decoder.decode(DataForGroup.self,from: data)
                completion(data)
            } catch {
                print(error)
            }
        }
    }
    
    func getPhoto(fromUrl urlString: String, completion: @escaping (UIImage) -> Void) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            completion(UIImage(data: data ?? Data()) ?? UIImage())
        }.resume()
    }
}

