//
//  SectionHeader.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation
import UIKit

class SectionHeader: UICollectionReusableView {
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.text = "First, select a genre"
        label.textColor = UIColor.systemBlue
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
