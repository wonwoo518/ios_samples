//
//  SignInViewController.swift
//  firebaseTest
//
//  Created by wonwoolee on 2018. 10. 11..
//  Copyright © 2018년 wonwoolee. All rights reserved.
//

//  "ran"
import UIKit

class SignInViewController: UIViewController {
    
    let chatViewController = ChatViewController()
    
    func openChattingView() {
        performSegue(withIdentifier: "chattingRooms", sender: nil)
    }
    
    @IBAction func johnButtonTapped(_ sender: UIButton) {
        FirebaseDataService.instance.signIn(email: "soap99@empas.com", password: "111111") {
            self.openChattingView()
        }
    }
    
    @IBAction func parkButtonTapped(_ sender: UIButton) {
        FirebaseDataService.instance.signIn(email: "modesty518@naver.com", password: "111111") {
            self.openChattingView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
