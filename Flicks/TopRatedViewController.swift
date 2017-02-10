//
//  TopRatedViewController.swift
//  Flicks
//
//  Created by Xie kesong on 1/14/17.
//  Copyright © 2017 ___KesongXie___. All rights reserved.
//

import UIKit

fileprivate let reuseIden = "TopRatedCell"
fileprivate let showDetailSegueIden = "ShowDetail"

class TopRatedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var offlineErrorView: UIView!
    let refreshControl = UIRefreshControl()

    var movieDict: [[String: Any]]?{
        didSet{
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.loadingView.isHidden = true
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(self.refreshControlDragged(sender:)), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.offlineViewTapped(tap:)))
        self.offlineErrorView.addGestureRecognizer(tapGesture)
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -self.tableView.tableFooterView!.frame.size.height, right: 0)
        //network request
        self.loadMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func refreshControlDragged(sender: UIRefreshControl){
        self.loadMovies()
    }
    
    func offlineViewTapped(tap: UITapGestureRecognizer){
        self.offlineErrorView.isHidden = true
        self.loadMovies()
    }
    
    private func loadMovies(){
        self.activityIndicator.startAnimating()
        FlickHttpRequest.sendRequest(urlString: FlickHttpRequest.topRatedURLString) { (movieDictResult, error) in
            if error == nil{
                self.offlineErrorView.isHidden = true
                self.movieDict = movieDictResult
            }else{
                self.offlineErrorView.isHidden = false
            }
        }
    }

  
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier{
            if identifier == showDetailSegueIden{
                if let detailVc = segue.destination as? DetailViewController{
                    if let selectedIndexPathRow = self.tableView.indexPathForSelectedRow?.row{
                        detailVc.movie = self.movieDict![selectedIndexPathRow]
                    }
                }
            }
        }
        
    }
    


}


extension TopRatedViewController:  UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieDict?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIden, for: indexPath) as! TopRatedTableViewCell
        cell.movie = self.movieDict![indexPath.row];
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        return cell
    }

}


