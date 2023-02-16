//
//  PhotosCollectionVC.swift
//  Vk client
//
//  Created by Ярослав on 02.02.2023.
//

import UIKit

private let reuseIdentifier = "PhotosCell"

class PhotosCollectionVC: UICollectionViewController {
    
    var userId: Int = 0
    var userPhotos: [Photo]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        Service().getPhotos(forUser: userId) { data in
            self.userPhotos = data.photos
            self.collectionView.reloadData()
        }

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photos = userPhotos {
            return photos.count
        } else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotosCollectionViewCell
        guard let photos = userPhotos else {return cell}
        
        Service().getPhoto(fromUrl: photos[indexPath.row].url) { friendPhoto in
            DispatchQueue.main.async {
                cell.photo.image = friendPhoto
            }
        }
        
        return cell
    }
}
