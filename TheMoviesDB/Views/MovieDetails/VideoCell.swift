//
//  ViedoCell.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit
import Foundation

class VideoCell:UICollectionViewCell{
    
    static let identifier: String = "VideoCell"
    static var nib: UINib {
           return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
    
    @IBOutlet weak var videoTitle: UILabel!
    
    var video: MovieVideo! {
        didSet{
            self.videoTitle.text = video.name
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.videoTitle.text = nil
        self.contentView.layer.backgroundColor = UIColor.systemBackground.cgColor
    }
    
    override var isSelected: Bool {
        didSet {
            self.contentView.layer.backgroundColor = isSelected ? UIColor.systemGray5.cgColor : UIColor.systemBackground.cgColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let width = UIScreen.main.bounds.width - 30
        self.bounds = CGRect(x: 0, y: 0, width: width, height: width*0.2)
        self.contentView.layer.borderColor = videoTitle.textColor.cgColor
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.cornerRadius = 5
        self.videoTitle.numberOfLines = 0
        videoTitle.preferredMaxLayoutWidth = self.frame.size.width 
       
    }
}


