//
//  Utils.swift
//  Pods
//
//  Created by Manuel on 10/28/16.
//
//

import Foundation
import SystemConfiguration


// MARK: Logging

func log(message: String,
         function: String = #function,
         file: String = #file,
         line: Int = #line) {
    
    print("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
}


// MARK: Information

func appDisplayName() -> String {
    if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
        return bundleDisplayName
    } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
        return bundleName
    }
    
    return ""
}

func appVersion() -> String {
    return (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String)!
}

func appBuild() -> String {
    return (Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String)!
}

func appVersionAndBuild() -> String {
    if appVersion != nil && appBuild != nil {
        if appVersion() == appBuild() {
            return "v\(appVersion)"
        } else {
            return "v\(appVersion)(\(appBuild))"
        }
    }
    return ""
}

func appBundleID() -> String {
    return Bundle.main.bundleIdentifier!
}

func platform() -> String {
    var sysinfo = utsname()
    uname(&sysinfo) // ignore return value
    return NSString(bytes: &sysinfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)! as String
}

func deviceVersion() -> String {
    var size: Int = 0
    sysctlbyname("hw.machine", nil, &size, nil, 0)
    var machine = [CChar](repeating: 0, count: Int(size))
    sysctlbyname("hw.machine", &machine, &size, nil, 0)
    return String(cString: machine)
}

func isDebug() -> Bool {
    #if DEBUG
        return true
    #else
        return false
    #endif
}

func isRelease() -> Bool {
    #if DEBUG
        return false
    #else
        return true
    #endif
}


// MARK: Util methods

func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

func runOnMain(_ block: @escaping ()->()) {
    DispatchQueue.main.async(execute: block)
}

func runOnBackground(_ block: @escaping () -> ()) {
    DispatchQueue.global(qos: .default).async(execute: block)
}

func runEvery(seconds: TimeInterval, startAfterSeconds: TimeInterval, handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
    let fireDate = startAfterSeconds + CFAbsoluteTimeGetCurrent()
    let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
    return timer!
}


// MARK: Reachabela


func isInternetAvailable() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            SCNetworkReachabilityCreateWithAddress(nil, $0)
        }
    }) else {
        return false
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    
    return (isReachable && !needsConnection)
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:(Void)->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
