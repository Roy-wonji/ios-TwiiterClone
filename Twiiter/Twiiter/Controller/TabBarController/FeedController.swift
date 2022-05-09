//
//  FeedController.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit


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
    }
    //MARK: - UI바에 이미지 설정
    private func setNavigaionBarImage() {
        let imageVIew = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageVIew.contentMode = .scaleAspectFit
        navigationItem.titleView = imageVIew
    }
}
