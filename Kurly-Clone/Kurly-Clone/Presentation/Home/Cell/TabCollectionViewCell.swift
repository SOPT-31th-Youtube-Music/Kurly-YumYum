//
//  TabCollectionViewCell.swift
//  Kurly-Clone
//
//  Created by 강윤서 on 2022/12/01.
//

import UIKit

import SnapKit
import Then

class TabCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static var identifier = "TabCollectionViewCell"
    
    // MARK: - UI Components
    private let tabLabel = UILabel()
    private let indicatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabCollectionViewCell {
    private func setUI() {
        tabLabel.do {
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = .darkGray
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(tabLabel, indicatorView)
        
        tabLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setStatus(name: String, isTouched: Bool) {
        tabLabel.textColor = isTouched ? .main : .darkGray
        tabLabel.font = isTouched ? .systemFont(ofSize: 14, weight: .bold) : .systemFont(ofSize: 14, weight: .medium)
        tabLabel.text = name
    }
}
