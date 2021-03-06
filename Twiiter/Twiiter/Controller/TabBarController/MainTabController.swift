//
//  MainTabController.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit
import Then
import Firebase

final class MainTabController: UITabBarController {
    //MARK: - Properties
    lazy var actionButton = UIButton(type: .system).then { button in
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleActionButtonTapped), for: .touchUpInside)
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        updateUI()
        checkIfUserIsLoggedIn()
    }
    
    //MARK: - API
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser ==  nil  {
            DispatchQueue.main.async {
                let controller = LoginViewContoller()
                let  navigation = UINavigationController(rootViewController: controller)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true, completion:  nil)
            }
        }
    }
    
    //MARK: - Selectors
    @objc func handleActionButtonTapped() {
        print("DEBUG: actionbutton tapped ...")
    }
    //MARK:  - UI관련
    private func configureViewControllers() {
        let feed = tempateNavigationController(unselectedImage: UIImage(named: "home_unselected"), selectedImage: UIImage(named: "home_selected"),  rootViewController: FeedController())
        let explore = tempateNavigationController(unselectedImage: UIImage(named: "search_unselected"), selectedImage: UIImage(named: "search_selected"),  rootViewController: ExploreController())
        let notifications = tempateNavigationController(unselectedImage: UIImage(named: "like_unselected"), selectedImage: UIImage(named: "like_selected"), rootViewController: NotificationController())
        let conversations = tempateNavigationController(unselectedImage: UIImage(named: "mail_unselected"), selectedImage: UIImage(named: "mail_selected"),  rootViewController: ConversationsController())
        
        viewControllers = [feed, explore, notifications, conversations]
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .purple
        self.overrideUserInterfaceStyle =  .light
    }
    //MARK: - tabbar 의 이미지가 선택 되었을때랑 안선택 되었을때 이미지 선택 해주는 함수
    func tempateNavigationController(unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        return navigation
    }
    
    private func updateUI() {
        configureUI()
    }
    
    private func configureUI() {
        setActionButton()
    }
    
    private func setActionButton() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                            paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius =  56 / 2
    }
}
