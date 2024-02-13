//
//  WorkScheduler.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 10/02/24.
//

import Combine
import Foundation

final class WorkScheduler {

    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()

    static let mainScheduler = RunLoop.main
    static let mainThread = DispatchQueue.main
}
