//
//  TvShowViewController.swift
//  enkodi
//
//  Created by Adrian on 07/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import UIKit

class TvShowViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tvShowsTableView: UITableView!
    
    // MARK: Properties
    var tvShows = [BaseTvShow]()
    
    override func viewDidLoad() {
//        backgroundThread(background: refreshTvShows)
        refreshTvShows()
    }
    
    private func refreshTvShows() {
        let requestId = arc4random()
        WebSocketHelper.completionQueue[requestId] = receivedTvShows
        requestFacade!.sendGetTvShows(requestId)
    }
    
    private func receivedTvShows(json: JSON) {
        let tvShows = Mapper<BaseTvShow>().mapArray(json[JsonHelper.resultKey]["tvshows"].arrayObject)
        self.tvShows += tvShows!
        tvShowsTableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "tvShowTableCell"
        let tvShow = tvShows[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TvShowCell
        
        cell.name.text = tvShow.name
        
        // Configure the cell...
        
        return cell
    }

    
}
