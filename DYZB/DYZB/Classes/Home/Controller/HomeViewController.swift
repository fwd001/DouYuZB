//
//  HomeViewController.swift
//  DYZB
//
//  Created by 伏文东 on 2017/12/9.
//  Copyright © 2017年 伏文东. All rights reserved.
//

import UIKit

let kTitleViewH: CGFloat = 40
class HomeViewController: UIViewController {
    // MARK: - 懒加载属性
    lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusbarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    lazy var pageContentView: PageContentView = { [weak self] in
        
        let contentH = kScreenH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusbarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        var childVCs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
        
    }


}
// MARK: - 设置UI界面
extension HomeViewController {
    func setupUI()  {
        //不需要添加UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //设置导航栏按钮
        setupNavigationBar()
        
        // 添加titelView
        view.addSubview(pageTitleView)
        // 添加pageView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    func setupNavigationBar()  {
        //设置左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logo"), highImage: nil)
        
        //设置右侧按钮
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(image: #imageLiteral(resourceName: "image_my_history"), highImage: #imageLiteral(resourceName: "Image_my_history_click"), size: size)
        let searchItem = UIBarButtonItem(image: #imageLiteral(resourceName: "btn_search"), highImage: #imageLiteral(resourceName: "btn_search_clicked"), size: size)
        let qrcodeItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Image_scan"), highImage: #imageLiteral(resourceName: "Image_scan_click"), size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}

// MARK: - 遵守pageTitleViewDelegate协议
extension HomeViewController: pageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currextIndex: index)
    }
}



// MARK: - 遵守pageContentViewDelegate协议
extension HomeViewController: pageContentviewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}






