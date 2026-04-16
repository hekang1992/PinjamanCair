//
//  NetworkMonitor.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import Alamofire
import Foundation

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    var statusChangeHandler: ((NetworkStatus) -> Void)?
    
    private let reachabilityManager = NetworkReachabilityManager()
    private var isMonitoring = false
    
    enum NetworkStatus {
        case unknown
        case notReachable
        case reachable(NetworkType)
        
        var isReachable: Bool {
            switch self {
            case .reachable: return true
            default: return false
            }
        }
        
        var description: String {
            switch self {
            case .unknown: return "unknown"
            case .notReachable: return "notReachable"
            case .reachable(.ethernetOrWiFi): return "WiFi"
            case .reachable(.cellular): return "5G"
            }
        }
    }
    
    enum NetworkType {
        case ethernetOrWiFi
        case cellular
    }
    
    func startListening(handler: @escaping (NetworkStatus) -> Void) {
        guard !isMonitoring else { return }
        
        self.statusChangeHandler = handler
        
        reachabilityManager?.startListening(onQueue: .main) { [weak self] status in
            guard let self = self else { return }
            let networkStatus = self.convertToNetworkStatus(status)
            self.statusChangeHandler?(networkStatus)
        }
        
        isMonitoring = true
        
        if let currentStatus = reachabilityManager?.status {
            let networkStatus = convertToNetworkStatus(currentStatus)
            handler(networkStatus)
        }
    }
    
    func stopListening() {
        reachabilityManager?.stopListening()
        isMonitoring = false
        statusChangeHandler = nil
    }
    
    var currentStatus: NetworkStatus {
        guard let status = reachabilityManager?.status else {
            return .unknown
        }
        return convertToNetworkStatus(status)
    }
    
    var isCurrentlyMonitoring: Bool {
        return isMonitoring
    }
    
    private func convertToNetworkStatus(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) -> NetworkStatus {
        switch status {
        case .unknown:
            return .unknown
      
        case .notReachable:
            return .notReachable
        
        case .reachable(let type):
            switch type {
            case .ethernetOrWiFi:
                return .reachable(.ethernetOrWiFi)
           
            case .cellular:
                return .reachable(.cellular)
            }
        }
    }
}

