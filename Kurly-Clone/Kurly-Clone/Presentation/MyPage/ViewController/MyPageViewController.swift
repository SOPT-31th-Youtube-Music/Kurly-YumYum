//
//  MyPageViewController.swift
//  Kurly-Clone
//
//  Created by 강윤서 on 2022/11/28.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // MARK: - UI Components
    private let headerView = HeaderView("마이컬리")
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

extension MyPageViewController {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(headerView)
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(92)
        }
    }
}
