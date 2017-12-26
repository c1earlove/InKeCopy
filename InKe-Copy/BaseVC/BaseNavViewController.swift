//
//  BaseNavViewController.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/11/29.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class BaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        UINavigationBar *bar = [UINavigationBar appearance];
//        bar.barTintColor = [UIColor colorWithRed:62/255.0 green:173/255.0 blue:176/255.0 alpha:1.0];
//        [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//        [UIColor colorWithRed:0.00f green:0.85f blue:0.79f alpha:1.00f];
        
        
        let bar = UINavigationBar.appearance()
        bar.barTintColor = kNavColor
        let attribute = [NSAttributedStringKey.foregroundColor:UIColor.white]
        bar.titleTextAttributes = attribute
        
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super .pushViewController(viewController, animated: true)
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
