//
//  PageContentView.swift
//  DYZB
//
//  Created by 伏文东 on 2017/12/9.
//  Copyright © 2017年 伏文东. All rights reserved.
//

import UIKit

protocol pageContentviewDelegate: class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

let contentCellID = "contentCellID"
class PageContentView: UIView {
    
    // MARK:- 定义属性
    var childVcs: [UIViewController]
    weak var parentViewController: UIViewController?
    var startOffsetX: CGFloat = 0
    var isForbidScrollDelefate = false
    weak var delegate: pageContentviewDelegate?
    
    // MARK:- 懒加载属性
    lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- 设置UI界面
extension PageContentView {
    func setupUI()  {
        for childVC in childVcs {
            parentViewController?.addChildViewController(childVC)
            
            
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
// MARK:- 遵守UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVcs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

// MARK:- 遵守UICollectionViewDelegate
extension PageContentView:UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelefate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelefate { return }
        
        // 获取数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex: Int = 0
        
        // 判断是作画还是右划
        let currentOffsetX = scrollView.contentOffset.x
        let scrollviewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
            progress = currentOffsetX / scrollviewW - floor(currentOffsetX / scrollviewW)
            
            // 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollviewW)
            // 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            if currentOffsetX - startOffsetX == scrollviewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右划
            // 计算progress
            progress = 1 - (currentOffsetX / scrollviewW - floor(currentOffsetX / scrollviewW))
            
            // 计算targetIndex
            targetIndex = Int(currentOffsetX / scrollviewW)
            // 计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currextIndex: Int)  {
        
        isForbidScrollDelefate = true
        let offsetX = CGFloat(currextIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y:0), animated: false)
    }
}














