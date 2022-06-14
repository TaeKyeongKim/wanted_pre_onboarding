//
//  Observable.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

class Observable <T> {

    typealias Listener = (T) -> Void

    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: @escaping Listener) {
        listener(value)
        self.listener = listener
    }

}
