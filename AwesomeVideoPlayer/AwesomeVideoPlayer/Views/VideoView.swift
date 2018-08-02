//
//  VideoView.swift
//  AwesomeVideoPlayer
//
//  Created by Sonny on 2018/08/02.
//  Copyright © 2018 Sonny. All rights reserved.
//

import UIKit
import AVFoundation

class VideoView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
