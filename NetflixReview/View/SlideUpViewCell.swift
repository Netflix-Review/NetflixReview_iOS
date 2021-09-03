//
//  SlideUpViewCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/03.
//

import UIKit
import SnapKit

class SlideUpViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
        return view
    }()

    lazy var iconView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 20, y: 10, width: 30, height: 30))
        return view
    }()

    lazy var labelView: UILabel = {
        let view = UILabel(frame: CGRect(x: 100, y: 10,
                                         width: self.frame.width, height: 30))
        return view
    }()

    
    // MARK: - Lifecycle
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(iconView)
        backView.addSubview(labelView)
    }
    
}
