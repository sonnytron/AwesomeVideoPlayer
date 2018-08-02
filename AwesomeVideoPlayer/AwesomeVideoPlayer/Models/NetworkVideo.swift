//
//  NetworkVideo.swift
//  AwesomeVideoPlayer
//
//  Created by Sonny on 2018/08/01.
//  Copyright © 2018 Sonny. All rights reserved.
//

import Foundation

typealias NetworkVideos = [NetworkVideo]

struct NetworkVideo: Codable {
    let title, presenterName, description, thumbnailURL: String
    let videoURL: String
    let videoDuration: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case presenterName = "presenter_name"
        case description
        case thumbnailURL = "thumbnail_url"
        case videoURL = "video_url"
        case videoDuration = "video_duration"
    }
}
