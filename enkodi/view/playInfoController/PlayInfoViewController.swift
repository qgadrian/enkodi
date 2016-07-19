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

class PlayInfoViewController: BaseVolumeViewController, PlayListener, UIActionSheetDelegate {
    
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var playerProgressBar: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var subtitlesButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    
    var playerProperties: PlayerProperties?
    
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
        playerProperties = Mapper<PlayerProperties>().map(json["result"].object)
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
    
    @IBAction func subtitlesButtonOnClick(sender: AnyObject) {
        let subtitlesActionSheet: UIAlertController = UIAlertController(title: "Select subtitle", message: "", preferredStyle: .ActionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        subtitlesActionSheet.addAction(cancelActionButton)
        
        if let subtitles = playerProperties?.subtitles {
            for subtitle in subtitles {
                let subtitleActionButton: UIAlertAction = UIAlertAction(title: subtitle.language! + " - " + subtitle.name!, style: .Default)
                { action -> Void in
                    self.requestFacade!.sendSetSubtitle(subtitle.index)
                }
                subtitlesActionSheet.addAction(subtitleActionButton)
            }
        }
        
        
        let disableSubtitlesActionButton: UIAlertAction = UIAlertAction(title: "Disable subtitles", style: .Default)
        { action -> Void in
            self.requestFacade!.sendSetSubtitle(nil)
        }
        subtitlesActionSheet.addAction(disableSubtitlesActionButton)
        
        self.presentViewController(subtitlesActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func audioStreamButtonOnClick(sender: AnyObject) {
        let audiosActionSheet: UIAlertController = UIAlertController(title: "Select audio", message: "", preferredStyle: .ActionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        audiosActionSheet.addAction(cancelActionButton)
        
        if let audioStreams = playerProperties?.audioStreams {
            for audioStream in audioStreams {
                let audioStreamActionButton: UIAlertAction = UIAlertAction(title: audioStream.language! + " - " + audioStream.name!, style: .Default)
                { action -> Void in
                    self.requestFacade!.sendSetAudio(audioStream.index!)
                }
                audiosActionSheet.addAction(audioStreamActionButton)
            }
        }
        
        self.presentViewController(audiosActionSheet, animated: true, completion: nil)
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
        
        BaseViewController.setPlayingStatus(false)
        playerProperties = nil
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
