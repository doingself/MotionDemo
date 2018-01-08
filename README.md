# MotionDemo
CoreMotion 简单使用

```
// target —> buildSettings —> swift flag —> Debug -> -D DEBUG
// 在项目中实现：#if DEBUG    #endif
// 这里 T 表示不指定 message参数类型
func SYCLog<T>(_ msg: T, filePath: String = #file, methodName: String = #function, lineNumber: Int = #line, columnNumber: Int = #column){
    
    #if DEBUG
        
        let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        
        print("\n\t \(fileName).\(methodName):(\(lineNumber):\(columnNumber)) - \(msg)")
        
    #endif
}
```

## 距离传感器（非motion）
```
// 打开传感器
UIDevice.current.isProximityMonitoringEnabled = true

// 可用使用通知监听 NSNotification.Name.UIDeviceProximityStateDidChange
NotificationCenter.default.addObserver(self, selector: #selector(self.deviceProximityNotice(sender:)), name: NSNotification.Name.UIDeviceProximityStateDidChange, object: nil)

// 判断
UIDevice.current.proximityState
```

## 摇一摇

`override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?)`


motionBegan 和 touchesBegan 用法很像, 如: `override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)`


## CMMotionManager

通过 CMMotionManager 类我们可以获取到加速器，陀螺仪，磁力仪，传感器这4类数据，同时它们的接口是一致的。
2种实现方式 pull/push

### 加速 CMAccelerometerData.CMAcceleration

```
motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, err) in
    if let accelerationData = data?.acceleration {
        let x = accelerationData.x
        let y = accelerationData.y
        let z = accelerationData.z
        let str = "加速 x=\(x) y=\(y) z=\(z)"
        self.accelerationLab.text = str
    }
}
```

### 陀螺仪 CMGyroData.CMRotationRate

```
motionManager.startGyroUpdates()
if let gyroData = motionManager.gyroData{
    let rate = gyroData.rotationRate
    let x = rate.x
    let y = rate.y
    let z = rate.z
    
    let str = "陀螺 x=\(x) y=\(y) z=\(z)"
    self.gyroscopeLab.text = str
}
```

### 磁力 CMMagnetometerData.CMMagneticField



### 海拔 CMAltitudeData relativeAltitude米 / pressure压力



## 其他

弹球
