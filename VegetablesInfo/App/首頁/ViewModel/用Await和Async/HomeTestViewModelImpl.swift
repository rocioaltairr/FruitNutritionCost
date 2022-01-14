//
//  HomeTestViewModelImpl.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/28.
//

import Foundation

protocol HomeTestViewModel:ObservableObject {
    @available(iOS 15.0.0, *)
    func fetchFruitDatail(item :APIModel.FruitData) async
    
}
@MainActor
final class HomeTestViewModelImpl:HomeTestViewModel {
    @Published private(set) var fruit:[APIModel.FruitData] = []
    
    private let service:APIService
    init(service:APIService) {
        self.service = service
        
    }
    @available(iOS 15.0.0, *)
    func fetchFruitDatail(item :APIModel.FruitData) async {
        do {
            self.fruit = try await service.fetchFruitDatail(item: item)
        } catch {
            print(error)
        }
    }
    
}
