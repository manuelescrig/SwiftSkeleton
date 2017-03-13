//
//  UIViewController+Extensions.swift
//  Pods
//
//  Created by Manuel on 10/28/16.
//
//

import Foundation

    // MARK:- Shake Gesture

    override open func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
      
        }
    }
    
    override open var canBecomeFirstResponder: Bool {
        return true
    }
