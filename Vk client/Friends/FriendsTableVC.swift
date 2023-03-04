//
//  FriendsTableVC.swift
//  Vk client
//
//  Created by Ярослав on 01.02.2023.
//

import UIKit
import RealmSwift
import SDWebImageSwiftUI

class FriendsTableVC: UITableViewController {
    
    var friends: Results<RealmUser>?
    let realm = try! Realm()
    var token: NotificationToken?
    let refresh = UIRefreshControl()
    
    private let reuseIdentifier = "FriendsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        Service().getFriends()
        pairTableViewWithRealm()
        refresh.addTarget(self, action: #selector(updateTableView(_ :)), for: .valueChanged)
        tableView.addSubview(refresh)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FriendsTableViewCell
        
        guard let friends = friends else {return cell}
        let friend = friends[indexPath.row]
        
        cell.avatar.imageView.sd_setImage(with: URL(string: friend.avatar))
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
    
    @objc func updateTableView(_ sender: AnyObject) {
        Service().getFriends()
        refresh.endRefreshing()
    }
    
    func pairTableViewWithRealm() {
        friends = realm.objects(RealmUser.self)
        token = friends?.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self.tableView.reloadData()
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                self.tableView.deleteRows(at: deletions.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                self.tableView.reloadRows(at: modifications.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                self.tableView.endUpdates()
            case .error(let error):
                print(error)
            }
        }
    }
}
