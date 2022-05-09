//
//  RegisterView.swift
//  Twiiter
//
//  Created by 서원지 on 2022/05/09.
//

import UIKit
import Then

final class RegisterView: UIView {
    //MARK:  - Properties
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        updateView()
        updateConstraints()
    }
    
    private func updateView() {
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Selectors
    
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints() {
        
    }
}
