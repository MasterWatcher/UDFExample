//
//  Store.swift
//  UDFExample
//
//  Created by Anton Goncharov on 24.11.2020.
//

import Foundation

public class Store<State> {

    public typealias Reducer<State> = (inout State, Action) -> Void
    public typealias Subscription<State> = (State) -> Void

    private(set) var state: State
    private let reducer: Reducer<State>
    private var subscribers = [UUID: Subscription<State>]()

    public init(state: State, reducer: @escaping Reducer<State>) {
        self.state = state
        self.reducer = reducer
    }

    public func dispatch(_ action: Action) {
        reducer(&state, action)
        subscribers.forEach { $0.1(state) }
    }

    public func subscribe(_ subscription: @escaping Subscription<State>) -> UUID {
        let key = UUID()
        subscribers[key] = subscription
        subscription(state)

        return key
    }

    public func unsubscribe(id: UUID) {
        subscribers.removeValue(forKey: id)
    }
}
