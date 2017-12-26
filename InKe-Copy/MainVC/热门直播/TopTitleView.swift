//
//  TopTitleView.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/1.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit


typealias titleClickHandler = (_ tag:Int) -> ()

class TopTitleView: UIView {
    
    /// 三个项目
    lazy var titleArr = ["关注","热门","附近"]
    
    var handler:titleClickHandler?
    
    /// button下的line
    lazy var lineImageView:UIImageView = {
       let line = UIImageView()
        line.backgroundColor = .yellow
        return line
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    func createUI() {
        let buttonWidth:CGFloat = self.width / CGFloat(titleArr.count)
        
        for i in 0 ..< titleArr.count {
            let button = UIButton().button(title: titleArr[i], textColor: .white, textFont: UIFont.systemFont(ofSize: 18), tag: 50 + i, frame: CGRect(x: CGFloat(i) * buttonWidth, y: 0, width: buttonWidth, height: 44))
            
            button.addTarget(self, action: #selector(titleViewButtonClick(button:)), for: .touchUpInside)
            self.addSubview(button)
            
            if i == 1 {
                button.titleLabel?.sizeToFit()
                lineImageView.frame = CGRect(x: buttonWidth, y: 40, width: (button.titleLabel?.width)!, height: 3)
                lineImageView.centerX = button.centerX
                self.addSubview(lineImageView)
            }
        }
    }
    
    func scrollMove(tag:Int) {
        UIView.animate(withDuration: 0.3) {
            let button:UIButton = self.viewWithTag(tag) as! UIButton
            
           self.lineImageView.centerX = button.centerX
        }
        
    }
    
    @objc func titleViewButtonClick(button:UIButton) {
        
        scrollMove(tag: button.tag)
        handler!(button.tag)
    }

}
