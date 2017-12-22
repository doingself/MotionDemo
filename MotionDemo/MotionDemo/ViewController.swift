//
//  ViewController.swift
//  MotionDemo
//
//  Created by syc on 2017/12/6.
//  Copyright © 2017年 test. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    private var ball:UIView!
    private var speedX:UIAccelerationValue = 0
    private var speedY:UIAccelerationValue = 0
    
    // 通过 CMMotionManager 类我们可以获取到加速器，陀螺仪，磁力仪，传感器这4类数据，同时它们的接口是一致的。
    private let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "core motion"
        self.view.backgroundColor = UIColor.white
        
        // MARK: 弹球
        ball = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        ball.backgroundColor = UIColor.lightGray
        ball.center = self.view.center
        self.view.addSubview(ball)
        
        motionManager.accelerometerUpdateInterval = 1/60
        if motionManager.isAccelerometerAvailable {
            let queue = OperationQueue.current
            motionManager.startAccelerometerUpdates(to: queue!, withHandler: {
                (accelerometerData, error) in
                //动态设置小球位置
                self.speedX += accelerometerData!.acceleration.x
                self.speedY +=  accelerometerData!.acceleration.y
                var posX=self.ball.center.x + CGFloat(self.speedX)
                var posY=self.ball.center.y - CGFloat(self.speedY)
                //碰到边框后的反弹处理
                if posX<0 {
                    posX=0;
                    //碰到左边的边框后以0.4倍的速度反弹
                    self.speedX *= -0.4
                    
                }else if posX > self.view.bounds.size.width {
                    posX=self.view.bounds.size.width
                    //碰到右边的边框后以0.4倍的速度反弹
                    self.speedX *= -0.4
                }
                if posY<0 {
                    posY=0
                    //碰到上面的边框不反弹
                    self.speedY=0
                } else if posY>self.view.bounds.size.height{
                    posY=self.view.bounds.size.height
                    //碰到下面的边框以1.5倍的速度反弹
                    self.speedY *= -1.5
                }
                self.ball.center = CGPoint(x:posX, y:posY)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
