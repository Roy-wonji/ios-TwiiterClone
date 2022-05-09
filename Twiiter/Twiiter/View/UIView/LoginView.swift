//
//  LoginView.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit
import Then

final class LoginView: UIView {
    //MARK:  - Properties
    private lazy var logoImageView = UIImageView().then { imageView in
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "TwitterLogo")
    }
    
    private lazy var emailContainerView = CustomView().inputContainerView(withImage: UIImage(named: "mail2"), textField: emailTextField).then { uiView in
        
    }
    
    private lazy var passwordContainerView = CustomView().inputContainerView(withImage: UIImage(named: "lock"), textField: passwordTextField).then { uiView in
        
    }
    
    lazy var emailTextField = CustomView().textField(withPlaceholder: LoginViewText.emailTextFieldText).then{ textField in
        
    }
    
     lazy var passwordTextField = CustomView().textField(withPlaceholder: LoginViewText.passwordTextFieldText).then{ textField in
        textField.isSecureTextEntry = true
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton]).then{ stack in
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
    }
    
     lazy var loginButton = UIButton(type: .system).then{ button in
        button.setTitle(LoginViewText.loginButtonText, for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
      lazy var dontHaveAccountButton = CustomView().attributedButton(fristPart: LoginViewText.attributedTitleText, secondPart: LoginViewText.signupText).then{ button in
    }
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        updateView()
        updateConstraints()
    }
    
    private func updateView() {
        self.addSubview(logoImageView)
        self.addSubview(stackView)
        self.addSubview(dontHaveAccountButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout 관련
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints() {
        setConstraintsLogoImageView()
        setConstraintsStackView()
        setConstraintsDontHaveAccountButton()
    }
    
    private func setConstraintsLogoImageView() {
        logoImageView.centerX(inView: self, topAnchor: self.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
    }
    
    private func setConstraintsStackView() {
        stackView.anchor(top: logoImageView.bottomAnchor, left: self.leftAnchor,
                         right: self.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
    
    private func setConstraintsDontHaveAccountButton() {
        dontHaveAccountButton.anchor(left: self.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.rightAnchor, paddingLeft: 40,  paddingRight: 40)
    }
}
