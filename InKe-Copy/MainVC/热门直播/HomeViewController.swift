//
//  HomeViewController.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/11/29.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var titleView:TopTitleView = {
        let v = TopTitleView(frame: CGRect(x: 0, y: 0, width: 240, height: 44))
        v.handler = { [weak self] tag in
                let point = CGPoint(x: CGFloat(tag - 50) * kScreenWidth, y:
                    (self?.homeScrollView.contentOffset.y)!)
            self?.homeScrollView.setContentOffset(point, animated: true)
        }
        return v
    }()
    
    
    /// 控制器array
    var vcArr:[UIViewController] = [UIViewController]()
    
    lazy var homeScrollView:UIScrollView = {
        let scro = UIScrollView(frame: self.view.bounds)
        scro.contentSize = CGSize(width: 3 * kScreenWidth, height: 0)
        scro.contentOffset = CGPoint(x: kScreenWidth, y: 0)
        scro.showsHorizontalScrollIndicator = false
        scro.isPagingEnabled = true
        scro.bounces = false
        scro.delegate = self
        scro.isUserInteractionEnabled = true
        scro.backgroundColor = .white
        return scro
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        self.navigationItem.titleView = titleView
        let leftImage = #imageLiteral(resourceName: "left_search").withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(enterSearchClick))
        let rightImage = #imageLiteral(resourceName: "right_message").withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(messageClick))
        self.view.addSubview(homeScrollView)
        addChildVC()
    }
    
    /// 添加子视图控制器
    func addChildVC() {
        // 关注
        let attenVC = AttentionViewController()
        self.addChildViewController(attenVC)
        // 热门
        let hotVC = HotViewController()
        self.addChildViewController(hotVC)
        // 附近
        let nearbyVC = NearbyViewController()
        self.addChildViewController(nearbyVC)
        
        vcArr.append(attenVC)
        vcArr.append(hotVC)
        vcArr.append(nearbyVC)
        
        for i  in 0 ..< vcArr.count {
            let vc = self.childViewControllers[i]
            vc.view.frame = CGRect(x: CGFloat(i) * kScreenWidth , y: 0, width: kScreenWidth, height: kScreenHeight - kTabBarHeight - kTopHeight)
            homeScrollView.addSubview(vc.view)
        }
        
    }
   
   @objc func enterSearchClick() {
        
    }
   @objc func messageClick() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        titleView.scrollMove(tag: Int(scrollView.contentOffset.y / kScreenWidth + 50))
    }
}


