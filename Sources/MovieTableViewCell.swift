//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Nick Reichard on 3/10/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    
    // MARK: - Properties
    
    var movie: Movie? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        
        DispatchQueue.main.async {
            
        self.titleLabel.text = movie.title
        self.ratingLabel.text = "\(movie.rating)"
        self.overviewTextView.text = movie.overview
        // Image Conroller??
        }
    }
}
