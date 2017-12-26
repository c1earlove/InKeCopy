//
//  ADViewController.swift
//  MAPTEST
//
//  Created by clearlove on 2017/12/8.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class ADViewController: UIViewController {
    /// 广告页的URLString
    var adUrl = ""
    /// 跳转的标识 push / present
    var transFlag = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNav(flag: transFlag)
        var y:CGFloat = 0
        if transFlag == "push" {
           y = 0
        } else {
            y = kTopHeight
        }
        let web = UIWebView(frame: CGRect(x: 0, y: y, width: kScreenWidth, height: kScreenHeight))
        web.loadRequest(URLRequest(url: URL(string: adUrl)!))
        view.addSubview(web)
        
        // Do any additional setup after loading the view.
    }
  
    func createNav(flag:String) {
        if flag == "push" {
            let button = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
            self.navigationItem.leftBarButtonItem = button
        } else {
            let navView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kTopHeight))
            navView.backgroundColor = kNavColor
            view.addSubview(navView)
            let button = UIButton(frame: CGRect(x: 10, y: kStatuBarHeight, width: 44, height: 44))
            button.setTitle("返回", for: .normal)
            navView.addSubview(button)
            button.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        }
    }
    
    @objc func backClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
