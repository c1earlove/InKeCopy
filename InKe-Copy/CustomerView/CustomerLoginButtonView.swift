//
//  CustomerLoginButtonView.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/13.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

typealias loginButtonClickHandler = (_ tag:Int) -> ()
class CustomerLoginButtonView: UIView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    /// 按钮回调
    var loginButtonClickHandler:loginButtonClickHandler?
    
    /// buttonimageName
    private let buttonImageNameArr = ["login_ico_weibo","login_ico_wechat","login_ico_mobile","login_ico_qq"]
    private let buttonW:CGFloat = 60
    
    
    private func setupUI() {
        
        let loginLabel = UILabel()
        loginLabel.text = "选择登陆方式"
        loginLabel.textColor = UIColor.lightGray
        loginLabel.backgroundColor = UIColor(red: 0.92, green: 0.97, blue: 0.99, alpha: 1)
        loginLabel.textAlignment = .center
        loginLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { (make) in
            make.top.equalTo(2)
            make.centerX.equalTo(self)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        let line = UIView()
        line.backgroundColor = UIColor.black
        self.insertSubview(line, belowSubview: loginLabel)
        line.snp.makeConstraints { (make) in
            make.height.equalTo(0.8)
            make.centerY.equalTo(loginLabel)
            make.left.equalTo(20)
            make.right.equalTo(self).offset(-10)
        }
        
        let gap:CGFloat = (self.width - 4 * buttonW) / 5
        for i in 0 ..< buttonImageNameArr.count {
            let button = UIButton(type: .custom)
            button.setBackgroundImage(UIImage(named: buttonImageNameArr[i]), for: .normal)
            button.frame = CGRect(x:gap + (gap +  buttonW) * CGFloat(i) , y: loginLabel.maxY, width: buttonW, height: buttonW)
            button.centerY = self.height / 2
            button.tag = i + 10
            button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
            self.addSubview(button)
        }
        
        let protroclLabel = UILabel()
        self.addSubview(protroclLabel)
        protroclLabel.font = UIFont.systemFont(ofSize: 10)
        protroclLabel.textAlignment = .center
        protroclLabel.text = "登录即代表你同意映客服务和隐私条款"
        protroclLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.left.right.equalTo(self)
        }
        let text = protroclLabel.text! as NSString
        
        let abs = NSMutableAttributedString(string: protroclLabel.text! as String)
        abs.beginEditing()
        abs.addAttribute(NSAttributedStringKey.foregroundColor,value: kNavColor, range: NSMakeRange(8, text.length - 8))
        // 需要rawValue将int转为nsnumber类型
    abs.addAttribute(NSAttributedStringKey.underlineStyle,value:NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(8, text.length - 8))
        protroclLabel.attributedText = abs
        abs.endEditing()
    }
    
    @objc private func buttonClick(_ button:UIButton) {
        if loginButtonClickHandler != nil {
            loginButtonClickHandler!(button.tag)
        }
    }
}

