//
//  FeedController.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit
import Firebase

final class FeedController: UIViewController {
    //MARK: - Properties
    
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    //MARK: - UI관련
    private  func updateUI() {
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        setNavigaionBarImage()
        naviagationTabBar()
    }
    
    func naviagationTabBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title:  "logout", style: .plain,
            target: self, action: #selector(handleLogOut))
        navigationItem.title = "Feed"
        tabBarController?.tabBar.barTintColor = .backgroundColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.defaultLabelColor]
    }
    
    //MARK: - Actions
    @objc func handleLogOut() {
        do {
            try Auth.auth().signOut()
            let controller = LoginViewContoller()
            let  navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true, completion:  nil)
        } catch { print("DEBUG:  Falied  to  sign  out") }
    }
    //MARK: - UI바에 이미지 설정
    private func setNavigaionBarImage() {
        let imageVIew = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageVIew.contentMode = .scaleAspectFit
        navigationItem.titleView = imageVIew
    }
}
