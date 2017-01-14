//
//  TopRatedTableViewCell.swift
//  Flicks
//
//  Created by Xie kesong on 1/14/17.
//  Copyright © 2017 ___KesongXie___. All rights reserved.
//

import UIKit

class TopRatedTableViewCell: UITableViewCell {
    var movie: [String: Any]?{
        didSet{
            self.loadImage()
            self.setMovieTitle()
            self.setMovieOverview()
        }
    }
    
    @IBOutlet weak var moviePosterImageView: UIImageView!{
        didSet{
            moviePosterImageView.layer.cornerRadius = 4.0
            moviePosterImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var movieTitleLabel: UILabel!

    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadImage(){
        self.moviePosterImageView.loadMoviePoster(movie: self.movie!)
    }
    
    func setMovieTitle(){
        self.movieTitleLabel.setMovieTitle(movie: self.movie!)
    }
    
    
    func setMovieOverview(){
        self.movieOverviewLabel.setMovieOverview(movie: self.movie!)
    }
    


}
