//
//  ProfileVM.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/10/06.
//

import UIKit

struct ProfileVM {
    
    let user: User
    
    var name: String { return user.username }
    
}
