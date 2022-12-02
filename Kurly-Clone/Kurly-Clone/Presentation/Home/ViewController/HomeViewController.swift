//
//  HomeViewController.swift
//  Kurly-Clone
//
//  Created by 강윤서 on 2022/11/28.
//

import UIKit

import SnapKit
import Then

class HomeViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
    private let deviceWidth = UIScreen.main.bounds.width
    private lazy var scrollViewWidth = scrollView.frame.width
    private lazy var scrollViewHeight = scrollView.frame.height
    private var tabBarIndex = 0
    private var tabList = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "특가/혜택"]
    
    // MARK: - UI Components
    private let headerView = HeaderView("컬리 홈")
    private var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 56, height: 44)
        layout.minimumInteritemSpacing = 14
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    private let scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
    }
    private let recommendViewController = RecommendViewController()
    private let newProductViewController = NewProductViewController()
    private let bestViewController = BestViewController()
    private let shoppingViewController = ShoppingViewController()
    private let saleViewController = SaleViewController()
    private let indicatorView = UIView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setScrollView()
        register()
    }
}

extension HomeViewController {
    private func register() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.register(TabCollectionViewCell.self,
                                    forCellWithReuseIdentifier: TabCollectionViewCell.identifier)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        indicatorView.backgroundColor = .main
    }
    
    private func setLayout() {
        view.addSubviews(headerView, menuCollectionView, scrollView, indicatorView)
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(92)
        }
        
        menuCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.height.equalTo(44)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(menuCollectionView.snp.bottom)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.bottom.equalTo(scrollView.snp.top)
            $0.height.equalTo(2)
            $0.width.equalTo(56)
        }
    }
    
    private func setScrollView() {
        scrollView.delegate = self
        scrollView.contentSize.width = deviceWidth * 5
        scrollView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
    
        [recommendViewController, newProductViewController, bestViewController, shoppingViewController, saleViewController].forEach {
            self.addChild($0)
        }
        
        guard let recommendView = recommendViewController.view else {return}
        recommendView.frame = CGRect(x: 0, y: 0, width: scrollViewWidth, height: scrollViewHeight)
        
        guard let newProductView = newProductViewController.view else {return}
        newProductView.frame = CGRect(x: deviceWidth, y: 0, width: scrollViewWidth, height: scrollViewHeight)
        
        guard let bestView = bestViewController.view else {return}
        bestView.frame = CGRect(x: deviceWidth * 2, y: 0, width: scrollViewWidth, height: scrollViewHeight)
        
        guard let shoppingView = shoppingViewController.view else {return}
        shoppingView.frame = CGRect(x: deviceWidth * 3, y: 0, width: scrollViewWidth, height: scrollViewHeight)
        
        guard let saleView = saleViewController.view else {return}
        saleView.frame = CGRect(x: deviceWidth * 4, y: 0, width: scrollViewWidth, height: scrollViewHeight)
        
        scrollView.addSubviews(recommendView, newProductView, bestView, shoppingView, saleView)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.identifier, for: indexPath) as? TabCollectionViewCell else {return UICollectionViewCell()}
        indexPath.row != tabBarIndex ? cell.setStatus(name: tabList[indexPath.row], isTouched: false) : cell.setStatus(name: tabList[indexPath.row], isTouched: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tabBarIndex = indexPath.row
        
        switch indexPath.row {
        case 0:
            scrollView.setContentOffset(CGPoint.zero, animated: true)
        case 1:
            scrollView.setContentOffset(CGPoint(x: deviceWidth, y: 0 ), animated: true)
        case 2:
            scrollView.setContentOffset(CGPoint(x: deviceWidth * 2, y: 0), animated: true)
        case 3:
            scrollView.setContentOffset(CGPoint(x: deviceWidth * 3, y: 0), animated: true)
        case 4:
            scrollView.setContentOffset(CGPoint(x: deviceWidth * 4, y: 0), animated: true)
        default:
            break
        }
        menuCollectionView.reloadData()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / deviceWidth)
        
        switch page {
        case 0:
            tabBarIndex = 0
        case 1:
            tabBarIndex = 1
        case 2:
            tabBarIndex = 2
        case 3:
            tabBarIndex = 3
        case 4:
            tabBarIndex = 4
        default:
            break
        }
        menuCollectionView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tabWidth = (deviceWidth - 60) / 5
        
        indicatorView.snp.updateConstraints {
            $0.leading.equalToSuperview().offset( (self.scrollView.contentOffset.x / deviceWidth) * tabWidth + 28)
        }
    }
}
