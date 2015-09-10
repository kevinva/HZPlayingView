//
//  HZPlayingView.swift
//  HZPlayingViewDemo
//
//  Created by ZanderHo on 15/9/10.
//  Copyright (c) 2015年 ZanderHo. All rights reserved.
//

import UIKit

class HZPlayingView: UIView {
    
    let HZPlayingViewItemStarOffset: CGFloat = 5.0
    let HZPlayingViewItemSpace: CGFloat = 3.0
    let HZPlayingViewItemWidth: CGFloat = 2.0
    
    var itemColor: UIColor = UIColor.whiteColor() {
        didSet {
            for itemLayer in self.replicatorLayer.sublayers {
                if let subLayer = itemLayer as? CALayer {
                    subLayer.removeFromSuperlayer()
                }
            }
            
            let rectangle = CALayer()
            rectangle.bounds = CGRect(x: 0.0, y: 0.0, width: self.HZPlayingViewItemWidth, height: self.bounds.size.height)
            rectangle.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            rectangle.position = CGPoint(x: self.HZPlayingViewItemStarOffset, y: self.bounds.size.height / 2)
            rectangle.cornerRadius = 1
            rectangle.backgroundColor = self.itemColor.CGColor
            self.replicatorLayer.addSublayer(rectangle)
        }
    }
    
    var itemCount: Int = 4 {
        didSet {
            self.replicatorLayer.instanceCount = self.itemCount
        }
    }
    
    private lazy var replicatorLayer: CAReplicatorLayer = {

        let lazyReplicatorLayer = CAReplicatorLayer()
        lazyReplicatorLayer.bounds = self.bounds
        lazyReplicatorLayer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        lazyReplicatorLayer.backgroundColor = UIColor.clearColor().CGColor
        lazyReplicatorLayer.instanceCount = self.itemCount
        lazyReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(self.HZPlayingViewItemSpace + self.HZPlayingViewItemWidth, 0.0, 0.0)
        lazyReplicatorLayer.instanceDelay = 0.3
        lazyReplicatorLayer.masksToBounds = true
        
        let rectangle = CALayer()
        rectangle.bounds = CGRect(x: 0.0, y: 0.0, width: self.HZPlayingViewItemWidth, height: self.bounds.size.height)
        rectangle.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        rectangle.position = CGPoint(x: self.HZPlayingViewItemStarOffset, y: self.bounds.size.height * 2 / 3)
        rectangle.cornerRadius = 1
        rectangle.backgroundColor = self.itemColor.CGColor
        lazyReplicatorLayer.addSublayer(rectangle)
        
        let moveRectangleAnimation = CABasicAnimation(keyPath: "position.y")
        moveRectangleAnimation.toValue = rectangle.position.y - self.bounds.size.height / 2
        moveRectangleAnimation.duration = 0.4
        moveRectangleAnimation.autoreverses = true
        moveRectangleAnimation.repeatCount = HUGE
        rectangle.addAnimation(moveRectangleAnimation, forKey: nil)
        
        return lazyReplicatorLayer
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    
    //MARK: Private methods
    
    private func setup() {
        self.layer.addSublayer(self.replicatorLayer)
    }
    
}
