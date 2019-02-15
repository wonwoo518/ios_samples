//
//  SimpleValidationViewController.swift
//  MvvmSample
//
//  Created by wonwooLee on 2/15/19
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

struct LoginViewModel{
    
    let username:Variable<String> = Variable("")
    let password:Variable<String> = Variable("")
    let isCredentialValid: Observable<Bool>
    let isUserNameValid: Observable<Bool>
    let isPasswordValid: Observable<Bool>
    
    init() {
        isCredentialValid = Observable.combineLatest(self.username.asObservable(), self.password.asObservable()){ (username, password) in
            return username.count > minimalUsernameLength && password.count > minimalPasswordLength
        }
        
        isUserNameValid = username.asObservable().asObservable().map{
            return $0.count > minimalUsernameLength
        }
        
        isPasswordValid = password.asObservable().asObservable().map{
            return $0.count > minimalPasswordLength
        }
    }
}

class SimpleValidationViewController : UIViewController {
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!
    
    @IBOutlet weak var doSomethingOutlet: UIButton!
    
    let disposeBag:DisposeBag = DisposeBag()
    var viewModel:LoginViewModel = {
        return LoginViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        bindViewModel()
    }
    
    func bindViewModel(){
        
        usernameOutlet.rx.text.orEmpty
            .bind(to:viewModel.username)
            .disposed(by: disposeBag)
        
        passwordOutlet.rx.text.orEmpty
            .bind(to:viewModel.password)
            .disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .subscribe(onNext: {  _ in print("do something") })
            .disposed(by: disposeBag)
        
        viewModel.isCredentialValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isUserNameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isPasswordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
