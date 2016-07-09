//
//  BaseVolumeViewController.swift
//  enkodi
//
//  Created by Adrian on 08/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import SwiftyJSON

class BaseVolumeViewController: BaseViewController, VolumeChangedListener {
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var volumeLabel: UILabel!
    
    var ignoreVolumeNotifications: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidAppear(animated: Bool) {
        BaseViewController.volumeListener = self
        backgroundThread(background: refreshApplicationProperties)
    }
    
    private func refreshApplicationProperties() {
        let requestId = arc4random()
        WebSocketHelper.completionQueue[requestId] = receivedApplicationProperties
        requestFacade!.sendGetApplicationProperties(requestId)
    }
    
    private func receivedApplicationProperties(json: JSON) {
        let applicationProperties = Mapper<ApplicationProperties>().map(json["result"].object)
        refreshVolumeSlideBar(volumeSlider, volumeLabel: volumeLabel, volume: (applicationProperties?.volume)!)
    }
    
    @IBAction func volumeSliderOnSlide(sender: AnyObject) {
        let volume: Int = Int(volumeSlider.value)
        requestFacade!.sendSetVolume(volume)
        updateVolumeLabel(volumeLabel, volume: volume)
    }
    
    // Mark: UI methods
    func refreshVolumeSlideBar(volumeSlider: UISlider, volumeLabel: UILabel? = nil, volume: Int) {
        let volumeFloat = Float(volume)
        volumeSlider.setValue(volumeFloat, animated: true)
        updateVolumeLabel(volumeLabel, volume: volume)
    }
    
    // When a volume slider is touched, disable any volume changed notifications
    @IBAction func volumeSliderTouchDown() {
        ignoreVolumeNotifications = true
    }
    
    @IBAction func volumeSliderTouchUp() {
        ignoreVolumeNotifications = false
    }
    
    private func updateVolumeLabel(volumeLabel: UILabel?, volume: Int) {
        if (volumeLabel != nil) {
           volumeLabel?.text = TimeUtil.getVolumeValueString(volume)
        }
    }
    
    func onVolumeChanged(volume: Int) {
        if (!ignoreVolumeNotifications) {
            refreshVolumeSlideBar(volumeSlider, volumeLabel: volumeLabel, volume: volume)
        }
    }
}