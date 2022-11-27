//
//  TabBarItem.swift
//  Kurly-Clone
//
//  Created by 강윤서 on 2022/11/28.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case home
    case category
    case search
    case mypage
}

extension TabBarItemType {
    var icon: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house")!
        case .category:
            return UIImage(systemName: "line.3.horizontal")!
        case .search:
            return UIImage(systemName: "magnifyingglass")!
        case .mypage:
            return UIImage(systemName: "person")!
        }
    }
    
    func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: nil,
                            image: icon,
                            selectedImage: nil)
    }
}
