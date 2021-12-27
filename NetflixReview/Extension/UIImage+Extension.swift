//
//  UIImageViewExtension.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/01.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
