//
//  VideoPlayViewController.swift
//  AwesomeVideoPlayer
//
//  Created by Sonny on 2018/08/02.
//  Copyright © 2018 Sonny. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayViewController: UIViewController {
    
    let playerView: AVPlayer
    @IBOutlet var videoView: VideoView!
    
    @IBOutlet var controlsView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let playerLayer = videoView.layer as? AVPlayerLayer else {
            return
        }
        playerLayer.player = playerView
        playerLayer.videoGravity = .resizeAspect
    }
    
    init(withVideo video: NetworkVideo) {
        guard let videoURL = URL(string: video.videoURL) else {
            fatalError("Failed to load video URL: \(video.videoURL)")
        }
        playerView = AVPlayer(url: videoURL)
        super.init(nibName: "VideoPlayViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder aDecoder: not implemented")
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        playerView.pause()
        dismiss(animated: true, completion: nil)
    }
    
}

extension VideoPlayViewController {
    /// Toggle play or pause for video
    @IBAction func playToggled(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            playerView.play()
        } else {
            playerView.pause()
        }
    }
}
