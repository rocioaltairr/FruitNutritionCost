//
//  FavorateView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/16.
//

import SwiftUI

struct FavorateView: View {
    let userDefault = UserDefaults()
    @State var fruitData: APIModel?
    @State var fruits:[String] = [""]
    @State private var isLoading = false
    @State var unitType = "平均批發價/公斤"
    @State var isEmpty = false
    
    var body: some View {
        GeometryReader { geometry in
            LoadingView(isShowing: .constant(isLoading)) {
                NavigationView {
                    ZStack {
                        if isEmpty == false {
                            VStack {
                                if let fruitData = fruitData {
                                    List {
                                        ForEach(fruitData.Data, id:\.id) { item in
                                            NavigationLink(destination: DetailView(item: item, unitType: $unitType)) {
                                                Home_ListRow(item: item, unitType: $unitType)
                                            }
                                        }
                                    }
                                    .listStyle(PlainListStyle()) // <- add here
                                    .frame(height: geometry.size.height - 16)
                                    .navigationTitle("最愛水果")
                                }
                            }
                        } else {
                            VStack {
                                Text("尚未加入最愛水果唷～")
                            }
                        }
                    }
                }//: NAVIGATION
                // .foregroundColor(.red) 全部字
                .onAppear(perform: self.loadUserDefaultData)
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
    
    
    func loadUserDefaultData() {
        if let userDefaultList = userDefault.array(forKey: "favorateList") as? [String] {
            isEmpty = false
            fruits = userDefaultList
            loadData()
        } else {
            isEmpty = true
            print("")
        }
    }
    
    func loadData() {
        var fruitsDataTemp: [APIModel.FruitData] = []
        var groupFruitsData: [APIModel.FruitData] = []
        
        
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
                    let fruitData = try JSONDecoder().decode(APIModel.self, from: data)
                    for j in 0..<fruitData.Data.count {
                        if fruitData.Data[j].CropName == fruits[i] {
                            var fruit = fruitData.Data[j]
                            fruit.generalName = fruits[i]
                            fruitsDataTemp.append(fruit)
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
            let groupedFruits = Dictionary(grouping: fruitsDataTemp, by: {$0.CropName})
            groupFruitsData.removeAll()
            for fruit in fruits {
                var gropCost:Float = 0
                var amount:Float = 0
                if let groupItems = groupedFruits[fruit]  {
                    for j in 0..<groupItems.count {
                        amount += groupItems[j].Trans_Quantity
                        gropCost += (groupItems[j].Avg_Price*groupItems[j].Trans_Quantity)
                        
                    }
                    var data = groupedFruits[fruit]![0]
                    data.Avg_Price = gropCost/amount// 一週均價
                    groupFruitsData.append(data)
                }
            }
            fruitsDataTemp.removeAll()
            isLoading = false
            self.fruitData = APIModel(RS: "OK", Data:  groupFruitsData)
        }
    }
    
}

struct FavorateView_Previews: PreviewProvider {
    static var previews: some View {
        FavorateView()
    }
}
