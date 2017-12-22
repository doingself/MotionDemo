//
//  ViewController1.swift
//  MotionDemo
//
//  Created by rigour on 2017/12/7.
//  Copyright © 2017年 testName. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    
    var txtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        txtView = UITextView(frame: CGRect(x: 10, y: 70, width: self.view.frame.size.width-20, height: self.view.frame.size.height-80))
        txtView.isEditable = false
        self.view.addSubview(txtView)
    }
    
    @objc func deviceProximityNotice(sender: Notification?){
        if UIDevice.current.proximityState {
            let str: String = txtView.text ?? ""
            txtView.text = str + "\n物体靠近"
        }else{
            let str: String = txtView.text ?? ""
            txtView.text = str + "\n物体离开"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: 距离传感器
        // 打开传感器
        UIDevice.current.isProximityMonitoringEnabled = true
        // 可用使用通知监听 NSNotification.Name.UIDeviceProximityStateDidChange
        NotificationCenter.default.addObserver(self, selector: #selector(self.deviceProximityNotice(sender:)), name: NSNotification.Name.UIDeviceProximityStateDidChange, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 距离
        UIDevice.current.isProximityMonitoringEnabled = false
        NotificationCenter.default.removeObserver(self)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // ...
    }
    // 思路同 touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        // 晃动开始
        let str: String = txtView.text ?? ""
        txtView.text = str + "\n晃动开始"
        print("motionBegan \(motion)")
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        // 结束
        let str: String = txtView.text ?? ""
        txtView.text = str + "\n晃动结束"
        print("motionEnded \(motion)")
    }
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        // 中断
        let str: String = txtView.text ?? ""
        txtView.text = str + "\n晃动中断"
        print("motionCancelled \(motion)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
