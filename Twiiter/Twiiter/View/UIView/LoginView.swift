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
    
    private lazy var emailTextField = CustomView().textField(withPlaceholder: LoginViewText.emailTextFieldText).then{ textField in
        
    }
    
    private lazy var passwordTextField = CustomView().textField(withPlaceholder: LoginViewText.passwordTextFieldText).then{ textField in
        textField.isSecureTextEntry = true
    }
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView]).then{ stack in
        stack.axis = .vertical
        stack.spacing = 8
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
        self.addSubview(containerStackView)
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
    }
    
    private func setConstraintsLogoImageView() {
        logoImageView.centerX(inView: self, topAnchor: self.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
    }
    
    private func setConstraintsStackView() {
        containerStackView.anchor(top: logoImageView.bottomAnchor, left: self.leftAnchor,
                                  right: self.rightAnchor, paddingLeft: 16, paddingRight: 16)
    }
}
