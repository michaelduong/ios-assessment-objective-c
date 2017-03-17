//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Nick Reichard on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var movies: [NLRMovie] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MOVIE TIME SEARCH"
        self.searchBar.delegate = self
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell () }
        
        let movie = movies[indexPath.row];
        
        cell.movies = movie
        
        return cell
    }
    
    // MARK: - Search
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        NLRMovieController.shared().fetchMovie(forSearchTerm: searchTerm) { (movies) in
            guard let movies = movies as? [NLRMovie] else { return }
            self.movies = movies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.searchBar.resignFirstResponder()
            }
        }
    }
}


