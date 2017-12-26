//
//  HotCell.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/1.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import Kingfisher
class HotCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    /// 头像
    var iconImageView = UIImageView()
    /// 名字
    var nameLabel = UILabel()
    /// 所在城市
    var cityLable = UILabel()
    /// 在线人数
    var onLineLabel = UILabel()
    /// 封面
    var coverImageView = UIImageView()
    /// 直播logo
    var logoImageView = UIImageView()
    
    var dateLabel = UILabel()
    
    var portrait = ""
    
    /// 设置数据
    func setModel(model:HotModel) {
        if !model.portrait.contains("http://img2.inke.cn/") {
           portrait = String(format: "http://img2.inke.cn/%@", model.portrait)
        }else{
            portrait = model.portrait
        }
        coverImageView.kf.setImage(with: URL(string: portrait), placeholder: #imageLiteral(resourceName: "live_empty_bg"))
        iconImageView.kf.setImage(with: URL(string: portrait), placeholder:#imageLiteral(resourceName: "default_head"))
        nameLabel.text = model.nick
        cityLable.text = model.city
        if model.city.characters.count == 0 {
            cityLable.text = "难道在火星"
        }
        onLineLabel.text = model.online_users
        
    }

    var model:HotModel? {
        didSet{
           
            coverImageView.kf.setImage(with: URL(string: (model?.portrait)!), placeholder: UIImage(named: "live_empty_bg"))
            
            iconImageView.kf.setImage(with: URL(string: (model?.portrait)!), placeholder:UIImage(named: "default_head"))
            nameLabel.text = model?.nick
            cityLable.text = model?.city
            if model?.city.characters.count == 0 {
                cityLable.text = "难道在火星"
            }
            onLineLabel.text = model?.online_users
            
            
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func createUI() {
        iconImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(iconImageView)
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 45 / 2
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.contentView).offset(5)
            make.height.width.equalTo(45)
        }
        
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .gray
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.top)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.width.equalTo(200)
        }
        
        cityLable.textColor = .gray
        cityLable.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(cityLable)
        cityLable.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.left.equalTo(nameLabel.snp.left)
            make.height.equalTo(nameLabel.snp.height)
            make.width.equalTo(100)
        }
        
        onLineLabel.textAlignment = NSTextAlignment.right
        onLineLabel.font = UIFont.systemFont(ofSize: 15)
        onLineLabel.textColor = .orange
        self.contentView.addSubview(onLineLabel)
        onLineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.top)
            make.right.equalTo(self.contentView).offset(-10)
            make.width.equalTo(70)
            make.height.equalTo(45)
        }
        

//        coverImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(coverImageView)
        coverImageView.backgroundColor = .cyan
        coverImageView.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(self.contentView.width).multipliedBy(1.3)
            make.bottom.equalTo(self.contentView).inset(10)
        }
        
        logoImageView.image = #imageLiteral(resourceName: "live_tag_live")
        logoImageView.contentMode = .scaleAspectFit
        coverImageView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.width.equalTo(logoImageView.snp.height).multipliedBy(1.3)
        }
    }
}




