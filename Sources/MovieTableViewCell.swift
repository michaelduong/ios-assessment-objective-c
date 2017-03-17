//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Nick Reichard on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Properties 
    
    var movies: NLRMovie? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Update Pattern 
    
    func updateViews() {
        guard let movie = self.movies else { return }
        self.movieNameLabel.text = movie.title
        self.ratingLabel.text = "Rating: \(movie.rating)"
        self.descriptionTextView.text = movie.overview
        
        NLRMovieController.shared().fetchMoviePosterImage(movie.posterImage) { (image) in
            
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }
    }
    
    // MARK: - Outlets

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!

}
