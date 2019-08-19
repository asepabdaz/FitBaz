//
//  InterfaceController.swift
//  FitWatch Extension
//
//  Created by Hai on 19/08/19.
//  Copyright © 2019 Asep Abdaz. All rights reserved.
//

import WatchKit
import Foundation
import Dispatch

class InterfaceController: WKInterfaceController, WorkoutManagerDelegate {
    func didUpdateMotion(_ manager: WorkoutManager, gravityStr: String, ratationRateStr: String, userAccelStr: String, atittudeStr: String) {
        DispatchQueue.main.async {
            self.gravityStr = gravityStr
            self.dataShow()
        }
    }
    
    let workoutManager = WorkoutManager()
    var active = false
    
    var gravityStr = ""
    
    override init() {
        super.init()
        
        workoutManager.delegate = self
    }
    
    
    func dataShow() {
        print(gravityStr)
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    @IBAction func start() {
        workoutManager.startWorkout()
    }
    @IBAction func stop() {
        workoutManager.stopWorkout()
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        active = true
        dataShow()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        active = false
    }

}
