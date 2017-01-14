//
//  MovieCollectionViewCell.swift
//  Flicks
//
//  Created by Xie kesong on 1/10/17.
//  Copyright © 2017 ___KesongXie___. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    var movie: [String: Any]?{
        didSet{
            self.loadMoviePoster()
        }
    }

    func loadMoviePoster(){
        self.moviePosterImageView.loadMoviePoster(movie: self.movie!)
    }
}

