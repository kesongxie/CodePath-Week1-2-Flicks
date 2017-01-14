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
    public static let titleKey = "title"
    public static let overviewKey = "overview"

    public static let APIKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    public static let nowPlayingURLString = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(APIKey)&language=en-US&page=1"
    public static let topRatedURLString = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(APIKey)&language=en-US&page=1"
    public static let posterBaseUrl = "http://image.tmdb.org/t/p/"
    public static let lowerResolutionSuffix = "w500"
    public static let higherResolutionSuffix = "original"
    public static let requestTimeoutInterval: Double = 6.0
    
    public static func sendRequest(urlString: String, _ completionHandler: @escaping ([[String: Any]]?, Error?) -> Void ){
        let urlSession = URLSession(configuration: .default)
        if let url = URL(string: urlString){
            let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: requestTimeoutInterval)
            urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard error == nil else{
                    completionHandler(nil, error)
                    return
                }
                if let data = data{
                    guard let responseJason = try? JSONSerialization.jsonObject(with: data, options: []) else{
                        print("Can't serialize data")
                        return
                    }
                    if let responseDict = responseJason as? [String: Any]{
                        if let movieDictResult = responseDict[FlickHttpRequest.responseResultsKey] as? [[String: Any]]{
                            completionHandler(movieDictResult, nil)
                        }
                    }
                }
            }).resume()
        }
    }
    
      
    
}
