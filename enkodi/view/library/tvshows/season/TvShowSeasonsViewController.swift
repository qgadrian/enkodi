//
//  TvShowSeasonsViewController.swift
//  enkodi
//
//  Created by Adrian on 08/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import SwiftyJSON

class TvShowSeasonsViewController: BaseTableViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tvShowEpisodesTableView: UITableView!
    
    var tvShow: BaseTvShow?
    private var tvShowSeasons = [TvShowSeason]()
    private var tvShowEpisodesBySeasonId = [Int : Array<BaseTvShowEpisode>]()
    
    override func viewDidAppear(animated: Bool) {
        print(tvShow?.name)
        title = tvShow?.name
    }
    
    override func viewDidLoad() {
        backgroundThread(background: refreshTvShowSeasons)
    }
    
    private func refreshTvShowSeasons() {
        let requestId = arc4random()
        WebSocketHelper.completionQueue[requestId] = receivedTvShowSeasons
        requestFacade!.sendGetTvShowSeasons(tvShow!.id!, requestId: requestId)
    }
    
    private func receivedTvShowSeasons(json: JSON) {
        let tvShowSeasons = Mapper<TvShowSeason>().mapArray(json[JsonHelper.resultKey]["seasons"].arrayObject)
        self.tvShowSeasons += tvShowSeasons!

        refreshTvShowSeasonEpisodes()
    }
    
    private func refreshTvShowSeasonEpisodes() {
        let requestId = arc4random()
        WebSocketHelper.completionQueue[requestId] = receivedTvShowSeasonEpisodes
        requestFacade!.sendGetAllTvShowSeasonsEpisodes(tvShow!.id!, requestId: requestId)
    }
    
    private func receivedTvShowSeasonEpisodes(json: JSON) {
        let tvShowSeasonEpisodes = Mapper<BaseTvShowEpisode>().mapArray(json[JsonHelper.resultKey]["episodes"].arrayObject)
        
        for tvShowEpisode in tvShowSeasonEpisodes! {
            if tvShowEpisodesBySeasonId[tvShowEpisode.seasonNumber!] == nil {
                tvShowEpisodesBySeasonId[tvShowEpisode.seasonNumber!] = Array<BaseTvShowEpisode>()
            }
            
            tvShowEpisodesBySeasonId[tvShowEpisode.seasonNumber!]?.append(tvShowEpisode)
        }
        
        tvShowEpisodesTableView.reloadData()
    }
    
    // MARK: Table view methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return tvShowSeasons.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tvShowSeasons[section].name
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tvShowSeasonNumber = tvShowSeasons[section].seasonNumber!
        
        if let seasonEpisodes = tvShowEpisodesBySeasonId[tvShowSeasonNumber] {
            return seasonEpisodes.count
        }
        
        return 0

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "tvShowSeasonTableCell"
        let tvShowSeasonNumber = tvShowSeasons[indexPath.section].seasonNumber!
        let tvShowEpisode = tvShowEpisodesBySeasonId[tvShowSeasonNumber]![indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TvShowSeasonTableCell
        cell.tvShowEpisodeLabel.text = tvShowEpisode.title
        
        setCellSelectedBackground(cell)
        
        if (tvShowEpisode.isWatched()) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .DisclosureIndicator
        }
        
        return cell
    }
        
    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let selectedIndex = tvShowEpisodesTableView.indexPathForSelectedRow?.row
        let selectedSection = tvShowEpisodesTableView.indexPathForSelectedRow?.section
        let tvShowEpisodeViewController = segue.destinationViewController as! TvShowEpisodeViewController
        
        let selectedSeasonNumber = tvShowSeasons[selectedSection!].seasonNumber!
        
        tvShowEpisodeViewController.baseTvShowEpisode = tvShowEpisodesBySeasonId[selectedSeasonNumber]![selectedIndex!]
    }
    
}