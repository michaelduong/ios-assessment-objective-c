//
//  MovieListTableViewController.swift
//  Movie Search ObjC
//
//  Created by Michael Duong on 2/16/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    var movie: [TRLMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Search ObjC"
        movieSearchBar.delegate = self

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let input = searchBar.text else { return }
        searchBar.resignFirstResponder()
        let cleanedInput = input.replacingOccurrences(of: " ", with: "+")
        TRLMovieController.fetchMovieInfo(withTitle: cleanedInput) { (newMovie) in
            DispatchQueue.main.async {
                guard let newMovie = newMovie as? [TRLMovie] else { return }
                
                self.movie = newMovie
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movie.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }

        let movie = self.movie[indexPath.row]
        
        cell.movie = movie
        
        return cell
    }
 


}
