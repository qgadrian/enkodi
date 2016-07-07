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

class BaseViewController: UIViewController, WebSocketDelegate {
    
    var requestFacade: RequestFacade!
//    static var receivedResponseCompletion: ((json: JSON) -> ())?
//    static var completionQueue = Dictionary<Int, ((json: JSON) -> ())>()
    static var completionQueue: [UInt32: ((json: JSON) -> ())] = [:]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        requestFacade = RequestFacade.getInstance(RequestProtocol(socketListener: self))
    }
    
    // MARK: Websocket Delegate Methods.
    
    func websocketDidConnect(ws: WebSocket) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(ws: WebSocket, error: NSError?) {
        if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
            print("websocket disconnected")
        }
    }
    
    func websocketDidReceiveMessage(ws: WebSocket, text: String) {
        print("Received text: \(text)")
        
        if let dataFromString = text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            let notitificationValue = json[JsonHelper.methodKey].string
            
            switch notitificationValue {
            case ApiNotification.Player.play?:
//                let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PlayInfoViewController") as! PlayInfoViewController
//                self.presentViewController(secondViewController, animated: true, completion: nil)
//                tabBarController?.selectedViewController = secondViewController
                
                tabBarController?.selectedIndex = 1
                let playInfoController = tabBarController?.selectedViewController as! PlayInfoViewController
                playInfoController.playPauseButton.setTitle("Pause", forState: UIControlState.Normal)
                playInfoController.startRefreshingPlayProgress()
            case ApiNotification.Player.pause?:
                tabBarController?.selectedIndex = 1
                let secondViewController = tabBarController?.selectedViewController as! PlayInfoViewController
                secondViewController.playPauseButton.setTitle("Play", forState: UIControlState.Normal)
            case ApiNotification.Player.stop?:
                let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PlayerControllerViewController") as! PlayerControllerViewController
                self.presentViewController(secondViewController, animated: true, completion: nil)
            default:
                if let requestId = json[JsonHelper.requestIdKey].uInt32 {
                    if let completionFunction = BaseViewController.completionQueue[requestId] {
                            completionFunction(json: json)
                            BaseViewController.completionQueue.removeValueForKey(requestId)
                    }
                }
            }
        }

    }
    
    func websocketDidReceiveData(ws: WebSocket, data: NSData) {
        print("Received data: \(data.length)")
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
        dispatch_source_cancel(timer)
        timer = nil
    }
    
}