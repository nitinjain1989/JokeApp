//
//  DispatchQueueType.swift
//  JokeApp
//
//  Created by Nitin Jain on 22/09/23.
//

import Foundation

protocol DispatchQueueType {
    func asyncAfter(time:DispatchTime, execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue : DispatchQueueType {
    func asyncAfter(time:DispatchTime, execute work: @escaping @convention(block) () -> Void) {
        self.asyncAfter(deadline: time, execute: work)
    }
}
