//
//  HttpRequest.swift
//  Flicks
//
//  Created by Xie kesong on 1/10/17.
//  Copyright © 2017 ___KesongXie___. All rights reserved.
//

import Foundation

class FlickHttpRequest{
    public static let responseResultsKey = "results"
    public static let posterPathKey = "poster_path"
    public static let nowPlayingURLString = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1"
    public static let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
}
