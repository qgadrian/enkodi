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

class PlayInfoViewController: BaseVolumeViewController, PlayListener {
    
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var playerProgressBar: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    
    override func viewDidLoad() {
        BaseViewController.playListener = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        backgroundThread(background: refreshPlayerStatus)
    }
    
    override func viewDidDisappear(animated: Bool) {
        stopTimer()
    }
    
    func startRefreshingPlayProgress() {
        if (timer == nil) {
            startTimer(intervalDelay: 1, background: refreshPlayerStatus)
        }
    }
    
    private func refreshPlayerStatus() {
        let requestId = arc4random()
        WebSocketHelper.completionQueue[requestId] = receivedPlayerStatus
        requestFacade!.sendGetPlayerProperties(requestId)
    }
    
    private func receivedPlayerStatus(json: JSON) {
        let playerProperties = Mapper<PlayerProperties>().map(json["result"].object)
        playerProgressBar.setValue((playerProperties?.percentage)!, animated: true)
        
        if(playerProperties?.speed == 0) {
            stopTimer()
            onStartPlaying(false)
        } else {
            onStartPlaying(true)
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
    
    @IBAction func infoButtonOnClick(sender: AnyObject) {
        requestFacade.sendInputAction(InputAction.INFO)
    }
    
    // MARK: Play listeners
    func onStartPlaying(playing: Bool) {
        if (playing) {
            playPauseButton.setImage(UIImage(named: "pauseButton"), forState: UIControlState.Normal)
            startRefreshingPlayProgress()
        } else {
            playPauseButton.setImage(UIImage(named: "playButton"), forState: UIControlState.Normal)
        }
        
        tabBarController?.selectedIndex = 1
        BaseViewController.setPlayingStatus(playing)
        refreshPlayingDetails()
    }
    
    func onStopPlaying() {
        stopTimer()
        titleLabel.text = ""
        subtitleLabel.text = ""
        extraLabel.text = ""
        currentTimeLabel.text = ""
    }
    
    private func refreshPlayingDetails() {
        let requestId = arc4random()
        WebSocketHelper.completionQueue[requestId] = receivedPlayingDetails
        requestFacade!.sendGetCurrentlyPlaying(requestId)
    }
    
    func receivedPlayingDetails(json: JSON) {
        let playingDetails = Mapper<PlayingDetails>().map(json[JsonHelper.resultKey]["item"].object)
        titleLabel.text = playingDetails?.title
        subtitleLabel.text = playingDetails?.subtitle
        extraLabel.text = playingDetails?.extraInfo
    }
    
}
