//
//  ViewController2.swift
//  MotionDemo
//
//  Created by rigour on 2017/12/7.
//  Copyright © 2017年 testName. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController2: UIViewController {
    
    let motionManager = CMMotionManager()
    let altimeter = CMAltimeter()
    
    // 加速
    var accelerationLab: UILabel!
    // 陀螺仪
    var gyroscopeLab: UILabel!
    // 磁力
    var magnetLab: UILabel!
    // 海拔
    var altitudeLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let w: CGFloat =  self.view.bounds.size.width - 20
        let h: CGFloat = 100
        var y: CGFloat = 70
        accelerationLab = UILabel(frame: CGRect(x: 10, y: y, width: w, height: h))
        accelerationLab.numberOfLines = 0
        accelerationLab.layer.borderWidth = 1
        self.view.addSubview(accelerationLab)
        
        y += h
        gyroscopeLab = UILabel(frame: CGRect(x: 10, y: y, width: w, height: h))
        gyroscopeLab.numberOfLines = 0
        gyroscopeLab.layer.borderWidth = 1
        self.view.addSubview(gyroscopeLab)
        
        y += h
        magnetLab = UILabel(frame: CGRect(x: 10, y: y, width: w, height: h))
        magnetLab.numberOfLines = 0
        magnetLab.layer.borderWidth = 1
        self.view.addSubview(magnetLab)
        
        y += h
        altitudeLab = UILabel(frame: CGRect(x: 10, y: y, width: w, height: h))
        altitudeLab.numberOfLines = 0
        altitudeLab.layer.borderWidth = 1
        self.view.addSubview(altitudeLab)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: core motion
        // 加速器 使用push方式
        guard motionManager.isAccelerometerAvailable else{
            // 设备不支持 加速器
            self.accelerationLab.text = "不支持 加速"
            return
        }
        guard motionManager.isAccelerometerActive else{
            // 加速器 正在采集数据
            self.accelerationLab.text = "加速..."
            return
        }
        motionManager.accelerometerUpdateInterval = 0.3 // 采集间隔
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, err) in
            if let accelerationData = data?.acceleration {
                let x = accelerationData.x
                let y = accelerationData.y
                let z = accelerationData.z
                let str = "加速 x=\(x) y=\(y) z=\(z)"
                self.accelerationLab.text = str
            }
        }
        // 陀螺仪 使用pull方式主动获取
        // 参数同上 motionManager.isGyroAvailable
        motionManager.startGyroUpdates()
        if let gyroData = motionManager.gyroData{
            let rate = gyroData.rotationRate
            let x = rate.x
            let y = rate.y
            let z = rate.z
            
            let str = "陀螺 x=\(x) y=\(y) z=\(z)"
            self.gyroscopeLab.text = str
        }
        // 磁力仪 push (导航)
        // 参数同上 motionManager.isMagnetometerAvailable
        motionManager.startMagnetometerUpdates(to: OperationQueue.current!) { (data, err) in
            if let field = data?.magneticField{
                let x = field.x
                let y = field.y
                let z = field.z
                
                let str = "磁力 x=\(x) y=\(y) z=\(z)"
                self.magnetLab.text = str
            }
        }
        
        // MARK: Altimeter
        // 海拔高度
        guard CMAltimeter.isRelativeAltitudeAvailable() else{
            // 设备不支持
            altitudeLab.text = "不支持 海波"
            return
        }
        altimeter.startRelativeAltitudeUpdates(to: OperationQueue.current!) { (data, err) in
            // 高度，米
            let m = data!.relativeAltitude
            // 压力以千帕计
            let p = data!.pressure
            
            let str = "海拔=\(m)m 压力=\(p)"
            self.altitudeLab.text = str
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 加速
        motionManager.stopAccelerometerUpdates()
        // 陀螺
        motionManager.stopGyroUpdates()
        // 磁力
        motionManager.stopMagnetometerUpdates()
        // 海拔
        altimeter.stopRelativeAltitudeUpdates()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
