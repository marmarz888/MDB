//
//  CustomCollectionViewCell2.swift
//  MDB
//
//  Created by Mariano Manuel on 7/27/22.
//

import UIKit

class CustomCollectionViewCell2: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell2"
    
    var navigationVC = UINavigationController()
    
    var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark.app")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemRed
        image.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        contentView.addSubview(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
