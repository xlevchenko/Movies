//
//  MoviesViewController.swift
//  Movies
//
//  Created by Olexsii Levchenko on 8/31/22.
//

import UIKit
import OrderedCollections

class MoviesViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var titleMovie: UITextField!
    @IBOutlet weak var yearMovie: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var duplicateLabel: UILabel!
    
    var moviesArray: OrderedSet<MoviesModel> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        hideKeyboardWhenTappedAround()
        
        let moviez = MoviesModel(name: "Sniper. The White Raven", year: 2021)
        moviesArray.append(moviez)
        
        duplicateLabel.isHidden = true
    }
    
    
    @IBAction func addMovie(_ sender: Any) {
        if let title = titleMovie.text, let year = yearMovie.text, !title.isEmpty, !year.isEmpty {
            let movie = MoviesModel(name: title, year: Int(year)!)
            
            if moviesArray.contains(where: { $0 == movie }) {
                duplicateLabel.isHidden = false
            } else {
                self.moviesArray.insert(movie, at: moviesArray.startIndex)
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                tableView.endUpdates()
                
                duplicateLabel.isHidden = true
                titleMovie.text = nil
                yearMovie.text = nil
            }
        }
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = moviesArray[indexPath.row].name
        content.secondaryText = String(moviesArray[indexPath.row].year)
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        moviesArray.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}
