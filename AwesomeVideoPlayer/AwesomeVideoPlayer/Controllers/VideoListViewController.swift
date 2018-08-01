//
//  VideoListViewController.swift
//  AwesomeVideoPlayer
//
//  Created by Sonny on 2018/08/01.
//  Copyright © 2018 Sonny. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {

    var networkVideos: NetworkVideos? = nil {
        didSet {
            DispatchQueue.main.async {
                self.videoTableView.reloadData()
            }
        }
    }
    
    @IBOutlet var videoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.register(UINib(nibName: VideoTableViewCell.reusableIdentifier(), bundle: nil), forCellReuseIdentifier: VideoTableViewCell.reusableIdentifier())
        APIManager.reloadVideos { (videos, error) in
            if let videoObjects = videos {
                self.networkVideos = videoObjects
            }
        }
    }
}

extension VideoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let videos = networkVideos else { return }
        let videoSelected = videos[indexPath.row]
        print("Selected videoObject: \(videoSelected.title)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
}

extension VideoListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let videos = networkVideos else { return 0 }
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let videoCell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.reusableIdentifier(), for: indexPath) as? VideoTableViewCell,
            let videoObjects = networkVideos else {
            fatalError("Failed to dequeue VideoTableViewCell for indexPath: \(indexPath)")
        }
        let videoObject = videoObjects[indexPath.row]
        videoCell.titleLabel.text = videoObject.title
        videoCell.descriptionLabel.text = videoObject.description
        videoCell.speakerLabel.text = videoObject.presenterName
        videoCell.thumbnailImageView.downloadedFrom(link: videoObject.thumbnailURL, contentMode: .scaleAspectFill)
        return videoCell
    }
}
