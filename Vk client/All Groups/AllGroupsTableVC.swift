//
//  AllGroupsTableVC.swift
//  Vk client
//
//  Created by Ярослав on 03.02.2023.
//

import UIKit

class AllGroupsTableVC: UITableViewController {
    
    private var displayedGroups: [Group]? = nil
    
    private let reuseIdentifier = "AllGroupsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AllGroupsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        Service().getGroupsBySearch(forName: "Apple") { data in
            self.displayedGroups = data.response.items
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let groups = displayedGroups{
            return groups.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AllGroupsTableViewCell
        
        guard let groups = displayedGroups else {return cell}
        let group = groups[indexPath.row]
        
        Service().getPhoto(fromUrl: group.avatar) { groupPhoto in
            DispatchQueue.main.async {
                cell.avatar.image = groupPhoto
            }
        }
        
        cell.name.text = group.name
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "followGroup", sender: indexPath)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "followGroup",
//              let followedGroupsTableVC = segue.destination as? FollowedGroupsTableVC,
//              let indexPath = sender as? IndexPath
//        else {return}
//        let group = displayedGroups[indexPath.row]
//        if !followedGroupsTableVC.followedGroups.contains(group) {
//            followedGroupsTableVC.followedGroups.append(group)
//            followedGroupsTableVC.tableView.reloadData()
//        }
//
//        let index = groupsList.firstIndex(of: group) ?? 0
//        groupsList[index].isSubscribed = true
//        updateDisplayedGroups()
//        tableView.reloadData()
//    }
}
