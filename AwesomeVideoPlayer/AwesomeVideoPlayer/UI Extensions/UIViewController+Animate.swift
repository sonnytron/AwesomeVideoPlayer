//
//  UIViewController+Animate.swift
//  AwesomeVideoPlayer
//
//  Created by Sonny on 2018/08/03.
//  Copyright © 2018 Sonny. All rights reserved.
//

import UIKit

extension UIViewController {
    func animateToCenter(imageView: UIImageView, viewToHide: UIView?, completion: @escaping (Bool) -> ()) {
        imageView.alpha = 0.0
        view.addSubview(imageView)
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                viewToHide?.alpha = 0.0
                self.view.backgroundColor = .black
                imageView.alpha = 1.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.15, relativeDuration: 0.35, animations: {
                imageView.frame = CGRect(x: 0,
                                         y: self.view.frame.size.height/2 - imageView.frame.size.height/2,
                                         width: self.view.frame.size.width,
                                         height: imageView.frame.size.height)
            })
        }) { (completed) in
            completion(completed)
        }
    }
}
