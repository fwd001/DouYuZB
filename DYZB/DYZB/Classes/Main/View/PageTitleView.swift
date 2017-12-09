//
//  PageTitleView.swift
//  DYZB
//
//  Created by 伏文东 on 2017/12/9.
//  Copyright © 2017年 伏文东. All rights reserved.
//

import UIKit

//MARK : -定义协议
protocol pageTitleViewDelegate : class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

//MARK : -定义常量
let kScrollLineH: CGFloat = 2
let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {

    //MARK : -定义属性
    var titles: [String]
    var currentIndex : Int = 0
    weak var delegate: pageTitleViewDelegate?
    //MARK : -懒加载属性
    lazy var titleLabels : [UILabel] = [UILabel]()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //MARK : -自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK : - 设置UI界面
extension PageTitleView {
    func setupUI()  {
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应的label
        setupTitleLabels()
        
        // 3.设置底线和滚动滑块
        setupBottonMenuAndScrollLine()
    }
    
    func setupTitleLabels() {
        
        // 0. 确定lable的一些frame值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        
        let labelY : CGFloat = 0
        for (index, title) in titles.enumerated() {
            // 1.创建label
            let label = UILabel()
            // 2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            // 3.设置lebel的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    func setupBottonMenuAndScrollLine()  {
        // 1 .添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

//MARK : - 监听label点击
extension PageTitleView {
    @objc func titleLabelClick(tapGes: UITapGestureRecognizer) {
        
        guard let currentlable =  tapGes.view as? UILabel else { return }
        
        let oldLabel = titleLabels[currentIndex]
        
        currentlable.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentlable.tag
        
        let scroolLineX = CGFloat(currentlable.tag) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scroolLineX
        }
        
        //通知代理做事
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//MARK : - 对外暴露方法

extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int)  {
        // 去除sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLbael = titleLabels[targetIndex]
        
        // 处理滑块逻辑
        let moveTotalX = targetLbael.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 处理颜色渐变
        // 变化范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 变化的sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 变化targetLabel
        targetLbael.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 记录最新的index
        currentIndex = targetIndex
    }
}



















