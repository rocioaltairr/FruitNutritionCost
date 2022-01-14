//
//  DetailViewModel.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/18.
//

import Foundation
import Combine
//定義被觀察的資料型別
//當 view 重新產生時，ObservedObject 儲存的資料不會維持之前的內容

class DetailViewModel: ObservableObject {
    // MARK: - Model—>View (2) ViewModel通過Published修飾的屬性發出變換通知
    @Published var arrEverdayAverageCostInLastWeek:[DetailRowModel] = [] // 這週每一天的平均價
    @Published var isLoading = false
    @Published var isFavorate = false
    
    // MARK: - Model—>View (3) ViewModel中 getFruitDetail()，構造獲取數據並轉化為Model
    func getFruitDetail(item :APIModel.FruitData) {
        let datefomatter = DateFormatter()
        var calendar = Calendar(identifier: .republicOfChina)
        datefomatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        datefomatter.locale = Locale(identifier: "zh_Hant_TW")
        calendar.locale = Locale(identifier: "zh_Hant_TW")
        calendar.timeZone = TimeZone(identifier: "Asia/Taipei")!
        
        self.isLoading = true
        
        // 是否為我的最愛水果
        if let userDefaultList = UserDefaults.standard.object(forKey: "favorateList") as? [String] {
            if userDefaultList.contains(item.CropName) {
                self.isFavorate = true
            }
        }
        
        APIManager.shared.getFruitDatail(item :item) { result in
            switch result {
            case .success(let fruitData):
                print("")
                var fruitsDataTemp: [APIModel.FruitData] = []
                datefomatter.dateFormat = "YYYY"
                
                let todayYearInTaiwan:Int = Int(datefomatter.string(from: Date()))! - 1911 // 民果年
                
                for j in 0..<(fruitData?.Data.count)! {
                    if fruitData?.Data[j].CropName == item.CropName {
                        var fruit = fruitData?.Data[j]
                        fruit?.generalName = item.CropName
                        fruitsDataTemp.append(fruit!)
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
                
            case .failure(let error):
                print(error)
            }
        }
        
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
                }
            }
            UserDefaults.standard.set(savedList, forKey: "favorateList")
        } else { // 如果還沒存過
            
        }
    }
}


/*
class DetailViewModel: ObservableObject {
    @Published var item :APIModel.FruitData?
    @Published var detailItems: [APIModel.FruitData] = []
    @Published var fruitsDataTemp: [APIModel.FruitData] = []
    @Published var weekItems:[DetailRowModel] = []
    private var cancellables =  Set<AnyCancellable>()
    
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
        var returnDate :String?
        var returnCost :Float?
        let startDate = Calendar.current.date(byAdding: .day, value: -13, to: Date())!
        let todayDate = Date()
        
        datefomatter.dateFormat = "YYYY"
        let startYearInTaiwan:Int = Int(datefomatter.string(from: startDate))! - 1911
        let todayYearInTaiwan:Int = Int(datefomatter.string(from: todayDate))! - 1911
        
        datefomatter.dateFormat = "MM.dd"
        let startDateString = datefomatter.string(from: startDate)
        let todayDateString = datefomatter.string(from: todayDate)
        
        let queryString = "Start_time=\(startYearInTaiwan).\(startDateString)&End_time=\(todayYearInTaiwan).\(todayDateString)&CropName=\(item?.CropName ?? "")"
        let escapedQueryString = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = "https://data.coa.gov.tw/api/v1/AgriProductsTransType/?\(escapedQueryString)"
        let url = URL(string: urlString)!
        // 先把14天的資料取得，在個別算出一週每天的平均價格
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data,response in // 發佈者使用提供的閉包，轉化元素到另一個元素時，如果發生錯誤，則終止發補
                // 如果閉包不會拋出錯誤則改用map
                guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }.decode(type: APIModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in}) { apiModel in // 接收器（接收值：）
                // 將閉包行為的訂閱者，附加到永不失敗的發布者
                for j in 0..<apiModel.Data.count {
                    if apiModel.Data[j].CropName == self.item?.CropName ?? "" {
                        var fruit = apiModel.Data[j]
                        fruit.generalName = self.item?.CropName ?? ""
                        self.fruitsDataTemp.append(fruit)
                    }
                }
                self.datefomatter.dateFormat = "YYYY.MM.dd"
                self.datefomatter.locale = Locale(identifier: "zh_Hant_TW")
                var calendar = Calendar(identifier: .republicOfChina)
                calendar.locale = Locale(identifier: "zh_Hant_TW")
                calendar.timeZone = TimeZone(identifier: "Asia/Taipei")!
                for d in 0..<7 {
                    let eachStartDate = calendar.date(byAdding: .day, value: -(d+6), to: Date())!
                    let eachTodayDate = calendar.date(byAdding: .day, value: -(d), to: Date())!
                    
                    var gropCost:Float = 0
                    var amount:Float = 0
                    
                    let newStartDateString = self.datefomatter.string(from: eachStartDate)
                    let newTodayDateString = self.datefomatter.string(from: eachStartDate)
                    // 民國年：Calendar(identifier: .republicOfChina)
                    for j in 0..<self.fruitsDataTemp.count {
                        let year = Int(self.fruitsDataTemp[j].TransDate.prefix(3))! + 1911
                        let strdate = "\(year)\(self.fruitsDataTemp[j].TransDate.suffix(6))"
                        if self.datefomatter.date(from: newStartDateString)! <= self.datefomatter.date(from: strdate)! && self.datefomatter.date(from: strdate)! <= self.datefomatter.date(from: newTodayDateString)! {
                            amount += self.fruitsDataTemp[j].Trans_Quantity
                            gropCost += (self.fruitsDataTemp[j].Avg_Price*self.fruitsDataTemp[j].Trans_Quantity)
                        }
                    }
                    let datefomatter2 = DateFormatter()
                    datefomatter2.dateFormat = "MM-dd"
                    datefomatter2.timeZone = TimeZone(identifier: "Asia/Taipei")
                    returnCost = gropCost/amount
                    //returnCost = String(format: "%.1f", gropCost/amount)
                    returnDate = "\(todayYearInTaiwan)-\(datefomatter2.string(from: eachTodayDate))"
                    self.weekItems.append(DetailRowModel(returnDate: returnDate ?? "", returnCost: returnCost ?? 0))
                }
                
                self.weekItems = self.weekItems.sorted(by: {$0.returnDate>$1.returnDate})
                //self.detailItems = apiModel.Data
            }
            .store(in: &cancellables)
        
    }
    
}

extension DetailViewModel {
    

}*/
/*

struct APIClient {

    struct Response<T> { // 1
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> { // 2
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data) // 4
                return Response(value: value, response: result.response) // 5
            }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
}*/
//if customButton.frame.minX <= position.x && position.x <= customButton.frame.maxX {
//    if customButton.frame.minY - offset <= position.y && position.y <= customButton.frame.maxY - offset{
//        showViewController()
//    }
//}
/*訂閱者等廣播者處理完資訊，訂閱者在接收資料去處理*/
