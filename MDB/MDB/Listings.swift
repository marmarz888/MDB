//
//  Listings.swift
//  MDB
//
//  Created by Mariano Manuel on 7/26/22.
//

import UIKit

class Listings: UIViewController {
    
    var barButton = UIBarButtonItem()
    private let popularMovies: [Movie]
    private let topRatedMovies: [Movie]
    
    init(popularMovies: [Movie], topRatedMovies: [Movie]) {
        self.popularMovies = popularMovies
        self.topRatedMovies = topRatedMovies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var segmentedButtonsView: SegmentedButtonsView = {
        
       let segmentedButtonsView = SegmentedButtonsView()
        
        segmentedButtonsView.setLabelsTitles(titles: ["Popular", "Top Rated"])
        segmentedButtonsView.translatesAutoresizingMaskIntoConstraints = false
        segmentedButtonsView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        segmentedButtonsView.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1).cgColor
        segmentedButtonsView.layer.borderWidth = 0.5
        
        return segmentedButtonsView
        
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumInteritemSpacing = 1
        collectionViewFlowLayout.minimumLineSpacing = 1
     
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.isPagingEnabled = true
   
        collectionView.indicatorStyle = .white
        return collectionView
    }()
    
    let genres = ["Popular", "Top Rated"]
    
    weak var delegate: CollectionViewDidScrollDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The Movie DB"
        barButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(seeFavorites))
        self.navigationItem.rightBarButtonItem  = barButton
        view.backgroundColor = .systemRed
        configCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configNavigationItem()
    }
 
    private func configCollectionView(){
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        segmentedButtonsView.segmentedControlDelegate = self
        view.addSubview(segmentedButtonsView)
        
        segmentedButtonsView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        segmentedButtonsView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        segmentedButtonsView.topAnchor.constraint(equalTo: view.topAnchor,constant: 86).isActive = true

        segmentedButtonsView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: segmentedButtonsView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.backgroundColor = .systemRed
        
    }
    
    private func configNavigationItem(){
        //remove bottom-border of nav bar
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func seeFavorites() {
        let favorites = Favorites()
        navigationController?.pushViewController(favorites, animated: true)
    }
    

}

extension Listings: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else{
            fatalError("could not load \(CustomCollectionViewCell.self)") }
        cell.navVC = navigationController!
        if indexPath.row == 0 {
            cell.segmentIndex = 0
            cell.popular = popularMovies
        } else if indexPath.row == 1 {
            cell.segmentIndex = 1
            cell.topRated = topRatedMovies
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height -  100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate = segmentedButtonsView
        delegate?.collectionViewDidScroll(for: scrollView.contentOffset.x / 2)
        print("Movie Type: \(segmentedButtonsView.selectedIndex)")
    }
    
    func scrollToFrame(scrollOffset : CGFloat) {
                guard scrollOffset <= collectionView.contentSize.width - collectionView.bounds.size.width else { return }
                guard scrollOffset >= 0 else { return }
        collectionView.setContentOffset(CGPoint(x: scrollOffset, y: collectionView.contentOffset.y), animated: true)
        
    }
}

extension Listings: SegmentedControlDelegate {
    
    func didIndexChanged(at index: Int) {
       
        if index == 0 {
            // scroll forward
            let collectionBounds = self.collectionView.bounds
            let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
            self.moveToFrame(contentOffset: contentOffset)
            
        }else if index == 1 {
            // scroll backward
            let collectionBounds = self.collectionView.bounds
            let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
            self.moveToFrame(contentOffset: contentOffset)
        }
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
   
}
