//
//  ViewController.swift
//  HzPlayingViewDemo
//
//  Created by ZanderHo on 15/9/10.
//  Copyright (c) 2015年 ZanderHo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playingView: UIView!
    @IBOutlet weak var myPlayingView: HZPlayingView!
    
    @IBAction func changeItemCount(sender: AnyObject) {
        self.myPlayingView.itemCount = 4
    }

    
    @IBAction func changeItemColor(sender: AnyObject) {
        self.myPlayingView.itemColor = UIColor.blueColor()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.firstReplicatorAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func firstReplicatorAnimation() {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: 0.0, y: 0.0, width: playingView.frame.size.width, height: playingView.frame.size.height)
        replicatorLayer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        replicatorLayer.backgroundColor = UIColor.redColor().CGColor
        replicatorLayer.instanceCount = 3
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(40.0, 0.0, 0.0)
        replicatorLayer.instanceDelay = 0.3
        replicatorLayer.masksToBounds = true
        self.playingView.layer.addSublayer(replicatorLayer)
        
        let rectangle = CALayer()
        rectangle.bounds = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 90.0)
        rectangle.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        rectangle.position = CGPoint(x: 10, y: 110)
        rectangle.cornerRadius = 2
        rectangle.backgroundColor = UIColor.whiteColor().CGColor
        replicatorLayer.addSublayer(rectangle)
        
        let moveRectangle = CABasicAnimation(keyPath: "position.y")
        moveRectangle.toValue = rectangle.position.y - 50
        moveRectangle.duration = 0.5
        moveRectangle.autoreverses = true
        moveRectangle.repeatCount = HUGE
        rectangle.addAnimation(moveRectangle, forKey: nil)
    }


}

