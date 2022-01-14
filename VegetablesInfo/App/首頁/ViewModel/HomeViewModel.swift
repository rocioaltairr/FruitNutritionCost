//
//  HomeViewModel.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/22.
//

import Foundation
import Combine
import SwiftUI
// 為了做Publisher 我們先import Combine，讓viewModel繼承ObservableObject，後把我們想觀察的對象用 @Published 屬性包裝器做包裝，這個Publisher 每當property改變都會廣播其變動
// ViewModel 是ObservableObject，因為要監聽Model的變動
// Publish 變動給View
class HomeViewModel:ObservableObject {
    @Published var fruitDataModel: APIModel?
    @Published var isLoading = false
    @Published var cropsName: [String] = []
    
    let fruits = ["雜柑","火龍果","百香果","酪梨","草莓","洋香瓜","藍莓","西瓜","椰子","芒果","奇異果","蓮霧","榴槤","木瓜","鳳梨","香蕉","小番茄","蘋果","葡萄","檸檬","甜橙"]
    
    let datefomatter: DateFormatter = {
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: "Asia/Taipei")
        df.locale = Locale(identifier: "zh_Hant_TW")
        return df
    }()
    
    init() {
        setupDataTaskPublisher()
    }
    // 執行訂閱
    private func setupDataTaskPublisher() {
        if fruitDataModel != nil {
            return
        }
        var fruitsDataTemp: [APIModel.FruitData] = []
        var usedFruitsData: [APIModel.FruitData] = []
        var groupedFruits: [String? : [APIModel.FruitData]] = [:]
        
        isLoading = true
        let myGroup = DispatchGroup()
        let datefomatter = DateFormatter()
        datefomatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
        let todayDate = Date()
        
        datefomatter.dateFormat = "YYYY"
        let startYearInTaiwan:Int = Int(datefomatter.string(from: startDate))! - 1911
        let todayYearInTaiwan:Int = Int(datefomatter.string(from: todayDate))! - 1911
        
        datefomatter.dateFormat = "MM.dd"
        let startDateString = datefomatter.string(from: startDate)
        let todayDateString = datefomatter.string(from: todayDate)
        
        for i in 0..<fruits.count {
            myGroup.enter()
            let queryString = "Start_time=\(startYearInTaiwan).\(startDateString)&End_time=\(todayYearInTaiwan).\(todayDateString)&CropName=\(fruits[i])"
            let escapedQueryString = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let urlString = "https://data.coa.gov.tw/api/v1/AgriProductsTransType/?\(escapedQueryString)"
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            
            // 一般的命令式寫法 Imperative Programming
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data, let _ = response else {
                    print("No data or response.")
                    return
                }
                
                do {
                    let dataModel = try JSONDecoder().decode(APIModel.self, from: data)
                    for j in 0..<dataModel.Data.count {
                        if dataModel.Data[j].CropName != "休市" {
                            var fruit = dataModel.Data[j]
                            fruit.generalName = self.fruits[i]
                            fruitsDataTemp.append(fruit)
                            DispatchQueue.main.async { [weak self] in
                                self?.cropsName.append(dataModel.Data[j].CropName)
                            }
                        }
                    }
                    myGroup.leave()
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
        
        myGroup.notify(queue: .main) {
            groupedFruits = Dictionary(grouping: fruitsDataTemp, by: {$0.CropName})
            
            self.cropsName = Array(Set(self.cropsName))
            for cropName in self.cropsName {
                var gropCost:Float = 0
                var amount:Float = 0
                if let groupItems = groupedFruits[cropName]  {
                    for j in 0..<groupItems.count {
                        amount += groupItems[j].Trans_Quantity
                        gropCost += (groupItems[j].Avg_Price*groupItems[j].Trans_Quantity)
                        
                    }
                    var data = groupedFruits[cropName]![0]
                    data.Avg_Price = gropCost/amount// 一週均價
                    usedFruitsData.append(data)
                }
            }
            
            self.isLoading = false
            self.fruitDataModel = APIModel(RS: "OK", Data:  usedFruitsData)
        }
    }
}
