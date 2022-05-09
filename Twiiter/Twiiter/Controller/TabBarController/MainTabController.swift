//
//  MainTabController.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit

final class MainTabController: UITabBarController {
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        
    }
    
    //MARK:  - UI관련
   private func configureViewControllers() {
       let feed = tempateNavigationController(unselectedImage: UIImage(named: "home_unselected"), selectedImage: UIImage(named: "home_selected"), rootViewController: FeedController())
       let explore = tempateNavigationController(unselectedImage: UIImage(named: "search_unselected"), selectedImage: UIImage(named: "search_selected"), rootViewController: ExploreController())
       let notifications = tempateNavigationController(unselectedImage: UIImage(named: "like_unselected"), selectedImage: UIImage(named: "like_selected"), rootViewController: NotificationController())
       let conversations = tempateNavigationController(unselectedImage: UIImage(named: "mail_unselected"), selectedImage: UIImage(named: "mail_selected"), rootViewController: ConversationsController())
       
       viewControllers = [feed, explore, notifications, conversations]
       tabBar.tintColor = .black
       tabBar.backgroundColor = .white
       tabBar.barTintColor = .purple
       
    }
    //MARK: - tabbar 의 이미지가 선택 되었을때랑 안선택 되었을때 이미지 선택 해주는 함수
    func tempateNavigationController(unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        return navigation
    }
}
