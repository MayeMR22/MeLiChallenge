//
//  NetworkMonitor.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 31/05/22.
//

import Foundation
import Network

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    weak var delegate: NetworkMonitorDelegate?
    
    private var monitor: NWPathMonitor?
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    private var status: NWPath.Status?
    
    func start() {
        monitor?.cancel()
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status != self.status {
                self.status = pathUpdateHandler.status
                DispatchQueue.main.async {
                    self.delegate?.networkMonitor(didChangeStatus: pathUpdateHandler.status)
                }
            }
        }
        monitor?.start(queue: queue)
    }
    
    func stop() {
        monitor?.cancel()
    }
    
    func isNetworkAvailable() -> Bool {
        if status != .satisfied {
            return false
        }
        return true
    }
}

protocol NetworkMonitorDelegate: AnyObject {
    func networkMonitor(didChangeStatus status: NWPath.Status)
}
