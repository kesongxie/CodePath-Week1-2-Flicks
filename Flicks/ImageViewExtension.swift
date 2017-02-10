//
//  ImageViewExtension.swift
//  Flicks
//
//  Created by Xie kesong on 1/14/17.
//  Copyright © 2017 ___KesongXie___. All rights reserved.
//

import Foundation
import UIKit

enum PosterLoadingOption{
    case LowToHigherResolution
    case Default
}

extension UIImageView{
    func loadMoviePoster(movie: [String: Any], loadingOption: PosterLoadingOption = PosterLoadingOption.Default){
        if let posterPath = movie[FlickHttpRequest.posterPathKey] as? String{
            let lowerResolutionRequstURL = FlickHttpRequest.posterBaseUrl + FlickHttpRequest.lowerResolutionSuffix + posterPath
            if let posterURL = URL(string: lowerResolutionRequstURL){
                let urlRequest = URLRequest(url: posterURL)
                
                self.setImageWith(urlRequest, placeholderImage: nil, success: { (request, response, image) in
                    if(response == nil){
                        //from cache
                        self.image = image
                    }else{
                        self.alpha = 0.0
                        self.image = image
                        UIView.animate(withDuration: 0.3, animations: {
                            self.alpha = 1.0
                        }, completion:{ finished in
                            if finished{
                                if(loadingOption == .LowToHigherResolution){
                                    //load the higehr resolution
                                    let higherResolutionRequstURL = FlickHttpRequest.posterBaseUrl + FlickHttpRequest.higherResolutionSuffix + posterPath
                                    if let posterURL = URL(string: higherResolutionRequstURL){
                                        let urlRequest = URLRequest(url: posterURL)
                                        self.setImageWith(urlRequest, placeholderImage: nil, success: { (request, response, image) in
                                            if response != nil{
                                                self.image = image
                                            }
                                        })
                                    }
                                }
                            }
                        })
                    }
                }, failure: {
                    (request, response, error) in
                    print(error.localizedDescription)
                })
                
            }
        }

    }

}
