//
//  Bool+Extensions.swift
//  SwiftSkeleton
//
//  Created by Manuel on 10/28/16.
//
//

import Foundation

extension Bool {

    @discardableResult
    public mutating func toggle() -> Bool {
        self = !self
        return self
    }
}
