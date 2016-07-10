//
//  TvShowEpisodeViewController.swift
//  enkodi
//
//  Created by Adrian on 09/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import ObjectMapper

class TvShowEpisodeViewController: BaseViewController {
    
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var baseTvShowEpisode: BaseTvShowEpisode?
    
    override func viewDidLoad() {
        
        backgroundThread(background: refreshTvShowInfo)
        
        title = baseTvShowEpisode?.title
    }
    
    private func refreshTvShowInfo() {
        let requestId = arc4random()
        WebSocketHelper.completionQueue[requestId] = receivedTvShowInfo
        requestFacade!.sendGetTvShowEpisodeInfo(baseTvShowEpisode!.id!, requestId: requestId)
    }
    
    private func receivedTvShowInfo(json: JSON) {
        let tvShowEpisodeInfo = Mapper<TvShowEpisodeInfo>().map(json[JsonHelper.resultKey]["episodedetails"].object)
        
        titleLabel.text = tvShowEpisodeInfo?.tvShowName
        plotLabel.text = tvShowEpisodeInfo?.plot
        plotLabel.sizeToFit()
    }
    
    @IBAction func onPlayButtonClick(sender: AnyObject) {
        requestFacade.sendPlayFile((baseTvShowEpisode?.file)!)
    }
}