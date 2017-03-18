
//
//  Date+Extensions.swift
//  PhotoFrame
//
//  Created by Manuel on 3/18/17.
//  Copyright © 2017 Manuel. All rights reserved.
//

import Foundation

extension Date {
 
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
