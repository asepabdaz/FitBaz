//
//  MotionManager.swift
//  FitWatch Extension
//
//  Created by Hai on 19/08/19.
//  Copyright © 2019 Asep Abdaz. All rights reserved.
//

import Foundation
import CoreMotion
import WatchKit
import os.log

protocol MotionManagerDelegate: class {
    func didUpdateMotion(_ manager: MotionManager, gravityStr: String, rotationRateStr: String, userAccelStr: String, attitudeStr: String)
}
extension Date {
    var milliSecondSince1970: Int64{
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
}
class MotionManager{
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    let wristLocationIsLeft = WKInterfaceDevice.current().wristLocation == .left
    
    let simpleInterval = 1.0 / 50
    let rateAlongGravityBuffer = RuningBuffer(size:  50)
    
    weak var delegate: MotionManagerDelegate?
    
    var gravityStr = ""
    var rotetionRateStr = ""
    var userAccelStr = ""
    var attitudeStr = ""
    
    var recentDetection = false
    
    init() {
        queue.maxConcurrentOperationCount = 1
        queue.name = "MotionManagerQueue"
    }
    
    func startUpdate() {
        if !motionManager.isDeviceMotionAvailable {
            print("Device Motion is  not available")
            return
        }
        
        os_log("Start Updates")
        
        motionManager.deviceMotionUpdateInterval = simpleInterval
        motionManager.startDeviceMotionUpdates(to: queue) { (deviceMotion: CMDeviceMotion?, error: Error?) in
            if error != nil {
                print("Encountered Error: \(error!)")
            }
            
            if deviceMotion != nil {
                self.processDeviceMotion(deviceMotion!)
            }
        }
        
    }
    
    func stopUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.stopDeviceMotionUpdates()
        }
    }
    func processDeviceMotion(_ deviceMotion: CMDeviceMotion){
        gravityStr = String(format: "X: %.1f Y: %.1f Z: %.1f", deviceMotion.gravity.x,deviceMotion.gravity.y,deviceMotion.gravity.z)
        
        let timestamp = Date().milliSecondSince1970
        os_log("Motion : %@, %@", String(timestamp),String(deviceMotion.gravity.x))
        
        updateMatricDelegate()
    }
    
    
    func updateMatricDelegate(){
        delegate?.didUpdateMotion(self, gravityStr: gravityStr, rotationRateStr: "", userAccelStr: "", attitudeStr: "")
    }
    
}

    


