//
//  UserService.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/12.
//

import UIKit
import Firebase
import FirebaseFirestore

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid  = Auth.auth().currentUser?.uid  else { return }
        Constants.COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
