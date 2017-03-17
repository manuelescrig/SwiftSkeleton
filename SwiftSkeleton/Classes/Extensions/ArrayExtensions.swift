//
//  Array+Extensions.swift
//
//  Created by Manuel on 3/17/17.
//  Copyright © 2017 Manuel. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle () {
        for i in (0..<self.count).reversed() {
            let ix1 = i
            let ix2 = Int(arc4random_uniform(UInt32(i+1)))
            (self[ix1], self[ix2]) = (self[ix2], self[ix1])
        }
    }
}
