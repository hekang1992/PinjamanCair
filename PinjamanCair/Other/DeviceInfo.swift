//
//  DeviceInfo.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/25.
//

import UIKit
import Foundation
import AdSupport
import NetworkExtension
import SystemConfiguration.CaptiveNetwork

struct DeviceInfo: Encodable {
    let overlooked: Overlooked
    let glass: Glass
    let branches: Branches
    let work: Work
    let fashion: Fashion
    let companion: Companion
}

struct Overlooked: Encodable {
    let easily: String
    let separated: String
    let nothing: String
    let avail: String
}

struct Glass: Encodable {
    let opera: Int
    let sides: Int
}

struct Branches: Encodable {
    let surveyed: String
    let breath: String
    let put: String
}

struct Work: Encodable {
    let piece: Int
    let frightful: Int
}

struct Fashion: Encodable {
    let schoolboy: String
    let presently: String
    let husbands: String
    let shinned: String
    let examine: String
}

struct WifiInfo: Encodable {
    let spite: String
    let alive: String
}

struct Companion: Encodable {
    let satisfy: WifiInfo?
}

class DeviceInfoCollector {
    
    func collectSyncInfo() -> (overlooked: Overlooked, glass: Glass, branches: Branches, work: Work, fashion: Fashion) {
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let attributes = try? fileManager.attributesOfFileSystem(forPath: documentsURL.path)
        let freeSpace = attributes?[.systemFreeSize] as? Int64 ?? 0
        let totalSpace = attributes?[.systemSize] as? Int64 ?? 0
        let easily = "\(freeSpace)"
        let separated = "\(totalSpace)"
        
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        let totalMemoryStr = "\(totalMemory)"
        
        var pagesize: vm_size_t = 0
        let host_port: mach_port_t = mach_host_self()
        host_page_size(host_port, &pagesize)
        var stats: vm_statistics64_data_t = vm_statistics64_data_t()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)
        let ret = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(host_port, HOST_VM_INFO64, $0, &count)
            }
        }
        var freeMemory: UInt64 = 0
        if ret == KERN_SUCCESS {
            freeMemory = UInt64(stats.free_count + stats.inactive_count) * UInt64(pagesize)
        }
        let avail = "\(freeMemory)"
        
        let overlooked = Overlooked(easily: easily, separated: separated, nothing: totalMemoryStr, avail: avail)
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = UIDevice.current.batteryLevel
        let opera = batteryLevel < 0 ? 0 : Int(batteryLevel * 100)
        let batteryState = UIDevice.current.batteryState
        let sides = (batteryState == .charging || batteryState == .full) ? 1 : 0
        
        let glass = Glass(opera: opera, sides: sides)
        
        let systemVersion = UIDevice.current.systemVersion
        
        let deviceName = UIDevice.current.model
        
        var sysinfo = utsname()
        uname(&sysinfo)
        let machine = withUnsafePointer(to: &sysinfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(validatingUTF8: $0) ?? "unknown"
            }
        }
       
        let branches = Branches(surveyed: systemVersion, breath: deviceName, put: machine)
        
        #if targetEnvironment(simulator)
        let isSimulator = 1
        #else
        let isSimulator = 0
        #endif
        
        let isJailbroken = jailbreakCheck() ? 1 : 0
        
        let work = Work(piece: isSimulator, frightful: isJailbroken)
        
        let timeZoneId = TimeZone.current.abbreviation() ?? ""
        
        let idfv = IDFVManager.persistedIDFV
        
        let language = Locale.preferredLanguages.first ?? "en"
        
        let networkType = UserDefaults.standard.string(forKey: "app_network_key") ?? ""
        
        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        
        let fashion = Fashion(schoolboy: timeZoneId, presently: idfv, husbands: language, shinned: networkType, examine: idfa)
        
        return (overlooked, glass, branches, work, fashion)
    }
    
    func collectWifiInfo(completion: @escaping (WifiInfo?) -> Void) {
        NEHotspotNetwork.fetchCurrent { network in
            if let network = network {
                let ssid = network.ssid
                let bssid = network.bssid
                let wifiInfo = WifiInfo(spite: bssid, alive: ssid)
                completion(wifiInfo)
            } else {
                completion(nil)
            }
        }
    }
    
    func collectAllInfo(completion: @escaping (DeviceInfo) -> Void) {
        let syncData = collectSyncInfo()
        collectWifiInfo { wifi in
            let companion = Companion(satisfy: wifi)
            let deviceInfo = DeviceInfo(
                overlooked: syncData.overlooked,
                glass: syncData.glass,
                branches: syncData.branches,
                work: syncData.work,
                fashion: syncData.fashion,
                companion: companion
            )
            completion(deviceInfo)
        }
    }
    
    private func jailbreakCheck() -> Bool {
        let paths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
}
