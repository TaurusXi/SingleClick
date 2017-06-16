//
//  ViewController.swift
//  SwiftSingleClick
//
//  Created by xicheng on 2017/6/16.
//  Copyright © 2017年 xicheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    private var _normalInterf:TimeInterval = 0.6
    private var _oldTime:TimeInterval = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "SingleClickDemo"

        // 常规写法，会出现重复点击的误操作
        let normalView = UILabel(frame: CGRect(x: (self.view.frame.width - 200) / 2, y: 100, width: 200, height: 48))
        normalView.text = "Normal_Click"
        normalView.textAlignment = .center
        normalView.backgroundColor = UIColor.lightGray
        self.view.addSubview(normalView)
        // 下面开始 加入点击事件
        
        normalView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(ViewController.tapNormalView(targetView:)))
        normalView.addGestureRecognizer(tapGestureRecognizer)
        
        // 常规写法，去除重复点击，但是实现相当繁琐
        let normalSingleView = UILabel(frame: CGRect(x: (self.view.frame.width - 200) / 2, y: 180, width: 200, height: 48))
        normalSingleView.text = "Normal_SingleClick"
        normalSingleView.textAlignment = .center
        normalSingleView.backgroundColor = UIColor.lightGray
        self.view.addSubview(normalSingleView)
        // 下面开始 加入点击事件
        normalSingleView.isUserInteractionEnabled = true
        let singleTapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(ViewController.tapNormalView_SingleClick(targetView:)))
        normalSingleView.addGestureRecognizer(singleTapGestureRecognizer)
        
        
        // 扩展进阶写法
        let singleClickView = UILabel(frame: CGRect(x: (self.view.frame.width - 200) / 2, y: 260, width: 200, height: 48))
        singleClickView.text = "Extension_SingleClick"
        singleClickView.textAlignment = .center
        singleClickView.backgroundColor = UIColor.lightGray
        self.view.addSubview(singleClickView)
        // 加入点击事件 , fixSingleClickListener 为 UIView 扩展方法。
        singleClickView.fixSingleClickListener(0.6) {
            print("点击Extension_SingleClick")
        }
    }

    
    @objc func tapNormalView(targetView:UIView){
        print("点击Normal_Label")
    }
    
    @objc func tapNormalView_SingleClick(targetView:UIView){
        let currentTime = CACurrentMediaTime()
        guard currentTime - _oldTime > _normalInterf else {
            // 如果两次点击间隔不长于 定义的间隔时间，该事件不响应
            return
        }
        _oldTime = currentTime
        // 响应事件
        print("点击Normal_SingleClick")
    }


}

