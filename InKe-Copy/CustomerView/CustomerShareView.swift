//
//  CustomerShareView.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/18.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

// MARK: CustomerShareView
class CustomerShareView: UIView {
    
    var collectionView:UICollectionView?
    var info = ["QQ空间":"login_ico_mobile","QQ":"login_ico_qq","微信":"login_ico_wechat","新浪微博":"login_ico_weibo"]
    
    var sourceArr = [shareModel]()
    let flag = "flag"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.color(withFatherAlpha: 0.6, color: UIColor.gray)
        createUI()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(shareCell.self, forCellWithReuseIdentifier: flag)
        for (text,imageName) in info {
            var model = shareModel()
            model.text = text
            model.imageName = imageName
            sourceArr.append(model)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(shareViewTap(_:)))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    func createUI() {
        let layout = UICollectionViewFlowLayout()
        let sapce:CGFloat = 2
        let count = 4
        layout.minimumLineSpacing = sapce
        layout.minimumInteritemSpacing = sapce
        let widthq = (self.width - (CGFloat(count) - 1) * sapce) / CGFloat(count)
        
        layout.itemSize = CGSize(width: widthq, height: widthq)
        collectionView = UICollectionView(frame: CGRect(x: 0, y:self.height - 200 , width: self.width, height:200 ), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        self.addSubview(collectionView!)
    }
    
    @objc func shareViewTap(_ tap:UITapGestureRecognizer) {
        let point:CGPoint = tap.location(in: self)
        if point.y < self.height - 200 {
            shareViewDismiss()
        }

    }

}

extension CustomerShareView : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self {
            return true
        }
        return false
    }
}
extension CustomerShareView : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: flag, for: indexPath) as! shareCell
        cell.model = sourceArr[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setShareParameters(tag: indexPath.row)
        
    }
}


extension CustomerShareView {
    func setShareParameters(tag:Int) {
        let dic = NSMutableDictionary()
        dic.ssdkSetupShareParams(byText: "分享内容撒发生里UI我却抛弃无交了你人情味让客户你请我没人飞回去月底回去我看了；ejqwoirqwjmr/wwqlh.ncsb", images: UIImage(named: "porsche"), url: URL(string: "www.baidu.com"), title: "测试分享", type: SSDKContentType.auto)
        var platformType:SSDKPlatformType?
        if tag == 0 { // QZone
            platformType = SSDKPlatformType.subTypeQZone
        } else if tag == 1 { // QQ
            platformType = SSDKPlatformType.typeQQ
        } else if (tag == 2) { //微信
            platformType = SSDKPlatformType.typeWechat
        } else if (tag == 3) { // 新浪微博
            platformType = SSDKPlatformType.typeSinaWeibo
        }
        ShareSDK.share(platformType!, parameters: dic) { (state, nil, entity:SSDKContentEntity?, error) in
            switch state{
                
            case SSDKResponseState.success:
           
                CRMLog("分享成功")
            case SSDKResponseState.fail:
             
                CRMLog("授权失败,错误描述:\(String(describing: error))")
            case SSDKResponseState.cancel:
                print("操作取消")
                
            default:
                break
            }
        }
    }
    
    func shareViewShow() {
        
        UIView.animate(withDuration: 0.3, animations: {
            kMainWindow?.addSubview(self)
        }) { (_) in
            
        }
        
    }
    func shareViewDismiss() {
        UIView.animate(withDuration: 0.4, animations: {
            
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}

class shareCell: UICollectionViewCell {
    
    var button:UIButton!
    
    var imageLogo:UIImageView!
    var titleLabel:UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    var model:shareModel? {
        didSet{
            imageLogo.image = UIImage(named: (model?.imageName)!)
            titleLabel.text = model?.text
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {

        imageLogo = UIImageView()
        self.contentView.addSubview(imageLogo)
        imageLogo.contentMode = .scaleAspectFit
        imageLogo.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.centerX.equalTo(self)
            make.left.right.equalTo(5)
        }
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageLogo.snp.bottom).offset(5)
            make.left.right.equalTo(imageLogo)
            make.bottom.equalTo(5)
        }
    }
}
struct shareModel {
    var text = ""
    var imageName = ""
}
