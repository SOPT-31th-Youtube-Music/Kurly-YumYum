//
//  TabBarController.swift
//  Kurly-Clone
//
//  Created by 강윤서 on 2022/11/28.
//

import UIKit

class TabBarController: UITabBarController {
    // MARK: Properties
    private var tabs: [UIViewController] = []
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
    }
    
    override func viewWillLayoutSubviews() {
        setTabBarUI()
        setStatusBar(.main)
    }
}

extension TabBarController {
    private func setTabBarItems() {
        tabs = [
            HomeViewController(),
            CategoryViewController(),
            SearchViewController(),
            MyPageViewController()
        ]
        
        TabBarItemType.allCases.forEach {
            tabs[$0.rawValue].tabBarItem = $0.setTabBarItem()
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        tabBar.tintColor = UIColor.main
        setViewControllers(tabs, animated: false)
    }
    
    private func setTabBarUI() {
        tabBar.backgroundColor = .white
    }
    
    func setStatusBar(_ backgroundColor: UIColor) {
        if let window = view.window?.windowScene?.keyWindow {
            let statusBar = window.windowScene?.statusBarManager
            let statusBarView = UIView(frame: statusBar?.statusBarFrame ?? CGRect.zero)
            statusBarView.backgroundColor = backgroundColor
            view.addSubview(statusBarView)
        }
    }
}
