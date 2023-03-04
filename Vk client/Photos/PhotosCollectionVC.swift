//
//  PhotosCollectionVC.swift
//  Vk client
//
//  Created by Ярослав on 02.02.2023.
//

import UIKit
import RealmSwift
import SDWebImageSwiftUI

private let reuseIdentifier = "PhotosCell"

class PhotosCollectionVC: UICollectionViewController {
    
    var userId: Int = 0
    var userPhotos: Results<RealmPhoto>?
    let realm = try! Realm()
    var token: NotificationToken?
    let refresh = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        pairCollectionViewWithRealm()
        Service().getPhotos(forUser: userId)
        refresh.addTarget(self, action: #selector(updateCollectonView(_ :)), for: .valueChanged)
        collectionView.addSubview(refresh)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotosCollectionViewCell
        guard let photos = userPhotos else {return cell}
        
        cell.photo.sd_setImage(with: URL(string: photos[indexPath.row].url))
        return cell
    }
    
    @objc func updateCollectonView(_ sender: AnyObject) {
        Service().getPhotos(forUser: userId)
        refresh.endRefreshing()
    }
    
    func pairCollectionViewWithRealm() {
        userPhotos = realm.objects(RealmPhoto.self).where {
            $0.ownerId == self.userId
        }
        
        token = userPhotos?.observe { (changes: RealmCollectionChange) in
             switch changes {
             case .initial:
                 self.collectionView.reloadData()
             case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                 self.collectionView.performBatchUpdates({
                     self.collectionView.insertItems(at: insertions.map({IndexPath(row: $0, section: 0)}))
                     self.collectionView.deleteItems(at: deletions.map({IndexPath(row: $0, section: 0)}))
                     self.collectionView.reloadItems(at: modifications.map({IndexPath(row: $0, section: 0)}))
                 })
             case .error(let error):
                 print(error)
             }
         }
    }
}
