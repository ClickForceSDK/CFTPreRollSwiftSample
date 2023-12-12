//
//  ViewController.swift
//  CFTPreRollSwiftSample
//
//  Created by CF-NB on 2023/11/6.
//

import UIKit
import iMFADTV
import AVKit

var preroll: MFPreRollView?
let kContentURLString: String = "https://v.holmesmind.com/1151/video/output/s_f96434d0f311f12bdcf5145796985719.mp4"
var contentPlayerViewController = AVPlayerViewController.init()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupContentPlayer()
        self.setPreRoll()
    }
    
    func setPreRoll(){
        hideContentPlayer()
        preroll = MFPreRollView.init(frame: self.view.frame)
        preroll?.setZoneID("18379", get: self)
        preroll?.delegate = self;
        preroll?.setPlayer()
    }
    
    func setupContentPlayer() {
        let contentURL = URL(string: kContentURLString);
        let player = AVPlayer(url: contentURL!);
        contentPlayerViewController = AVPlayerViewController()
        contentPlayerViewController.player = player
        contentPlayerViewController.view.frame = self.view.bounds
        
        // Attach content video player to view hierarchy.
        showContentPlayer()
    }
    
    func showContentPlayer() {
        self.addChild(contentPlayerViewController);
        contentPlayerViewController.view.frame = self.view.bounds;
        self.view.insertSubview(contentPlayerViewController.view, at: 0);
        contentPlayerViewController.didMove(toParent: self);
        contentPlayerViewController.player?.play()
    }
    
    func hideContentPlayer() {
        contentPlayerViewController.willMove(toParent: self);
        contentPlayerViewController.view.removeFromSuperview();
        contentPlayerViewController.removeFromParent()
        contentPlayerViewController.player?.pause()
    }
}

extension ViewController: MFPreRollDelegate {
    func readyPlayVideo() {
        print("PreRoll end, start you'r video.")
        showContentPlayer()
    }
    
    func onFailedToVast() {
        print("PreRoll fail.")
    }
}
