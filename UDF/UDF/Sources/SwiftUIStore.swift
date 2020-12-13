//
//  SwiftUIStore.swift
//  UDF
//
//  Created by Anton Goncharov on 13.12.2020.
//  Copyright © 2020 Anton Goncharov. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

public class SwiftUIStore<State>: ObservableObject {

    public typealias Reducer<State> = (inout State, Action) -> Void

    @Published public private(set) var state: State
    private let reducer: Reducer<State>

    public init(state: State, reducer: @escaping Reducer<State>) {
        self.state = state
        self.reducer = reducer
    }

    public func dispatch(_ action: Action) {
        reducer(&state, action)
    }

    public func binding<LocalState>(
        get: @escaping (State) -> LocalState,
        send localStateToViewAction: @escaping (LocalState) -> Action
    ) -> Binding<LocalState> {
        Binding(
            get: { get(self.state) },
            set: { newLocalState, transaction in
                self.dispatch(localStateToViewAction(newLocalState))
        })
    }
}
