//
//  Debouncer.swift
//
//
//  Created by Jill Chang on 2024/10/25.
//

import Foundation

public class Debouncer {
    private var workItem: DispatchWorkItem?
    private let queue: DispatchQueue
    private let interval: TimeInterval

    public init(seconds: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.interval = seconds
        self.queue = queue
    }

    public func execute(_ action: @escaping () -> Void) {
        workItem?.cancel()
        let newWorkItem = DispatchWorkItem { action() }
        workItem = newWorkItem
        queue.asyncAfter(deadline: .now() + interval, execute: newWorkItem)
    }
}
