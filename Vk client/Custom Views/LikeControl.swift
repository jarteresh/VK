//
//  LikeControl.swift
//  Vk client
//
//  Created by Ярослав on 12.02.2023.
//

import UIKit

class LikeControl: UIControl {
    
    @IBOutlet weak var likesNumber: UILabel!

    @IBOutlet weak var likeImage: UIImageView!
    
    var likesCounter: Int = 0
    
    var controlSelected: Bool = false
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(update(sender:)), for: .touchUpInside)
    }

    @objc func update(sender: UIControl) {
        guard let label = likesNumber, let imageView = likeImage else {return}
        
        controlSelected = !controlSelected
        imageView.image = controlSelected ? UIImage(named: "HeartFilled") : UIImage(named: "HeartOutlined")
        likesCounter = controlSelected ? 1 : 0
        label.text = String(likesCounter)
    }
}
