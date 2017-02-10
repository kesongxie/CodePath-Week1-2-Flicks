//
//  DetailViewController.swift
//  Flicks
//
//  Created by Xie kesong on 1/14/17.
//  Copyright © 2017 ___KesongXie___. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var posterLargeImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    @IBOutlet weak var posterImageViewHeightConstraint: NSLayoutConstraint!
    var movie: [String: Any]?
    
    var posterImageViewOriginHeight: CGFloat = 0
    
    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        let scaleTransfrom = CGAffineTransform(scaleX: 2.0, y: 2.0)
         self.posterLargeImageView.transform = scaleTransfrom
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            self.posterLargeImageView.transform = .identity
        }, completion: nil)
        
        if movie != nil{
            self.loadPoster()
            self.setMovieTitle()
            self.setMovieOverView()
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.posterImageViewHeightConstraint.constant = self.posterLargeImageView.frame.size.height
        self.posterImageViewOriginHeight = self.posterLargeImageView.frame.size.height

    }
    
    func loadPoster(){
        self.posterLargeImageView?.loadMoviePoster(movie: self.movie!, loadingOption: .LowToHigherResolution)
    }
    
    func setMovieTitle(){
        self.movieTitleLabel?.setMovieTitle(movie: self.movie!)
    }
    
    func setMovieOverView(){
        self.movieOverviewLabel?.setMovieOverview(movie: self.movie!)

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }

}


extension DetailViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.scrollView.contentOffset.y < 0){
            self.topSpaceConstraint.constant = self.scrollView.contentOffset.y
            self.posterImageViewHeightConstraint.constant = self.posterImageViewOriginHeight - self.scrollView.contentOffset.y
        }
    }
}
