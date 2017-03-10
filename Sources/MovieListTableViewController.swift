//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Nick Reichard on 3/10/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SHOW TIME...search"
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text else { return }
        
        MovieController.fetchMovieInformationFromAPI(withTitle: searchTerm) { (newMovie) in
            DispatchQueue.main.async {
                self.movie = [newMovie]
            }
        }
    }
    
    // MARK: - Properties
    var movie: [Movie] = []
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = self.movie[indexPath.row]
        
        cell.movie = movie
        return cell
    }
    
    // MARK: - Navigation -- Use if you segue to another VC
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
