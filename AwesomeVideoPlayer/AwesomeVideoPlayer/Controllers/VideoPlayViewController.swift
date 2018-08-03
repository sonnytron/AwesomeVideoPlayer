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
    @IBOutlet var durationSlider: UISlider!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var playButton: UIButton!
    
    var timeObserverToken: Any?
    
    private let durationString: String
    private let networkVideo: NetworkVideo
    
    init(withVideo video: NetworkVideo) {
        guard let videoURL = URL(string: video.videoURL) else {
            fatalError("Failed to load video URL: \(video.videoURL)")
        }
        durationString = (Double(video.videoDuration) as TimeInterval).msToString()
        playerView = AVPlayer(url: videoURL)
        networkVideo = video
        super.init(nibName: "VideoPlayViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder aDecoder: not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "00:00 | \(self.durationString)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let playerLayer = videoView.layer as? AVPlayerLayer else {
            return
        }
        playerLayer.player = playerView
        
        playerLayer.videoGravity = .resizeAspect
        self.timeObserverToken = playerView.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (time) in
            let currentTime = CMTimeGetSeconds(time)
            let duration = Float(self.networkVideo.videoDuration / 1000)
            self.timeLabel.text = "\(currentTime.toString()) | \(self.durationString)"
            self.durationSlider.value = Float(Float(currentTime) / duration)
        }
        playerView.play()
        playButton.isSelected = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let observer = timeObserverToken {
            playerView.removeTimeObserver(observer)
        }
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        playerView.pause()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func userBeganScroll(_ sender: UISlider) {
        playerView.pause()
        playButton.isSelected = false
    }
    
    @IBAction func userFinishedScroll(_ sender: UISlider) {
        guard let currentTime = playerView.currentItem?.asset.duration else {
            return
        }
        let newCurrentTime = Double(sender.value) * CMTimeGetSeconds(currentTime)
        let seekTime = CMTimeMakeWithSeconds(newCurrentTime, preferredTimescale: 600)
        playerView.seek(to: seekTime)
    }
    
    @IBAction func userScrolling(_ sender: UISlider) {
        guard let duration = playerView.currentItem?.asset.duration else {
            return
        }
        let seconds : Float64 = CMTimeGetSeconds(duration) * Double(sender.value)
        self.timeLabel.text = "\(seconds.toString()) | \(self.durationString)"
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
