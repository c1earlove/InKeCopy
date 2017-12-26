//
//  NearbyViewController.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/1.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class NearbyViewController: UIViewController {

    let flag = "flag"
    
    lazy var dataArr = [HotModel]()
    
    lazy var collectionView : UICollectionView = {
        let layout = CustomerFlowLayout()
        let collecView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kTopHeight - kTabBarHeight), collectionViewLayout: layout)
        collecView.backgroundColor = UIColor.white
        return collecView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NearbyCell.self, forCellWithReuseIdentifier: flag)
        
        loadData()
        let gifHeader = CustomerRefreshGifHeader()
        collectionView.mj_header = gifHeader
        gifHeader.refreshGifHeader {
            self.loadData()
        }
        
    }

    func loadData() {
        NetTool.shared.getRequest(url: kNearAPI, params: [:], success: { (result) in
            let listArr:[[String:AnyObject]] = (result["flow"] as? Array)!
            for dic in listArr {
                var model = HotModel()
                let infoDic = dic["info"] as! NSDictionary
                model.city = infoDic["city"]! as! String
                model.creator = infoDic["creator"] as? NSDictionary
                let portrait = model.creator!["portrait"]! as! String
                if !portrait.contains("http://img2.inke.cn/") {
                    model.portrait = String(format: "http://img2.inke.cn/%@", portrait)
                }else{
                    model.portrait =  portrait
                }
                
                let allkey:[String] = infoDic.allKeys as! [String]
                let b = allkey.contains(where: {  $0 == "distance"
                })
              
                if b {
                    model.distance = infoDic["distance"]! as! String
                }
                
                model.nick = model.creator!["nick"]! as! String
                model.share_addr = infoDic["share_addr"]! as! String
                model.stream_addr = infoDic["stream_addr"]! as! String
               
                self.dataArr.append(model)
            }
            self.collectionView.reloadData()
            self.collectionView.mj_header.endRefreshing()
        }) { (error) in
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NearbyViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: flag, for: indexPath) as! NearbyCell
        cell.model = self.dataArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model:HotModel = dataArr[indexPath.row]
        let vc = LiveingViewController()
        vc.portraitUrl = model.portrait
        vc.liveingUrl = model.stream_addr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


