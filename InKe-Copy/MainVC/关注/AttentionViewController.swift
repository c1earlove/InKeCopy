//
//  AttentionViewController.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/1.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class AttentionViewController: UIViewController {

    lazy var shareView:CustomerShareView = {
        let share = CustomerShareView(frame: CGRect(x: 0, y: 0 , width: kScreenWidth, height: kScreenHeight))
        return share
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        // Do any additional setup after loading the view.
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 80, height: 80)
        button.setTitle("退出登陆", for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(cllick), for: .touchUpInside)
        
    }

    @objc func cllick() {
//            ShareSDK.cancelAuthorize(.typeQQ)
        shareView.shareViewShow()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
