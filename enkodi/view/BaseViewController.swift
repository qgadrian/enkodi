//
//  BaseViewController.swift
//  enkodi
//
//  Created by Adrian on 05/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import UIKit
import Starscream
import SwiftyJSON
import ObjectMapper

class BaseViewController: UIViewController {
    
    // UI listeners
    static var volumeListener: VolumeChangedListener? = nil
    static var playListener: PlayListener? = nil
    
    
    // Global var
    private static var isPlaying: Bool? = false
    
    var requestFacade: RequestFacade!
    var webSocketListener: WebSocketListener!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        webSocketListener = WebSocketListener(baseViewControllerInstance: self)
        requestFacade = RequestFacade.getInstance(RequestProtocol(socketListener: webSocketListener))
    }
    
    // Mark: thread methods
    
    func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            if(background != nil){ background!(); }
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
    
    var timer: dispatch_source_t!
    
    func startTimer(startDelay: Double = 0.0, intervalDelay: Double = 60.0, background: (() -> Void)? = nil) {
        let queue = dispatch_queue_create("com.domain.app.timer", nil)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        
        let startDelayNanos = UInt64(startDelay) * NSEC_PER_SEC
        let intervalDelayNanos = UInt64(intervalDelay) * NSEC_PER_SEC
        
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, intervalDelayNanos, startDelayNanos)
        dispatch_source_set_event_handler(timer, background)
        dispatch_resume(timer)
    }
    
    func stopTimer() {
        if (timer != nil) {
            dispatch_source_cancel(timer)
            timer = nil
        }
    }
    
    // MARK: Player status methods
    static func setPlayingStatus(isPlaying: Bool) {
        BaseViewController.isPlaying = isPlaying
    }
    
    static func isPlayerPlaying() -> Bool {
        return BaseViewController.isPlaying!
    }
    
}