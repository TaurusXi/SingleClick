//
//  UIButton+SingleClick.swift
//  OneDay
//
//  Created by cheng xi on 2016/9/22.
//  Copyright © 2016年 xicheng. All rights reserved.
//

import UIKit
import ObjectiveC


private let DEFAULT_INTERF:TimeInterval = 0.6


private var view_oldTimeTag:UInt8 = 0
private var view_interfTag:UInt8 = 2
private var view_hasAddTargetTag:UInt8 = 3
private var view_singleClickTag:UInt8 = 4



extension UIView {
  
  private var _ViewOldTime:TimeInterval {
    
    get{
      
      if let oldTime =  objc_getAssociatedObject(self, &view_oldTimeTag) as? TimeInterval {
        return oldTime
      }
      return 0
    }
    
    set(newValue){
      
      objc_setAssociatedObject(self, &view_oldTimeTag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
      
    }
    
  }
  
  
  private var _Viewinterf:TimeInterval {
    
    get{
      
      if let interf =  objc_getAssociatedObject(self, &view_interfTag) as? TimeInterval {
        return interf
      }
      return DEFAULT_INTERF
    }
    
    set(newValue){
      
      objc_setAssociatedObject(self, &view_interfTag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
      
    }
    
  }
  
  private var _ViewhasAddTarget:Bool {
    
    get{
      if let hasTargetFlag = objc_getAssociatedObject(self, &view_hasAddTargetTag) as? Bool {
        return hasTargetFlag
      }
      return false
    }
    
    set(newValue){
      
      objc_setAssociatedObject(self, &view_hasAddTargetTag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
      
    }
    
  }
  
  private var _ViewsingleClick:TXClickListener? {
    
    get{
      return objc_getAssociatedObject(self, &view_singleClickTag) as? TXClickListener
    }
    
    set(newValue){
      
      if !self._ViewhasAddTarget {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.tapGesture))
        self.addGestureRecognizer(tapGesture)
        self._ViewhasAddTarget = true
      }
      
      objc_setAssociatedObject(self, &view_singleClickTag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
      
    }
    
  }
  
  @objc fileprivate func tapGesture(){
    let currentTime = CACurrentMediaTime()
    if (currentTime - self._ViewOldTime > _Viewinterf) {
      _ViewsingleClick?._singleClick?()
      _ViewOldTime = currentTime
    }
  }
  
  
  func fixSingleClickListener(_ interf: TimeInterval = 0.6, _ listener: @escaping ()->()) {
    self._Viewinterf = interf
    self._ViewsingleClick = TXClickListener.init(block: listener)
  }
  

}


fileprivate class TXClickListener:NSObject {
  
  var _singleClick:(()->Void)? = nil
  
  init(block:@escaping (()->Void)) {
    self._singleClick = block
  }
  
}
