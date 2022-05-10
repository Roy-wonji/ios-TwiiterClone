//
//  RegisterViewController.swif
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit
import Firebase

final class RegisterViewController: UIViewController {
    //MARK:  - Properties
    
    private let registerView = RegisterView()
    private var profileImage: UIImage?
    
    //MARK:  - lifeCycle
    
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configureUI()
    }
    
    //MARK:  - UI 관련
    private func updateUI() {
        view.backgroundColor = .twitterBlue
    }
    
    private func configureUI() {
        addTarget()
    }
    
    private func addTarget() {
//        DispatchQueue.main.async {
            registerView.plusPhotoButton.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
            registerView.signUpButton.addTarget(self, action: #selector(handleRegistrantion), for: .touchUpInside)
            registerView.alreadyHaveAccountButton.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        }
//    }
    //MARK: - Selectors
    @objc func handleAddProfilePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion:  nil)
    }
    
    @objc func handleRegistrantion() {
        guard let email = registerView.emailTextField.text else  { return }
        guard let password = registerView.passwordTextField.text else  { return }
        guard let fullname = registerView.fullnameTextField.text else  { return }
        guard let username = registerView.usernameTextField.text?.lowercased() else  { return }
        guard let profileImage = profileImage else { return }

        let crendentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage )
        
        AuthService.registerUser(withCredential: crendentials) { error in
            if let error = error {
                print("DEBUG: Falied to register user \(error.localizedDescription)")
                return
            }
            print("DEBUG:Sucessfully registered user with firestore...")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
}
//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate 설정
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        
        registerView.plusPhotoButton.layer.cornerRadius = 128 / 2
        registerView.plusPhotoButton.layer.masksToBounds = true
        registerView.plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        registerView.plusPhotoButton.imageView?.clipsToBounds = true
        registerView.plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        registerView.plusPhotoButton.layer.borderWidth = 3
        self.registerView.plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
