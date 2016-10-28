//
//  PermissionsController.swift
//  Pods
//
//  Created by Manuel on 10/28/16.
//
//

import Foundation
import AVFoundation

class PermissionController: NSObject {
    
    static let sharedInstance = PermissionController()
    
    override private init() { } //This prevents others from using the default '()' initializer for this class.
    
    func isCameraAuthorized(authorized: @escaping ()->(), denied: @escaping ()->()) {
        
        let cameraMediaType = AVMediaTypeVideo
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .denied:
            denied()
            break
        case .authorized:
            authorized()
            break
        case .restricted:
            denied()
            break
            
        case .notDetermined:
            // Prompting user for the permission to use the camera.
            AVCaptureDevice.requestAccess(forMediaType: cameraMediaType) { granted in
                if granted {
                    authorized()
                } else {
                    denied()
                }
            }
        }
    }
    
}

