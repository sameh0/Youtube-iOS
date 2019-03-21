//
//  ViewController.swift
//  YoutubeApp
//
//  Created by Sameh sayed on 3/1/19.
//  Copyright © 2019 Sameh sayed. All rights reserved.
//

import UIKit
import Alamofire
import SwiftAudio

class ViewController: UIViewController,SpinnerDelegate {
   let player = AudioPlayer()
    @IBOutlet var playButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try? AudioSessionController.shared.set(category: .playback)
        player.remoteCommands = [
            .play,
            .pause,
            .changePlaybackPosition,
            .skipForward(preferredIntervals: [15]),
            .skipBackward(preferredIntervals: [30]),
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func onPlayer(_ sender:UIButton){
        let url = UserDefaults(suiteName: "group.youtubeApp.sameh")?.object(forKey: "youtubeURL") as! String
        startAudio(url: url)
    }
    
    func startAudio(url:String)
    {
        showSpinner()
        Alamofire.request(URL(string:"http://\(serverURL)/yt/handlers/downloadVideo.php")!, method: .post, parameters: ["url":url] , encoding: URLEncoding.default, headers: nil)
            .validate()
            
            .responseJSON
            {
                response in
                debugPrint(response)
                if let data = response.request?.httpBody
                {
                    print(String(data:data,encoding:.utf8) ?? "")
                }
                switch response.result {
                case .success(let sucess):
                    
                    guard let result = sucess as? NSDictionary else { return }
                    let title = result["title"] as! String
                    
                    let audioItem = DefaultAudioItem(audioUrl: "http://\(serverURL)/yt/audio/\(title).m4a", sourceType: .stream)
                    do{
                        self.removeSpinner()
                        try self.player.load(item: audioItem, playWhenReady: true)
                        try? AudioSessionController.shared.activateSession()
                        
                    }
                    catch {
                        print(error)
                    }
                    break
                case .failure(let error):
                    Alert.show(title: "Error", message: "You've reached your qoute")
                    break
                }
                
        }
        
    }
}

