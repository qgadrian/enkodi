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
import Alamofire
import AlamofireImage

class TvShowEpisodeViewController: BaseViewController, UIScreenEdgePanGestureRecognizer {
    
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var episodeThumbnail: UIImageView!
    
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
        
        let url = "http://192.168.0.23:7523/image" + UrlUtil.parseImageToUrlPath((tvShowEpisodeInfo?.thumbnail)!)
        Alamofire.request(.GET, url).authenticate(user: "adrian", password: "***REMOVED***").responseImage {
            response in debugPrint(response)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.episodeThumbnail.image = image
            }
        }
        
        titleLabel.text = String(format: "Season %d, episode %d", (tvShowEpisodeInfo?.seasonNumber)!, (tvShowEpisodeInfo?.episodeNumber)!)
        plotLabel.text = tvShowEpisodeInfo?.plot
        plotLabel.sizeToFit()
    }
    
    @IBAction func onPlayButtonClick(sender: AnyObject) {
        requestFacade.sendPlayFile((baseTvShowEpisode?.file)!)
    }
}