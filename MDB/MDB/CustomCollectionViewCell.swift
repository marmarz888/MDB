//
//  CustomCollectionViewCell.swift
//  MDB
//
//  Created by Mariano Manuel on 7/26/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    var navVC = UINavigationController()
    var popular: [Movie] = []
    var topRated: [Movie] = []
    var segmentIndex = 0
    
    lazy var collectionView: UICollectionView = {
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.itemSize = CGSize(width: (contentView.frame.size.width)/2, height: (contentView.frame.size.height)/2)
     
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(CustomCollectionViewCell2.self, forCellWithReuseIdentifier: CustomCollectionViewCell2.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
   
        collectionView.indicatorStyle = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemRed
        collectionView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        collectionView.backgroundColor = .systemRed
        contentView.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCollectionViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell2.identifier, for: indexPath) as? CustomCollectionViewCell2 else{
            fatalError("could not load \(CustomCollectionViewCell2.self)") }
        cell.navigationVC = navVC
        if segmentIndex == 0 {
            let imageData = popular[indexPath.row].posterImage
            cell.image.image = UIImage(data: imageData)
        } else if segmentIndex == 1 {
            let imageData = topRated[indexPath.row].posterImage
            cell.image.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if segmentIndex == 0 {
            let vc = Details(movie: popular[indexPath.row], isFavorite: false)
            navVC.pushViewController(vc, animated: true)
        } else if segmentIndex == 1 {
            let vc = Details(movie: topRated[indexPath.row], isFavorite: false)
            navVC.pushViewController(vc, animated: true)
        }
    }
    
}
