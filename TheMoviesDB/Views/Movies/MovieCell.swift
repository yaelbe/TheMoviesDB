//
//  MoviesViewController.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit
import Nuke

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    static let identifier: String = "MovieCell"
   
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        releaseYearLabel.layer.borderColor = UIColor(white: 151.0 / 255.0, alpha: 1.0).cgColor
        releaseYearLabel.layer.borderWidth = 0.5
        releaseYearLabel.layer.cornerRadius = 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        nameLabel.text = nil
        overviewLabel.text = nil
        releaseYearLabel.text = nil
        ratingLabel.text = nil
        contentView.backgroundColor = UIColor.systemBackground
    }
    
    func configure(with movie: Movie, and genre:MovieGenre) {
        nameLabel.text = movie.title
        overviewLabel.text = movie.overview
        contentView.backgroundColor = (movie.genres?.contains(genre.id) ?? false) ? UIColor.systemGray5: UIColor.systemBackground
        releaseYearLabel.text = movie.publishYear
        ratingLabel.text = movie.rating
        
        if let imageUrl = movie.posterImageUrl{
            Nuke.loadImage(with:imageUrl, options: ImageLoadingOptions(
                transition: .fadeIn(duration: 0.2)
            ), into: posterImageView)
        }
        
       
    }
}
