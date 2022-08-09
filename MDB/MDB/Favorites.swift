//
//  Favorites.swift
//  MDB
//
//  Created by Mariano Manuel on 8/4/22.
//

import UIKit

class Favorites: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var movies: [DBMovie] = []
    var barButton = UIBarButtonItem()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        view.backgroundColor = .white
        barButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.rightBarButtonItem  = barButton
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        fetchMovies()
    }
    
    func fetchMovies() {
        do {
            movies = try viewContext.fetch(DBMovie.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    @objc func logOut() {
        navigationController?.popToRootViewController(animated: true)
        if self.presentingViewController != nil {
            self.presentingViewController?.dismiss(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = movies[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dbMovie = movies[indexPath.row]
        let movie: Movie = Movie(movieTitle: dbMovie.title!, posterImage: dbMovie.poster!, releaseDate: dbMovie.date!, rating: dbMovie.rating!, details: dbMovie.overview!)
        let movieDetails = Details(movie: movie, isFavorite: true)
        navigationController?.pushViewController(movieDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let removeMovie = movies[indexPath.row]
            viewContext.delete(removeMovie)
            
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
            fetchMovies()
            tableView.reloadData()
        }
    }
}
