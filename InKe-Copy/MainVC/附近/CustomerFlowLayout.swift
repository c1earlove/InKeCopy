//
//  CustomerFlowLayout.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/6.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class CustomerFlowLayout: UICollectionViewFlowLayout {

    /// 默认列数
    private var columnCountDefault:Int = 2
    
    /// 每列的默认间距
    private var columnMarginDefault:CGFloat = 2
    
    /// 每一行之间的间距
    private(set) var itemMargin : CGFloat = 0
    /// 默认边缘间距
    private var edgeInsetsDefault:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    
    /// 存放所有Cell的布局属性
    lazy var attrsArr = [UICollectionViewLayoutAttributes]()
    
    /// 存放所有列的当前高度
    lazy var columnHeightsArr = [CGFloat]()
    
    /// 第一步 初始化
    override func prepare() {
        super.prepare()
        
        //清除高度
        columnHeightsArr.removeAll()
        for _ in 0 ..< columnCountDefault {
            columnHeightsArr.append(edgeInsetsDefault.top)
        }
        // 清除所有的布局属性
        attrsArr.removeAll()
        let sections:Int = (self.collectionView?.numberOfSections)!
        
        for num in 0 ..< sections {
            // 获取每个分组的item数量
            let count:Int = (self.collectionView?.numberOfItems(inSection: num))!
            for i in 0 ..< count {
                let indexPath:IndexPath = IndexPath(item: i, section: num)
                let attrs = self.layoutAttributesForItem(at: indexPath)
                attrsArr.append(attrs!)
            }
        }
    }
    
    // 第二步 返回indexPath位置Cell对呀的布局属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let collectionWidth = self.collectionView?.width
        // 获得所有item的宽度
        let width_all = (collectionWidth! - edgeInsetsDefault.left - edgeInsetsDefault.right - CGFloat(columnCountDefault - 1) * columnMarginDefault) / CGFloat(columnCountDefault)
        let height_all = arc4random_uniform(50) + 250
        
        //找出高度最短的一列
        var dextColum:Int = 0
        var mainH = columnHeightsArr[0]
        for i in 1 ..< columnCountDefault {
            // 取出第i列的高度
            let columnH = columnHeightsArr[i]
            if mainH > columnH {
                mainH = columnH
                dextColum = i
            }
        }
        let x = edgeInsetsDefault.left + CGFloat(dextColum) * (width_all + columnMarginDefault)
        var y = mainH
        if y != edgeInsetsDefault.top {
            y = y + itemMargin
        }
        attrs.frame = CGRect(x: x, y: y, width: width_all, height: CGFloat(height_all))
        //更新最短的那列高度
        columnHeightsArr[dextColum] = attrs.frame.maxY
        return attrs
    }
    
    /// 第三步 返回所有列的高度
    override var collectionViewContentSize: CGSize {
        var maxHeight = columnHeightsArr[0]
        for i in 1 ..< columnCountDefault {
            let columnHeight = columnHeightsArr[i]
            if maxHeight < columnHeight {
                maxHeight = columnHeight
            }
        }
        return CGSize(width: 0, height: maxHeight + edgeInsetsDefault.bottom)
    }
    ///第四步 ：返回collection的item的frame
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArr
    }

}
