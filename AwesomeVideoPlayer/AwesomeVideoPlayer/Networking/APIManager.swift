//
//  APIManager.swift
//  AwesomeVideoPlayer
//
//  Created by Sonny on 2018/08/01.
//  Copyright © 2018 Sonny. All rights reserved.
//

import Foundation

final class APIManager {
    static func reloadVideos(completion: @escaping (_ videos: [NetworkVideo]?, _ error: Error?) -> Void) {
        let videoUrl = URL(string: "https://quipper.github.io/native-technical-exam/playlist.json")
        guard let url = videoUrl else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error, data == nil {
                completion(nil, error)
                print("Error during network call: \(error.localizedDescription)")
            }
            if let data = data {
                do {
                    let networkVideos = try JSONDecoder().decode([NetworkVideo].self, from: data)
                    completion(networkVideos, nil)
                } catch let error {
                    completion(nil, error)
                    print("Error during decoding: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
