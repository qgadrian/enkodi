//
//  WebSocketListener.swift
//  enkodi
//
//  Created by Adrian on 08/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import SwiftyJSON
import Starscream
import UIKit

class WebSocketListener: WebSocketDelegate {
    
    var baseViewControllerInstance: BaseViewController
    
    init(baseViewControllerInstance: BaseViewController) {
        self.baseViewControllerInstance = baseViewControllerInstance
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
            case ApiNotification.Application.volumeChanged?:
                processVolumeChangeNotification(json)
            case ApiNotification.Player.play?:
                processOnPlayNotification()
            case ApiNotification.Player.pause?:
                processOnPauseNotification()
            case ApiNotification.Player.stop?:
                processOnStopNotification()
            default:
                processOtherNotificationWithId(json)
            }
        }
        
    }
    
    func websocketDidReceiveData(ws: WebSocket, data: NSData) {
        print("Received data: \(data.length)")
    }
    
    // MARK: websocket request methods
    
    private func processVolumeChangeNotification(json: JSON) {
        if let volumeValue = JsonParseHelper.parseVolumeChangeNotification(json).volume {
            if (BaseViewController.volumeListener != nil) {
                BaseViewController.volumeListener?.onVolumeChanged(volumeValue)
            }
        }
    }
    
    private func processOnPlayNotification() {
        //                let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PlayInfoViewController") as! PlayInfoViewController
        //                self.presentViewController(secondViewController, animated: true, completion: nil)
        //                tabBarController?.selectedViewController = secondViewController
        
        BaseViewController.playListener?.onStartPlaying(true)
    }
    
    private func processOnPauseNotification() {
        BaseViewController.playListener?.onStartPlaying(false)
    }
    
    private func processOnStopNotification() {
//        let secondViewController = baseViewControllerInstance.storyboard!.instantiateViewControllerWithIdentifier("PlayerControllerViewController") as! PlayerControllerViewController
//        baseViewControllerInstance.presentViewController(secondViewController, animated: true, completion: nil)
        BaseViewController.playListener?.onStopPlaying()
    }
    
    private func processOtherNotificationWithId(json: JSON) {
        if let requestId = json[JsonHelper.requestIdKey].uInt32 {
            if let completionFunction = WebSocketHelper.completionQueue[requestId] {
                completionFunction(json: json)
                WebSocketHelper.completionQueue.removeValueForKey(requestId)
            }
        }
    }
    
}
