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
    private let imagePicker  = UIImagePickerController()
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
        imagePickerDelegate()
    }
    
    private func addTarget() {
        DispatchQueue.main.async {
            self.registerView.plusPhotoButton.addTarget(self, action: #selector(self.handleAddProfilePhoto), for: .touchUpInside)
            self.registerView.signUpButton.addTarget(self, action: #selector(self.handleRegistrantion), for: .touchUpInside)
            self.registerView.alreadyHaveAccountButton.addTarget(self, action: #selector(self.handleShowLogin), for: .touchUpInside)
        }
    }
    
    private func imagePickerDelegate() {
        DispatchQueue.main.async {
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
        }
    }
    //MARK: - Selectors
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion:  nil)
    }
    
    @objc func handleRegistrantion() {
        guard let email = registerView.emailTextField.text  else  { return }
        guard let password = registerView.passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            print("DEBUG: Sucessfully registered user..")
        }
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
}
//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate 설정
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        registerView.plusPhotoButton.layer.cornerRadius = 128 / 2
        registerView.plusPhotoButton.layer.masksToBounds = true
        registerView.plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        registerView.plusPhotoButton.imageView?.clipsToBounds = true
        registerView.plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        registerView.plusPhotoButton.layer.borderWidth = 3
        self.registerView.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
