//
//  RegisterViewController.swif
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit

final class RegisterViewController: UIViewController {
    //MARK:  - Properties
    
    private let registerView = RegisterView()
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
        registerView.plusPhotoButton.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        registerView.alreadyHaveAccountButton.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    }
    //MARK: - Selectors
    @objc func handleAddProfilePhoto() {
        
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
}
