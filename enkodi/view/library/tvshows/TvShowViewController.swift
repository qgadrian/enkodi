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

class TvShowViewController: BaseTableViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tvShowsTableView: UITableView!
    
    // MARK: Properties
    var tvShows = [BaseTvShow]()
    
    override func viewDidLoad() {
        backgroundThread(background: refreshTvShows)
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
    
    // MARK: Table view methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "tvShowTableCell"
        let tvShow = tvShows[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TvShowTableCell
        
        setCellSelectedBackground(cell)
        
        cell.name.text = tvShow.name
        
        return cell
    }
    
    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let selectedIndex = tvShowsTableView.indexPathForSelectedRow?.row
        let tvShowSeasonsViewController = segue.destinationViewController as! TvShowSeasonsViewController
        tvShowSeasonsViewController.tvShow = tvShows[selectedIndex!]
    }

}
