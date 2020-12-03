//
//  Publisher+Extension.swift
//  CombineTimer
//
//  Created by akio0911 on 2020/12/03.
//

import Combine

extension Publisher {
    func flatMapLatest<T: Publisher>(_ transform: @escaping (Output) -> T) -> Publishers.SwitchToLatest<T, Publishers.Map<Self, T>> where T.Failure == Failure {
        
        map(transform).switchToLatest()
    }
}
