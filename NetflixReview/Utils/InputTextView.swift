//
//  InputTextView.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/18.
//

import UIKit
import SnapKit

class InputTextView: UITextView {
    
    // MARK: - Properties
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    var placeholderText: String? {
        didSet { placeholderLabel.text = placeholderText }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(6)
            make.leading.equalTo(8)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func handleTextDidChange() {
        // "Empty caption.." 이 텍스트를 입력하면 사라짐
        placeholderLabel.isHidden = !text.isEmpty
    }
}
