//
//  FruitDetailViewModel.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/28.
//

import Foundation
import Combine

protocol FruitDetailViewModelDelegate {
    func getFruitDetail(from fruit: APIModel.FruitData)
}

class FruitDetailViewModel:ObservableObject, FruitDetailViewModelDelegate {

    private let service: FruitsService
    private var cancellables = Set<AnyCancellable>()
    @Published var arrEverdayAverageCostInLastWeek:[DetailRowModel] = [] // 這週每一天的平均價
    @Published var isLoading = false
    @Published var isFavorate = false
    
    init(service: FruitsService) {
        self.service = service
    }
    func getFruitDetail(from fruit: APIModel.FruitData) {
        // 是否為我的最愛水果
        if let userDefaultList = UserDefaults.standard.object(forKey: "favorateList") as? [String] {
            if userDefaultList.contains(fruit.CropName) {
                self.isFavorate = true
            }
        }
        
        let cancellable  = service
            .requetFruitDatail(from: fruit)
            .sink { res in
                
            } receiveValue : { response in
                let datefomatter = DateFormatter()
                var calendar = Calendar(identifier: .republicOfChina)
                datefomatter.timeZone = TimeZone(identifier: "Asia/Taipei")
                datefomatter.locale = Locale(identifier: "zh_Hant_TW")
                calendar.locale = Locale(identifier: "zh_Hant_TW")
                calendar.timeZone = TimeZone(identifier: "Asia/Taipei")!
                var fruitsDataTemp: [APIModel.FruitData] = []
                datefomatter.dateFormat = "YYYY"
                
                let todayYearInTaiwan:Int = Int(datefomatter.string(from: Date()))! - 1911 // 民果年
                
                for j in 0..<(response.Data.count) {
                    if response.Data[j].CropName == fruit.CropName {
                        var fruitRes = response.Data[j]
                        fruitRes.generalName = fruit.CropName
                        fruitsDataTemp.append(fruitRes)
                    }
                }
                
                datefomatter.dateFormat = "YYYY.MM.dd"
                
                DispatchQueue.main.async {
                    self.arrEverdayAverageCostInLastWeek.removeAll()
                    for d in 0..<7 {
                        let astartDate = calendar.date(byAdding: .day, value: -(d+6), to: Date())!
                        let atodayDate = calendar.date(byAdding: .day, value: -(d), to: Date())!
                        
                        var gropCost:Float = 0
                        var amount:Float = 0
                        
                        let newStartDateString = datefomatter.string(from: astartDate)
                        let newTodayDateString = datefomatter.string(from: atodayDate)
                        // 民國年：Calendar(identifier: .republicOfChina)
                        for j in 0..<fruitsDataTemp.count {
                            let year = Int(fruitsDataTemp[j].TransDate.prefix(3))! + 1911
                            let strdate = "\(year)\(fruitsDataTemp[j].TransDate.suffix(6))"
                            if datefomatter.date(from: newStartDateString)! <= datefomatter.date(from: strdate)! && datefomatter.date(from: strdate)! <= datefomatter.date(from: newTodayDateString)! {
                                amount += fruitsDataTemp[j].Trans_Quantity
                                gropCost += (fruitsDataTemp[j].Avg_Price*fruitsDataTemp[j].Trans_Quantity)
                            }
                        }
                        let datefomatter2 = DateFormatter()
                        datefomatter2.dateFormat = "MM-dd"
                        datefomatter2.timeZone = TimeZone(identifier: "Asia/Taipei")
                        
                        self.arrEverdayAverageCostInLastWeek.append(DetailRowModel(returnDate: "\(todayYearInTaiwan)-\(datefomatter2.string(from: atodayDate))", returnCost: gropCost/amount))
                        
                    }
                }
                DispatchQueue.main.async {
                    self.arrEverdayAverageCostInLastWeek = self.arrEverdayAverageCostInLastWeek.sorted(by: {$0.returnDate>$1.returnDate})
                    self.isLoading = false
                }
                
            }
        self.cancellables.insert(cancellable)
    }
    
    func saveFavorate(item :APIModel.FruitData) {
        let CropName = item.CropName
        var savedList :[String] = []
        if let userDefaultList = UserDefaults.standard.object(forKey: "favorateList") as? [String] {
            savedList = userDefaultList
            savedList.append(CropName)
            UserDefaults.standard.set(savedList, forKey: "favorateList")
        } else { // 如果還沒存過
            var savedList :[String] = []
            savedList.append(CropName)
            UserDefaults.standard.set(savedList, forKey: "favorateList")
        }
    }
    
    //MARK: -
    func removeFavorate(item :APIModel.FruitData) {
        var savedList :[String] = []
        if let userDefaultList = UserDefaults.standard.object(forKey: "favorateList") as? [String] {
            savedList = userDefaultList
            for i in 0..<savedList.count {
                if savedList[i] == item.CropName {
                    savedList.remove(at: i)
                    UserDefaults.standard.set(savedList, forKey: "favorateList")
                    return
                }
            }
        }
    }
    
}
