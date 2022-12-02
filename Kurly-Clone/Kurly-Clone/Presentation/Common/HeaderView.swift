//
//  HeaderView.swift
//  Kurly-Clone
//
//  Created by 강윤서 on 2022/11/29.
//

import UIKit

import SnapKit
import Then

class HeaderView: UIView {
    
    // MARK: UI Components
    private let naviTitle = UILabel()
    private let locationButton = UIButton()
    private let cartButton = UIButton()
    
    init(_ title: String) {
        super.init(frame: .zero)
        naviTitle.text = title
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderView {
    private func setUI() {
        backgroundColor = .main
        naviTitle.do {
            $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            $0.textColor = .white
        }
        
        locationButton.setImage(.cart, for: .normal)
        cartButton.setImage(.location, for: .normal)
    }
    
    private func setLayout() {
        addSubviews(naviTitle, locationButton, cartButton)
        
        naviTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        cartButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-12)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        locationButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-12)
            $0.trailing.equalTo(cartButton.snp.leading).offset(-12)
        }
    }
}
