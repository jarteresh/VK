//
//  AvatarView.swift
//  Vk client
//
//  Created by Ярослав on 12.02.2023.
//

import UIKit

class AvatarView: UIView {
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            createShadowView()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.7 {
        didSet {
            createShadowView()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 8 {
        didSet {
            createShadowView()
        }
    }
    

    var image = UIImage() {
        didSet {
            createImageView()
        }
    }
    
    var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createShadowView()
        createImageView()
    }
    
    func createImageView() {
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.image = image
        self.addSubview(imageView)
    }
    
    func createShadowView() {
        let shadowView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        shadowView.layer.cornerRadius = 25
        shadowView.layer.backgroundColor = UIColor.black.cgColor
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.addSubview(shadowView)
    }
}
