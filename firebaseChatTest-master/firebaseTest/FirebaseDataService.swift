//
//  FirebaseDataService.swift
//  firebaseTest
//
//  Created by wonwoolee on 2018. 10. 11..
//  Copyright © 2018년 wonwoolee. All rights reserved.
//

import Foundation
import Firebase

fileprivate let baseRef = FIRDatabase.database().reference()

class FirebaseDataService {
    static let instance = FirebaseDataService()
    
    // 특정 데이터들이 저장되는 장소에 대한 레퍼런스
    // user : 특정 사용자
    let usersRef = baseRef.child("users")
    
    // group : 채팅방 하나 단위
    let groupRef = baseRef.child("group")
    
    // message : 채팅 말풍선 하나 단위
    let messageRef = baseRef.child("message")
    
    
    // 현재 접속중인 유저의 uid
    var currentUserUid: String? {
        get {
            guard let uid = FIRAuth.auth()?.currentUser?.uid else {
                return nil
            }
            return uid
        }
    }
    
    // 신규 유저 만들기
    func createUserInfoFromAuth(uid:String, userData: Dictionary<String, String>) {
        usersRef.child(uid).updateChildValues(userData)
    }
    
    // 사용자 로그인 하기
    func signIn(email withEmail: String, password: String, completion: @escaping () -> Void) {
        FIRAuth.auth()?.signIn(withEmail: withEmail, password: password, completion: { (user, error) in
            guard error == nil else {
                print("Error Occurred during Sign In")
                return
            }
            completion()
        })
    }
}

