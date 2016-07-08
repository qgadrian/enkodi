//
//  PlayInfoViewController.swift
//  enkodi
//
//  Created by Adrian on 05/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import ObjectMapper
import Starscream

class PlayInfoViewController: BaseVolumeViewController {
    
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playerProgressBar: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startRefreshingPlayProgress()
    }
    
    override func viewDidDisappear(animated: Bool) {
        stopTimer()
    }
    
    func startRefreshingPlayProgress() {
        startTimer(intervalDelay: 1, background: refreshPlayerProperties)
    }
    
    private func refreshPlayerProperties() {
        let requestId = arc4random()
        WebSocketHelper.completionQueue[requestId] = receivedPlayerProperties
        requestFacade!.sendGetPlayerProperties(requestId)
    }
    
    private func receivedPlayerProperties(json: JSON) {
        let playerProperties = Mapper<PlayerProperties>().map(json["result"].object)
        playerProgressBar.setValue((playerProperties?.percentage)!, animated: true)
        
        if(playerProperties?.speed == 0) {
            stopTimer()
        }
        
        currentTimeLabel.text = TimeUtil.getTimeString((playerProperties?.currentTime)!)
    }
    
    // Player actions
    @IBAction func playPauseButtonOnClick(sender : AnyObject) {
        requestFacade!.sendPlayPause()
    }
    
    @IBAction func stopButtonOnClick(sender: AnyObject) {
        requestFacade!.sendStop()
    }
    
}
