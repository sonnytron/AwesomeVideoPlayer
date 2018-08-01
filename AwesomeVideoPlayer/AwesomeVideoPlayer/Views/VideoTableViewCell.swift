//
//  VideoTableViewCell.swift
//  AwesomeVideoPlayer
//
//  Created by Sonny on 2018/08/01.
//  Copyright © 2018 Sonny. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var speakerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clipsToBounds = true
    }
    
    static func reusableIdentifier() -> String {
        return "VideoTableViewCell"
    }
    
    static func estimatedRowHeight() -> CGFloat {
        return 75.0
    }
}
