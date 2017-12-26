//
//  CustomerRefreshGifHeader.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/6.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import MJRefresh
class CustomerRefreshGifHeader: MJRefreshGifHeader {

    
    /// 图片数组
    private var refreshImages = [UIImage]()
    
    /// 闲置数组
    private var idleArr = [UIImage]()
    
    func refreshGifHeader(handler:@escaping() -> ()) {
        //隐藏两个控件
        self.lastUpdatedTimeLabel.isHidden = true
        self.stateLabel.isHidden = true
        
        for i in 1 ..< 30 {
            let name = String(format: "refresh_fly_00%d", i)
            refreshImages.append(UIImage(named: name)!)
        }
        // 设置图片 状态为正在刷新
        self.setImages(refreshImages, for: .refreshing)
        for i in 22 ..< 29 {
            let name = String(format: "refresh_fly_00%d", i)
            idleArr.append(UIImage(named: name)!)
        }
        self.setImages(idleArr, for: .idle)
        // 松开开始刷新
        self.setImages(idleArr, for: .pulling)
        
        self.refreshingBlock = {
            handler()
        }
    }
    
    

}
