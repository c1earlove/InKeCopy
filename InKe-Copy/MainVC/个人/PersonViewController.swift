//
//  PersonViewController.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/11/29.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {

    lazy var titleLabel:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        label.text = "个人中心"
        return label
    }()
    
    let headViewHeight = kScreenHeight / 3
    
    lazy var tableView:UITableView = {
        let tab = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kTopHeight), style: .plain)
        tab.showsVerticalScrollIndicator = false
        return tab
    }()
    
    lazy var headerView:UIImageView = {
       let imgview = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: headViewHeight))
        imgview.image = UIImage(named: "person_head")
        return imgview
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = titleLabel
        tableView.delegate = self;
        tableView.dataSource = self;
  
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
//            tableView.estimatedSectionFooterHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(tableView)
//        self.tableView.addSpringHead(headerView)
        tableView.addSpringHeadView(headerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offY = scrollView.contentOffset.y
        if offY < 0 {
            self.navigationController?.navigationBar.alpha = 0
        }else{
            self.navigationController?.navigationBar.alpha = 1
        }
        CRMLog(offY)
    }
}


extension PersonViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "flag")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "flag")
        }
        cell?.textLabel?.text = "000\(indexPath.row)"
        return cell!
    }
}

