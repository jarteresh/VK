//
//  FollowedGroupsTableVC.swift
//  Vk client
//
//  Created by Ярослав on 03.02.2023.
//

import UIKit
import RealmSwift

class FollowedGroupsTableVC: UITableViewController {
    
    var followedGroups: [RealmGroup]? = nil
    let realm = try! Realm()
    let refresh = UIRefreshControl()
    
    private let reuseIdentifier = "FollowedGroupsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FollowedGroupsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        if let groups = realm.objects(RealmGroups.self).first?.groups {
            followedGroups = Array(groups)
        }
        refresh.addTarget(self, action: #selector(update(_ :)), for: .valueChanged)
        tableView.addSubview(refresh)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let groups = followedGroups {
            return groups.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FollowedGroupsTableViewCell
        
        guard let groups = followedGroups else {return cell}
        let group = groups[indexPath.row]
        
        Service().getPhoto(fromUrl: group.avatar) { groupPhoto in
            DispatchQueue.main.async {
                cell.avatar.image = groupPhoto
            }
        }
        
        cell.name.text = group.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            followedGroups?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @objc func update(_ sender: AnyObject) {
        Service().getGroups {
            if let groups = self.realm.objects(RealmGroups.self).first?.groups {
                self.followedGroups = Array(groups)
            }
            self.tableView.reloadData()
        }
        refresh.endRefreshing()
    }
}
