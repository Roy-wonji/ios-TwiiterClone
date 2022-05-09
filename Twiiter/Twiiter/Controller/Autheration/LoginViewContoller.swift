//
//  LoginViewContoller.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit
import AuthenticationServices
import Firebase
import CommonCrypto


final class LoginViewContoller: UIViewController {
    //MARK:  - Properties
    
    private let loginView = LoginView()
    fileprivate var currentNonce: String?
    
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
            self.loginView.appleLoginButton.addTarget(self, action: #selector(self.handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
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
    
    @objc func handleAuthorizationAppleIDButtonPress( ) {
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        // 애플로그인은 사용자에게서 2가지 정보를 요구함
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        
        return request
    }
    @available(iOS 13, *) // - 5️⃣
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = hashSHA256(data: inputData)
        let hashString = hashedData!.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func hashSHA256(data:Data) -> Data? {
        var hashData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        
        _ = hashData.withUnsafeMutableBytes {digestBytes in
            data.withUnsafeBytes {messageBytes in
                CC_SHA256(messageBytes, CC_LONG(data.count), digestBytes)
            }
        }
        return hashData
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension LoginViewContoller: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
// MARK: - ASAuthorizationControllerDelegate
@available(iOS 13.0, *)
extension LoginViewContoller: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            
            guard let appleIDtoken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            
            
            guard let idTokenString = String(data: appleIDtoken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDtoken.debugDescription)")
                return
            }
            
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            
            FirebaseAuth.Auth.auth().signIn(with: credential) { (authDataResult, error) in
                // 인증 결과에서 Firebase 사용자를 검색하고 사용자 정보를 표시할 수 있다.
                if let user = authDataResult?.user {
                    print("애플 로그인 성공!", user.uid, user.email ?? "-")
                }
                self.dismiss(animated: true, completion: nil)
                
                if error != nil {
                    print(error?.localizedDescription ?? "error" as Any)
                    return
                }
            }
        }
    }
}

extension LoginViewContoller {
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}
