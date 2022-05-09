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
        DispatchQueue.main.async {
            self.loginView.loginButton.addTarget(self, action: #selector(self.handleLogin), for: .touchUpInside)
            self.loginView.dontHaveAccountButton.addTarget(self, action: #selector(self.handleShowSignUp), for: .touchUpInside)
        }
    }
    
    //MARK: - Selectors
    @objc func handleShowSignUp() {
        let registerController = RegisterViewController()
        navigationController?.pushViewController(registerController, animated: true)
        
    }
    
    @objc func handleLogin() {
        guard let email = loginView.emailTextField.text else  { return }
        guard let password = loginView.passwordTextField.text else  { return }
        
        AuthService.logUseIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Falied to log user in  \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
