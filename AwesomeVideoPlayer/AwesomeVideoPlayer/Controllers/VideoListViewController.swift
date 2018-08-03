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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndex = videoTableView.indexPathForSelectedRow {
            videoTableView.deselectRow(at: selectedIndex, animated: true)
        }
    }
}

extension VideoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? VideoTableViewCell,
            let videoObjects = networkVideos else {
                fatalError("Failed to dequeue VideoTableViewCell for indexPath: \(indexPath)")
        }
        let tableRect = tableView.rectForRow(at: indexPath)
        let absoluteRect = tableView.convert(tableRect, to: view)
        guard let selectedImage = currentCell.thumbnailImageView else { return }
        let imageCopy = UIImageView(frame: absoluteRect)
        imageCopy.image = selectedImage.image
        imageCopy.contentMode = selectedImage.contentMode
        imageCopy.alpha = 0.0
        view.addSubview(imageCopy)
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                self.videoTableView.alpha = 0.0
                self.view.backgroundColor = UIColor.black
                imageCopy.alpha = 1.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.30, animations: {
                imageCopy.frame = CGRect(x: 0, y: self.view.frame.size.height/2 - imageCopy.frame.size.height/2, width: self.view.frame.size.width, height: imageCopy.frame.size.height)
            })
        }) { (completed) in
            let videoSelected = videoObjects[indexPath.row]
            let playerVC = VideoPlayViewController(withVideo: videoSelected)
            self.present(playerVC, animated: true, completion: {
                self.videoTableView.alpha = 1.0
                self.view.backgroundColor = UIColor.white
                imageCopy.removeFromSuperview()
            })
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (9 * self.view.frame.size.width) / 16
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
