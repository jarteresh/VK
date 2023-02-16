//
//  FollowedGroupsTableVC.swift
//  Vk client
//
//  Created by Ярослав on 03.02.2023.
//

import UIKit

class FollowedGroupsTableVC: UITableViewController {
    
    var followedGroups: [Group]? = nil
    
    private let reuseIdentifier = "FollowedGroupsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FollowedGroupsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        Service().getGroups { data in
            self.followedGroups = data.groups
            self.tableView.reloadData()
        }
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
}
