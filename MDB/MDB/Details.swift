//
//  Details.swift
//  MDB
//
//  Created by Mariano Manuel on 8/4/22.
//

import UIKit

class Details: UIViewController {

    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var movieTitle = UILabel()
    var posterImage = UIImageView()
    var releaseDate = UILabel()
    var rating = UILabel()
    var overview = UILabel()
    var details = UILabel()
    var barButton = UIBarButtonItem()
    private let movie: Movie
    private let isFavorite: Bool
    
    init(movie: Movie, isFavorite: Bool) {
        self.movie = movie
        self.isFavorite = isFavorite
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUIView()
    }
    
    func setUpUIView() {
        if !isFavorite {
            barButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(addToFavorites))
            self.navigationItem.rightBarButtonItem  = barButton
        }
        
        movieTitle = UILabel(frame: CGRect(x: 30, y: 200, width: 300, height: 100))
        movieTitle.textColor = .black
        movieTitle.text = movie.movieTitle
        movieTitle.font = UIFont(name: "AmericanTypewriter", size: 20)
        self.view.addSubview(movieTitle)
        
        posterImage = UIImageView(frame: CGRect(x: 30, y: 300, width: 100, height: 200))
        posterImage.image = UIImage(data: movie.posterImage)
        self.view.addSubview(posterImage)
        
        releaseDate = UILabel(frame: CGRect(x: 30, y: 500, width: 100, height: 100))
        releaseDate.textColor = .black
        releaseDate.text = "Release: \(movie.releaseDate)"
        releaseDate.font = UIFont(name: "AmericanTypewriter", size: 10)
        self.view.addSubview(releaseDate)
        
        rating = UILabel(frame: CGRect(x: 150, y: 500, width: 50, height: 100))
        rating.textColor = .black
        rating.text = "Rating: \(movie.rating)"
        rating.font = UIFont(name: "AmericanTypewriter", size: 10)
        self.view.addSubview(rating)
        
        overview = UILabel(frame: CGRect(x: 30, y: 600, width: 300, height: 100))
        overview.textColor = .black
        overview.text = "Overview:"
        overview.font = UIFont(name: "AmericanTypewriter", size: 20)
        self.view.addSubview(overview)
        
        details = UILabel(frame: CGRect(x: 30, y: 700, width: 300, height: 300))
        details.textColor = .black
        details.text = movie.details
        details.numberOfLines = 0
        details.font = UIFont(name: "AmericanTypewriter", size: 10)
        self.view.addSubview(details)
        

        //Constraints
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        var horizontalConstraint = NSLayoutConstraint(item: movieTitle, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        var verticalConstraint = NSLayoutConstraint(item: movieTitle, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -250)
        var widthConstraint = NSLayoutConstraint(item: movieTitle, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        var heightConstraint = NSLayoutConstraint(item: movieTitle, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: posterImage, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: posterImage, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -100)
        widthConstraint = NSLayoutConstraint(item: posterImage, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        heightConstraint = NSLayoutConstraint(item: posterImage, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: releaseDate, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: -100)
        verticalConstraint = NSLayoutConstraint(item: releaseDate, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 100)
        widthConstraint = NSLayoutConstraint(item: releaseDate, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        heightConstraint = NSLayoutConstraint(item: releaseDate, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        rating.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: rating, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 150)
        verticalConstraint = NSLayoutConstraint(item: rating, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 100)
        widthConstraint = NSLayoutConstraint(item: rating, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        heightConstraint = NSLayoutConstraint(item: rating, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        overview.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: overview, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: overview, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 150)
        widthConstraint = NSLayoutConstraint(item: overview, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        heightConstraint = NSLayoutConstraint(item: overview, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        details.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: details, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: details, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 222)
        widthConstraint = NSLayoutConstraint(item: details, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        heightConstraint = NSLayoutConstraint(item: details, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }

    @objc func addToFavorites() {
        barButton.image = UIImage(systemName: "star.fill")
        let newMovie = DBMovie(context: viewContext)
        newMovie.title = movie.movieTitle
        newMovie.poster = movie.posterImage
        newMovie.date = movie.releaseDate
        newMovie.rating = movie.rating
        newMovie.overview = movie.details
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}
