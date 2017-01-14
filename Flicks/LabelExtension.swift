//
//  LabelExtension.swift
//  Flicks
//
//  Created by Xie kesong on 1/14/17.
//  Copyright © 2017 ___KesongXie___. All rights reserved.
//


import UIKit

extension UILabel{
    func setMovieTitle(movie: [String: Any]){
        self.text = movie[FlickHttpRequest.titleKey] as? String
    }
    
    func setMovieOverview(movie: [String: Any]){
        self.text = movie[FlickHttpRequest.overviewKey] as? String
    }

}
