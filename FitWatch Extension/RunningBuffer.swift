//
//  RunningBuffer.swift
//  FitWatch Extension
//
//  Created by Hai on 19/08/19.
//  Copyright © 2019 Asep Abdaz. All rights reserved.
//

import Foundation

class RuningBuffer {
    
    var buffer = [Double]()
    var size = 0
    
    init(size: Int) {
        self.size  = size
        self.buffer = [Double](repeating: 0.0, count: self.size)
    }
    
}
