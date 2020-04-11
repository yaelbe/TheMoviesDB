//
//  MovieDetailsViewControiier.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit
import Nuke


class MovieDetailsViewControiier :UIViewController{
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var overview: UITextView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var trailersView: UIView!
    private static let SegueToMovies = "MoviesVideoSegue"
    var movie : Movie!
    
    private var videos:[MovieVideo]?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.title ?? ""
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        trailersView.addGestureRecognizer(tap)
        
        prepareBorder()
        ratingLabel.text = movie.rating
        
        if let imageUrl = movie.posterImageUrl{
            Nuke.loadImage(with:imageUrl, options: ImageLoadingOptions(
                transition: .fadeIn(duration: 0.2)
            ), into: poster)
        }
        
        date.text = movie.formatedDate
        overview.text = movie.overview
        
    }
    private func prepareBorder(){
        borderView.layer.borderColor  = UIColor.systemBlue.cgColor
        borderView.layer.borderWidth  = 2
        borderView.layer.cornerRadius  = 5
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        performSegue(withIdentifier: MovieDetailsViewControiier.SegueToMovies, sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MovieDetailsViewControiier.SegueToMovies {
            if let videosVC = segue.destination as? MovieVideosViecController{
                let model = VideoViewModel()
                model.videoId = self.movie.id
                videosVC.viewModel = model
                videosVC.movie = self.movie
            }
        }
    }
}

