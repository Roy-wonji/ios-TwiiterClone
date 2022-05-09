//
//  SignUpViewController.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit

final class SignUpViewController: UIViewController {
    //MARK:  - Properties
    
    //MARK:  - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //MARK: - Selectors
    
    //MARK:  - UI 관련
    private func updateUI() {
        view.backgroundColor = .twitterBlue
    }
    
    private func configureUI() {
        
    }
}
