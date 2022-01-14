//
//  Store.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/22.
//

import Foundation

struct AppState {
    var counter = 0
}

enum Action {
    case increment
}
//Store : maintaining the state
class Store: ObservableObject { // 物件改變時可以被觀察ObservableObject
    var reducer: Reducer
    @Published var appState: AppState // 為了讓subcriber去訂都可以收到 @Publish
    init(appState:AppState,reducer:Reducer) {
        self.appState = appState
        self.reducer = reducer
    }
}
class Reducer {
    func update(_ appState:inout AppState, _ action:Action) {
        switch action {
        case .increment:
            appState.counter += 1
        }
    }
}
