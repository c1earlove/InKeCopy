//
//  NearbyCell.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/6.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class NearbyCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 背景大图
    var userBackImageV = UIImageView()
    
    /// 用户头像
    var userLogoImagV = UIImageView()
    
    /// 距离
    var distanceLabel = UILabel()
    
    /// 在线人数
    var onLineCountLable = UILabel()
    /// 距离图标
    var distanceImageView = UIImageView()
    
    
    var model:HotModel? {
        didSet{
            userLogoImagV.kf.setImage(with: URL(string: (model?.portrait)!), placeholder:UIImage(named: "default_head"))
            userBackImageV.kf.setImage(with: URL(string: (model?.portrait)!), placeholder:UIImage(named: "live_empty_bg"))
            onLineCountLable.text = String(format: "%d人", arc4random_uniform(200)+arc4random_uniform(500))
            distanceLabel.text = String(format: " %@ ", (model?.distance)!)
        }
    }
    
    
    
    func createUI() {
        self.contentView.addSubview(userBackImageV)
        self.contentView.addSubview(userLogoImagV)
        self.contentView.addSubview(distanceLabel)
        self.contentView.addSubview(onLineCountLable)
        self.contentView.addSubview(distanceImageView)
        
        userBackImageV.backgroundColor = UIColor.cyan
        userBackImageV.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).inset(30)
        }
        userLogoImagV.clipsToBounds = true
        userLogoImagV.backgroundColor = UIColor.red
        userLogoImagV.layer.cornerRadius = 45 / 2
        userLogoImagV.snp.makeConstraints { (make) in
            make.width.height.equalTo(45)
            make.left.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).inset(5)
        }
        
        onLineCountLable.textColor = UIColor.orange
        onLineCountLable.text = "1232214"
        onLineCountLable.font = UIFont.systemFont(ofSize: 12)
        onLineCountLable.snp.makeConstraints { (make) in
            make.left.equalTo(userLogoImagV.snp.right).offset(5)
            make.bottom.equalTo(userLogoImagV)
            make.top.equalTo(userBackImageV.snp.bottom).offset(5)
        }
        
        distanceLabel.textColor = UIColor.gray
        distanceLabel.font = UIFont.systemFont(ofSize: 12)
        distanceLabel.layer.borderWidth = 0.5
        distanceLabel.text = "100KM"
        distanceLabel.clipsToBounds = true
        distanceLabel.layer.cornerRadius = 6
        distanceLabel.layer.borderColor = kNavColor.cgColor
        distanceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).inset(5)
            make.top.equalTo(onLineCountLable)
            make.bottom.equalTo(onLineCountLable)
        }
        distanceImageView.image = UIImage(named: "distanceImage")
        distanceImageView.snp.makeConstraints { (make) in
            make.right.equalTo(distanceLabel.snp.left).offset(-2)
            make.centerY.equalTo(distanceLabel)
            make.width.equalTo(10)
            make.height.equalTo(15)
        }
        
    }
    
}
