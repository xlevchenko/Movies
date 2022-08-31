//
//  MoviesViewController.swift
//  Movies
//
//  Created by Olexsii Levchenko on 8/31/22.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var titleMovie: UITextField!
    @IBOutlet weak var yearMovie: UITextField!
    @IBOutlet weak var tableView: UITableView!
        
    var moviesArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    
    @IBAction func addMovie(_ sender: Any) {
        if let title = titleMovie.text, let year = yearMovie.text, !title.isEmpty {
            self.moviesArray.insert("\(title) \(year)", at: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            tableView.endUpdates()
            
            titleMovie.text = nil
            yearMovie.text = nil
        }
    }
}


extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = moviesArray[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
}
