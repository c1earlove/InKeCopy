//
//  BottomView.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/4.
//  Copyright © 2017年 clearlove. All rights reserved.
//

// MARK: 底部工具栏
import UIKit

class BottomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kRGBA(0, 0, 0, 0.1)
        createUI()
    }
    
    /// bottomView的点击事件
    typealias handler = (_ tag:Int) -> ()
    var BottomViewHandler:handler?
    
    
    /// 图片名称数组
    lazy var imageArr = ["mg_room_btn_liao_h","mg_room_btn_liwu_h","mg_room_btn_fenxiang_h"]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func createUI() {
        for i in 0 ..< imageArr.count {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: imageArr[i]), for: .normal)
            button.addTarget(self, action: #selector(bottomClick(_ :)), for: .touchUpInside)
            button.tag = 100 + i
            if i == 0 {
                button.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
            }else{
                button.frame = CGRect(x: kScreenWidth - 180 + CGFloat((i - 1) * 60), y: 10, width: 40, height: 40)
            }
            self.addSubview(button)
        }
    }
    @objc func bottomClick(_ button:UIButton) {
        BottomViewHandler!(button.tag)
    }
}
