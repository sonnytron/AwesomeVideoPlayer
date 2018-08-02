//
//  TimeIntervalExtension.swift
//  AwesomeVideoPlayer
//
//  Created by Sonny on 2018/08/02.
//  Copyright © 2018 Sonny. All rights reserved.
//

import Foundation

extension TimeInterval {
    func toString() -> String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    func msToString() -> String {
        let interval = Int(self)
        let ms = interval / 1000
        let seconds = ms % 60
        let minutes = (ms / 60) % 60
        let hours = (ms / 3600)
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}
