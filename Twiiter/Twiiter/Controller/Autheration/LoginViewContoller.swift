//
//  LoginViewContoller.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit

final class LoginViewContoller: UIViewController {
    //MARK:  - Properties
    
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    //MARK:  - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configureUI()
    }

    //MARK:  - UI 관련
    private func updateUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        self.overrideUserInterfaceStyle = .light
    }
    
    private func configureUI() {
        addTarget()
    }
    
    private func addTarget() {
        loginView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginView.dontHaveAccountButton.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
    }
    
    //MARK: - Selectors
    @objc func handleShowSignUp() {
        let registerController = RegisterViewController()
        navigationController?.pushViewController(registerController, animated: true)
        
    }
    
    @objc func handleLogin() {
        print("DEBUG: LoginButton Tapped")
    }
}
