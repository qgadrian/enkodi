//
//  ViewController.swift
//  enkodi
//
//  Created by Adrian on 5/11/16.
//  Copyright (c) 2016 adrian quintas. All rights reserved.
//


import UIKit
import Starscream
import SwiftyJSON
import ObjectMapper

class ViewController: UIViewController, WebSocketDelegate {
    
    @IBOutlet var testButton : UIButton!
    
    var socket = WebSocket(url: NSURL(string: "ws://192.168.0.23:9090/jsonrpc")!)
    
    // MARK: Properties

    override func viewDidLoad() {
    super.viewDidLoad()
        
//        let username = "adrian"
//        let password = "***REMOVED***"
//        let credentialData = "\(username):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
//        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
//        let headers = ["Authorization": "Basic \(base64Credentials)"]
//        socket.headers = headers
        
        socket.delegate = self
        
        socket.connect()
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
//        print("Received text: \(text)")
        
        if let dataFromString = text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            let stuff = json["result"]["tvshows"].arrayObject
            let tvShows = Mapper<BaseTvShow>().mapArray(json["result"]["tvshows"].arrayObject)
            print(tvShows![0].name)
        }
        
//        let json = JSON(text)
//        let tvShows = Mapper<BaseTvShow>().map(json["result"]["tvshows"].arrayObject)
//        print(tvShows?.name)
    }
    
    func websocketDidReceiveData(ws: WebSocket, data: NSData) {
        print("Received data: \(data.length)")
    }
    
    @IBAction func testSocket(sender : AnyObject) {
        print("its a trap!!!")
        
        var json = JSON(["jsonrpc" : "2.0", "id" : 1])
        json["method"].string = "VideoLibrary.GetTVShows"
        let nsData = try! json.rawData()
        
        socket.writeData(nsData)
        
//        let jsonString = json.rawString(NSUTF8StringEncoding)
//        socket.writeString(jsonString!)
    }


    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }


}
