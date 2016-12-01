//
//  MoviesViewController.swift
//  enkodi
//
//  Created by Adrian on 19/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import SwiftyJSON

class MoviesViewController: BaseTableViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var movies = [BaseMovie]()
    
    override func viewDidLoad() {
        backgroundThread(background: refreshMovies)
    }
    
    override func viewDidDisappear(animated: Bool) {
        if let selectedIndex = moviesTableView.indexPathForSelectedRow {
            moviesTableView.deselectRowAtIndexPath(selectedIndex, animated: animated)
        }
    }
    
    private func refreshMovies() {
        let requestId = arc4random()
        WebSocketHelper.completionQueue[requestId] = receivedMovies
        requestFacade!.sendGetMovies(requestId)
    }
    
    private func receivedMovies(json: JSON) {
        let movies = Mapper<BaseMovie>().mapArray(json[JsonHelper.resultKey]["movies"].arrayObject)
        self.movies += movies!
        moviesTableView.reloadData()
    }

    // MARK: Table view methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "movieTableCell"
        let movie = movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieTableCell
        
        setCellSelectedBackground(cell)
        
        cell.titleLabel.text = movie.title
        
        return cell
    }
    
    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        let selectedIndex = tvShowsTableView.indexPathForSelectedRow?.row
//        let tvShowSeasonsViewController = segue.destinationViewController as! TvShowSeasonsViewController
//        tvShowSeasonsViewController.tvShow = tvShows[selectedIndex!]
    }

}