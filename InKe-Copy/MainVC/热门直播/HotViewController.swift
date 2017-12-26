//
//  HotViewController.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/1.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class HotViewController: UIViewController {

    lazy var tableView:UITableView = {
       let table = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kTopHeight - kTabBarHeight), style: .plain)
        table.separatorStyle = .none
        return table
    }()
    
     var dataArr = [HotModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // 设置大概行高
        tableView.estimatedRowHeight = 10
        // 设置行高为自动适配 iOS 8之后默认 可以省略不写
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(HotCell.self, forCellReuseIdentifier: "flag")
        loadData()
    }

    func loadData()  {
        NetTool.shared.getRequest(url: "http://service.inke.com/api/live/simpleall?uid=139587564", params: [:], success: { (result) in
            let listArr:[[String:AnyObject]] = (result["lives"] as? Array)!
            for dic in listArr {
                var model = HotModel()
                model.city = dic["city"]! as! String
                model.creator = dic["creator"] as? NSDictionary
                let portrait = model.creator!["portrait"]! as! String
                if !portrait.contains("http://img2.inke.cn/") {
                    model.portrait = String(format: "http://img2.inke.cn/%@", portrait)
                }else{
                     model.portrait =  portrait
                }
                model.online_users = "\(dic["online_users"]!)"
                model.nick = model.creator!["nick"]! as! String
                model.share_addr = dic["share_addr"]! as! String
                model.stream_addr = dic["stream_addr"]! as! String
                self.dataArr.append(model)
                if self.dataArr.count > 10 {
                    break
                }
            }
            self.tableView.reloadData()
        }) { (error) in
            CRMLog(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        tableView.delegate = nil
        tableView.dataSource = nil
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension HotViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:HotModel = dataArr[indexPath.row]
        
        let vc = LiveingViewController()
        vc.portraitUrl = model.portrait
        vc.liveingUrl = model.stream_addr
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layer.removeAllAnimations()
        cell.layer.transform = CATransform3DMakeScale(0.3, 0.3, 1)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }, completion: { (_) in
            
//            @"pageCurl "                       向上翻一页
//            @"pageUnCurl"                    向下翻一页
//            @"rippleEffect"                     滴水(波纹)效果
//            @"suckEffect"                       收缩效果，如一块布被抽走或者是被吸收
//            @"cube"                                立方体效果
//            @"oglFlip"                             上下翻转效果
//            @"cameraIrisHollowOpen"   镜头开效果
//            @"cameraIrisHollowClose"   镜头关效果
            
            let anim = CATransition()
            anim.type = "rippleEffect"
            anim.duration = 1
            cell.layer.add(anim, forKey: "11")
        })
    }

    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 320
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "flag") as! HotCell
        
        cell.model = dataArr[indexPath.row]
        
        return cell
    }
}

//extension HotViewController {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let pan = scrollView.panGestureRecognizer
//        //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
//        let velocity = pan.velocity(in: scrollView).y
//        if (velocity < -5) {
//            //向上拖动，隐藏导航栏
//            setTabBarHiddn(hiddn: true)
//
//        }else if (velocity > 5) {
//            //向下拖动，显示导航栏
//            setTabBarHiddn(hiddn: false)
//        }else if (velocity == 0) {
//            //停止拖拽
//        }
//
//    }
//    /** true:向上拖动隐藏  false:向下  显示*/
//    fileprivate func setTabBarHiddn(hiddn:Bool) {
//        UIView.animate(withDuration: 0.2, animations: {
//            if hiddn {
//                self.tabBarController?.tabBar.y = kScreenHeight + 25
//                self.tableView.y = 0
//                self.navigationController?.navigationBar.isHidden = true
//
//            }else { //显示
//                self.tabBarController?.tabBar.y = kScreenHeight - (self.tabBarController?.tabBar.height)!
//                self.tableView.y = 0
//                self.navigationController?.navigationBar.isHidden = false
//            }
//        })
//    }
//}


