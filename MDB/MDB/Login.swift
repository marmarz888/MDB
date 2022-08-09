//
//  ViewController.swift
//  MDB
//
//  Created by Mariano Manuel on 7/26/22.
//

import UIKit

class Login: UIViewController {
    
    var rootVC = UIViewController()
    var navVC = UINavigationController()
    var appTitle = UILabel()
    var username = UITextField()
    var password = UITextField()
    var loginButton = UIButton()
    var loginSuccess = Bool()
    var PopularMovies: [Movie] = []
    var TopRatedMovies: [Movie] = []
    let movieService = MovieService()
    var loaded1: Bool = false
    var loaded2: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Cover Image")!)
        setUpUIView()
        self.setupToHideKeyboardOnTapOnView()
        configMovieDB()
    }
    
    func setUpUIView() {
        appTitle = UILabel(frame: CGRect(x: 30, y: 200, width: 300, height: 100))
        appTitle.textColor = .black
        appTitle.text = "The Movie DB"
        appTitle.font = UIFont(name: "AmericanTypewriter", size: 30)
        self.view.addSubview(appTitle)
        
        username =  UITextField(frame: CGRect(x: 30, y: 300, width: 300, height: 40))
        username.placeholder = "Username"
        username.font = UIFont.systemFont(ofSize: 15)
        username.borderStyle = UITextField.BorderStyle.roundedRect
        username.autocorrectionType = UITextAutocorrectionType.no
        username.keyboardType = UIKeyboardType.default
        username.returnKeyType = UIReturnKeyType.done
        username.clearButtonMode = UITextField.ViewMode.whileEditing
        username.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        username.delegate = self
        self.view.addSubview(username)
        
        password =  UITextField(frame: CGRect(x: 30, y: 400, width: 300, height: 40))
        password.isSecureTextEntry = true
        password.placeholder = "Password"
        password.font = UIFont.systemFont(ofSize: 15)
        password.borderStyle = UITextField.BorderStyle.roundedRect
        password.autocorrectionType = UITextAutocorrectionType.no
        password.keyboardType = UIKeyboardType.default
        password.returnKeyType = UIReturnKeyType.done
        password.clearButtonMode = UITextField.ViewMode.whileEditing
        password.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        password.delegate = self
        self.view.addSubview(password)
        
        loginButton = UIButton(frame: CGRect(x: 30, y: 500, width: 300, height: 40))
        loginButton.setTitle("Login", for: .normal)
        let config = UIButton.Configuration.filled()
        loginButton.configuration = config
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        self.view.addSubview(loginButton)

        //Constraints
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        var horizontalConstraint = NSLayoutConstraint(item: appTitle, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        var verticalConstraint = NSLayoutConstraint(item: appTitle, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -250)
        var widthConstraint = NSLayoutConstraint(item: appTitle, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        var heightConstraint = NSLayoutConstraint(item: appTitle, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        username.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: username, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: username, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -50)
        widthConstraint = NSLayoutConstraint(item: username, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        heightConstraint = NSLayoutConstraint(item: username, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        password.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: password, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: password, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        widthConstraint = NSLayoutConstraint(item: password, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        heightConstraint = NSLayoutConstraint(item: password, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 150)
        widthConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        heightConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    @objc func login() {
        print("LOGIN")
        //Check Connection and Creds
        loginSuccess = false
        let network = Network()
        if username.text == "admin" && password.text == "password" && network.isConnected {
            loginSuccess = true
        }
        
        //Display Login Success/Fail
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        indicator.center = view.center
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        indicator.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 30.0, repeats: false) { (_) in
            indicator.stopAnimating()
            if !self.loaded1 && !self.loaded2 {
                self.loginSuccess = false
            }
            if self.loginSuccess {
                let alert = UIAlertController(title: "Success", message: "You can now browse movies!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    //Open Browser
                    self.rootVC = Listings(popularMovies: self.PopularMovies, topRatedMovies: self.TopRatedMovies)
                    self.navVC = UINavigationController(rootViewController: self.rootVC)
                    self.navVC.modalPresentationStyle = .fullScreen
                    self.present(self.navVC, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Failure", message: "Check Connection and Credentials", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    //Do Nothing
                    exit(-1)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func configMovieDB() {
        movieService.LoadMovieDatabaseAPI(taskNumber: 1) { (Info1) in
            print("Popular")
            if let Info1 = Info1 {
                DispatchQueue.global().async {
                    for i in 0..<Info1.count {
                        let movie = Info1[i] as! [String: Any]
                        let poster_path = movie["poster_path"] as! String
                        let movieTitle = movie["title"] as! String
                        let movieReleaseDate = movie["release_date"] as! String
                        let movieOverview = movie["overview"] as! String
                        let movieRating = movie["vote_average"] as! Double
                        let rating = String(movieRating)
                        let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                        let imageURL = URL(string: strURL)!
                        do {
                            let imageData = try Data(contentsOf: imageURL)
                            self.PopularMovies.append(Movie(movieTitle: movieTitle, posterImage: imageData, releaseDate: movieReleaseDate, rating: rating, details: movieOverview))
                        } catch  {
                            print(error)
                        }
                    }
                    self.loaded1 = true
                    print(self.PopularMovies.count)
                }
            }
        }
        
        movieService.LoadMovieDatabaseAPI(taskNumber: 2) { Info2 in
            print("Top Rated")
            if let Info2 = Info2 {
                DispatchQueue.global().async {
                    for i in 0..<Info2.count {
                        let movie = Info2[i] as! [String: Any]
                        let poster_path = movie["poster_path"] as! String
                        let movieTitle = movie["title"] as! String
                        let movieReleaseDate = movie["release_date"] as! String
                        let movieOverview = movie["overview"] as! String
                        let movieRating = movie["vote_average"] as! Double
                        let rating = String(movieRating)
                        let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                        let imageURL = URL(string: strURL)!
                        do {
                            let imageData = try Data(contentsOf: imageURL)
                            self.TopRatedMovies.append(Movie(movieTitle: movieTitle, posterImage: imageData, releaseDate: movieReleaseDate, rating: rating, details: movieOverview))
                        } catch  {
                            print(error)
                        }
                    }
                    self.loaded2 = true
                    print(self.TopRatedMovies.count)
                }
            }
        }
    }
}

extension Login: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        textField.resignFirstResponder()
        return true
    }

    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

