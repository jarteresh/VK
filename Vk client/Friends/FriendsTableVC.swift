//
//  FriendsTableVC.swift
//  Vk client
//
//  Created by Ярослав on 01.02.2023.
//

import UIKit
import RealmSwift

class FriendsTableVC: UITableViewController {
    
    var friends: [RealmUser]? = nil
    let realm = try! Realm()
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendsCell")
        if let users = realm.objects(RealmUsers.self).first?.users {
            friends = Array(users)
        }
        refresh.addTarget(self, action: #selector(update(_ :)), for: .valueChanged)
        tableView.addSubview(refresh)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let friends = friends {
            return friends.count
        } else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        
        guard let friends = friends else {return cell}
        let friend = friends[indexPath.row]

        Service().getPhoto(fromUrl: friend.avatar) { friendPhoto in
            DispatchQueue.main.async {
                cell.avatar.image = friendPhoto
            }
        }
        cell.name.text = friend.firstName + " " + friend.lastName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let friends = friends else {return}
        let friend = friends[indexPath.row]
        performSegue(withIdentifier: "showPhotos", sender: friend.id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showPhotos",
              let photosCollectionVC = segue.destination as? PhotosCollectionVC,
              let id = sender as? Int
        else {return}
        
        photosCollectionVC.userId = id
    }
    
    @objc func update(_ sender: AnyObject) {
        Service().getFriends {
            if let users = self.realm.objects(RealmUsers.self).first?.users {
                self.friends = Array(users)
            }
            self.tableView.reloadData()
        }
        refresh.endRefreshing()
    }
}
