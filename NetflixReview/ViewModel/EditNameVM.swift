//
//  EditNameVM.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/19.
//

import Foundation

enum EditNameOption: Int, CaseIterable {
    case name
    
    var description: String {
        switch self {
        case .name: return "이름"
        }
    }
}

struct EditNameVM {
    
    let option: EditNameOption
    
    var titleText: String { return option.description }
    
    var optionValue: String? {
        switch option {
        case .name: return "User"
        }
    }
    
    
    init(option: EditNameOption) {
        self.option = option
    }
}
