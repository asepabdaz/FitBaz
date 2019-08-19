//
//  WorkoutManager.swift
//  FitWatch Extension
//
//  Created by Hai on 19/08/19.
//  Copyright © 2019 Asep Abdaz. All rights reserved.
//

import Foundation
import HealthKit

protocol WorkoutManagerDelegate: class {
    func didUpdateMotion(_ manager: WorkoutManager, gravityStr: String, ratationRateStr: String, userAccelStr: String, atittudeStr: String)
}

class WorkoutManager: MotionManagerDelegate {
    
    let motionManager = MotionManager()
    let healtStore = HKHealthStore()
    
    weak var delegate: WorkoutManagerDelegate?
    
    var session: HKWorkoutSession?
    
    
    init() {
        motionManager.delegate = self
    }
    
    func startWorkout() {
        if (session != nil) {
            return
        }
        
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .archery
        workoutConfiguration.locationType = .indoor
        
        do {
            session = try HKWorkoutSession(configuration: workoutConfiguration)
        } catch {
            fatalError("Unable to create teh workout Session!")
        }
        
        healtStore.start(session!)
        motionManager.startUpdate()
        
    }
    
    func stopWorkout() {
        if (session != nil) {
            return
        }
        
        motionManager.stopUpdates()
        healtStore.end(session!)
        
        session = nil
        
    }
    
    func didUpdateMotion(_ manager: MotionManager, gravityStr: String, rotationRateStr: String, userAccelStr: String, attitudeStr: String) {
        delegate?.didUpdateMotion(self, gravityStr: gravityStr, ratationRateStr: rotationRateStr, userAccelStr: userAccelStr, atittudeStr: attitudeStr)
    }
    
    
}
