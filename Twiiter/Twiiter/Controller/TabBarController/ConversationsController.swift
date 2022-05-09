//
//  ConversationsController.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit

final class ConversationsController: UIViewController {
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    //MARK: - UI관련
    private  func updateUI() {
      configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = . white
        setNavigaionBar()
        
    }
    //MARK: - UI바 설정 관련
   private func setNavigaionBar() {
       navigationItem.title = NavigationText.conversationNavigationText
    }
}
