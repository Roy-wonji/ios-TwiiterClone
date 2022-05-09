//
//  Constants.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/10.
//

import Firebase

struct Constants{
    static let DB_REF = Firestore.firestore()
    static let REF_USERS =  DB_REF.collection("users")
}

