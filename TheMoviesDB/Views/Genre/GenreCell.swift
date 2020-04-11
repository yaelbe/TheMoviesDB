//
//  GenreCell.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit
import Foundation

class GenreCell:UICollectionViewCell{
    
    static let identifier: String = "GenreCell"
    static var nib: UINib {
           return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
    
    @IBOutlet weak var genreTitle: UILabel!
    
    var genre: MovieGenre! {
        didSet{
            self.genreTitle.text   = genre.name
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.genreTitle.text = nil
        self.contentView.layer.backgroundColor = UIColor.systemBackground.cgColor
    }
    
    override var isSelected: Bool {
        didSet {
            self.contentView.layer.backgroundColor = isSelected ? UIColor.systemGray5.cgColor : UIColor.systemBackground.cgColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderColor = genreTitle.textColor.cgColor
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.cornerRadius = 5
    }
}


