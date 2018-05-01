//
//  MovieTableViewCell.swift
//  Movie Search ObjC
//
//  Created by Michael Duong on 2/16/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieSummary: UITextView!
    
    var movie: TRLMovie? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        
        DispatchQueue.main.async {
            self.movieTitle.text = movie.title
            self.movieRating.text = "\(movie.rating)"
            self.movieSummary.text = movie.overview
        }
    }

}
