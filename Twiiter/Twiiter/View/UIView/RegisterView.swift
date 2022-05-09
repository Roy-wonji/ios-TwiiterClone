//
//  RegisterView.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit
import Then

final class RegisterView: UIView {
    //MARK:  - Properties
    
    lazy var plusPhotoButton = UIButton(type: .system).then{ button in
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
    }
    
    private lazy var emailContainerView = CustomView().inputContainerView(withImage: UIImage(named: "mail2"), textField: emailTextField).then { uiView in
        
    }
    
    private lazy var passwordContainerView = CustomView().inputContainerView(withImage: UIImage(named: "lock"), textField: passwordTextField).then { uiView in
        
    }
    
    private lazy var emailTextField = CustomView().textField(withPlaceholder: RegisterViewText.emailTextFieldText).then{ textField in
        textField.keyboardType = .emailAddress
    }
    
    private lazy var passwordTextField = CustomView().textField(withPlaceholder: RegisterViewText.passwordTextFieldText).then{ textField in
        textField.isSecureTextEntry = true
    }
    
    
    private lazy var fullnameContainerView = CustomView().inputContainerView(withImage: UIImage(named: "ic_person"), textField: fullnameTextField).then { uiView in
        
    }
    
    private lazy var usernameContainerView = CustomView().inputContainerView(withImage: UIImage(named: "ic_person"), textField: usernameTextField).then { uiView in
        
    }
    
    private lazy var fullnameTextField = CustomView().textField(withPlaceholder: RegisterViewText.fullnameTextFieldText).then{ textField in
        
    }
    
    private lazy var usernameTextField = CustomView().textField(withPlaceholder: RegisterViewText.usernameTextFieldText).then{ textField in
        
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView, signUpButton]).then{ stack in
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
    }
    
    lazy var signUpButton = UIButton(type: .system).then{ button in
        button.setTitle(RegisterViewText.signUpButtonText, for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    lazy var alreadyHaveAccountButton = CustomView().attributedButton(fristPart: RegisterViewText.alreadyHaveAccountButtonText, secondPart: RegisterViewText.signUpButtonText).then{ button in
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
        self.addSubview(plusPhotoButton)
        self.addSubview(stackView)
        self.addSubview(alreadyHaveAccountButton)
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
        setConstraintsPlusPhotoButton()
        setConstraintsStackView()
        setConstraintsAlreadyHaveAccountButton()
    }
    
    private func setConstraintsPlusPhotoButton() {
        plusPhotoButton.centerX(inView: self, topAnchor: self.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)
    }
    
    private func setConstraintsStackView() {
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: self.leftAnchor,
                         right: self.rightAnchor, paddingTop: 32 ,paddingLeft: 32, paddingRight: 32)
    }
    
    private func setConstraintsAlreadyHaveAccountButton() {
        alreadyHaveAccountButton.anchor(left: self.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.rightAnchor, paddingLeft: 40,  paddingRight: 40)
    }
}
