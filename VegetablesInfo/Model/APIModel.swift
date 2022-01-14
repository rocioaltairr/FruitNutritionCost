//
//  APIModel.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/11.
//

import Foundation
struct APIModel: Codable {
    var RS: String
    var Data:[FruitData]
    struct FruitData: Codable,Identifiable{
        var generalName: String?
        var id = UUID()
        var TransDate: String
        var CropName: String
        var Avg_Price: Float
        var Trans_Quantity: Float
        
        private enum CodingKeys: Any, CodingKey {
            case generalName,TransDate, CropName,Avg_Price,Trans_Quantity
        }
    }
}

struct FruitsResponse: Codable {
    var RS: String
    var Data:[FruitData]
    struct FruitData: Codable,Identifiable{
        var generalName: String?
        var id = UUID()
        var TransDate: String
        var CropName: String
        var Avg_Price: Float
        var Trans_Quantity: Float
        
        private enum CodingKeys: Any, CodingKey {
            case generalName,TransDate, CropName,Avg_Price,Trans_Quantity
        }
    }
}

