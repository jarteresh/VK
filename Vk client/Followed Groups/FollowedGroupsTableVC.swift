//
//  FollowedGroupsTableVC.swift
//  Vk client
//
//  Created by Ярослав on 03.02.2023.
//

import UIKit
import RealmSwift
import SDWebImageSwiftUI

class FollowedGroupsTableVC: UITableViewController {
    
    var followedGroups: Results<RealmGroup>?
    let realm = try! Realm()
    let refresh = UIRefreshControl()
    var token: NotificationToken?
    
    private let reuseIdentifier = "FollowedGroupsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FollowedGroupsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        Service().getGroups()
        pairTableViewWithRealm()
        refresh.addTarget(self, action: #selector(updateTableView(_ :)), for: .valueChanged)
        tableView.addSubview(refresh)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followedGroups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FollowedGroupsTableViewCell
        
        guard let groups = followedGroups else {return cell}
        let group = groups[indexPath.row]
        
        cell.avatar.imageView.sd_setImage(with: URL(string: group.avatar))
        cell.name.text = group.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                 try realm.write {
                    realm.delete(followedGroups![indexPath.row])
                }
            } catch {
                print(error)
            }
        }
    }
    
    func pairTableViewWithRealm() {
        followedGroups = realm.objects(RealmGroup.self)
        token = followedGroups?.observe { (changes: RealmCollectionChange) in
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
    
    @objc func updateTableView(_ sender: AnyObject) {
        Service().getGroups()
        refresh.endRefreshing()
    }
}
