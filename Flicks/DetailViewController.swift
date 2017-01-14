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
    
    var movie: [String: Any]?
    
    var posterImageViewOriginHeight: CGFloat = 0
    
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        if movie != nil{
            self.loadPoster()
            self.setMovieTitle()
            self.setMovieOverView()
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLayoutSubviews() {
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
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


extension DetailViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.scrollView.contentOffset.y < 0){
            self.posterLargeImageView.frame.origin.y = self.scrollView.contentOffset.y
            self.posterLargeImageView.frame.size.height = self.posterImageViewOriginHeight - self.scrollView.contentOffset.y
        }
    }
}
