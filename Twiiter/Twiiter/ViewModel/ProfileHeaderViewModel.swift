//
//  ProfileHeaderViewModel.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/12.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl:  URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User) {
        self.user = user
    }
}
