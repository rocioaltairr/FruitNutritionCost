//
//  APIManager.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/11.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
    case decodingError
    case noData
}

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "@@API回傳物件Decode失敗"
        case .errorCode(let code):
            return "@@Error:"
        case .unknown:
            return "@@不明錯誤"
        }
    }
}

class APIManager {
    
    private init() {} // 防止做超過一個物件
    static let shared = APIManager()
    
    // MARK: - 取得某種水果近一週，每天的一週平均價API
    func getFruitDatail(item :APIModel.FruitData, completion: @escaping (Result<APIModel?,NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: getTwoWeeksSingleFruitURL(item :item)) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let fruits = try? JSONDecoder().decode(APIModel.self, from: data)
            if fruits == nil {
                completion(.failure(.decodingError))
            } else {
                completion(.success(fruits))
                
            }
            
        }.resume()
    }
    
    // MARK: - 生產某種水果這兩週資訊的ＵＲＬ
    func getTwoWeeksSingleFruitURL(item :APIModel.FruitData) -> URL { // 因為要取得近一週，個天的一週平均價，故需取得二週資訊
        let datefomatter = DateFormatter()
        datefomatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        datefomatter.locale = Locale(identifier: "zh_Hant_TW")
        let startDate = Calendar.current.date(byAdding: .day, value: -13, to: Date())!
        datefomatter.dateFormat = "YYYY"
        let startYearInTaiwan:Int = Int(datefomatter.string(from: startDate))! - 1911
        let todayYearInTaiwan:Int = Int(datefomatter.string(from: Date()))! - 1911
        
        datefomatter.dateFormat = "MM.dd"
        let startDateString = datefomatter.string(from: startDate)
        let todayDateString = datefomatter.string(from: Date())
        
        let queryString = "Start_time=\(startYearInTaiwan).\(startDateString)&End_time=\(todayYearInTaiwan).\(todayDateString)&CropName=\(item.CropName)"
        let escapedQueryString = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = "https://data.coa.gov.tw/api/v1/AgriProductsTransType/?\(escapedQueryString)"
        return URL(string: urlString)!
    }
}




/*
 
 class Subscription {
 let cancel: () -> Void
 init(cancel: @escaping () -> Void) {
 self.cancel = cancel
 }
 deinit {
 cancel()
 }
 }
 /**
  使用URLSession操作dask 是異步的，需要時間去取得data
  
  */
 struct Publisher<Value> {
 let subscribe: (@escaping (Value) -> Void) -> Subscription
 }
 extension Publisher {
 func map<NewValue>(_ transform: @escaping (Value) -> NewValue) -> Publisher<NewValue> {
 return Publisher<NewValue> { newValueHandler in
 return self.subscribe { value in
 let newValue = transform(value)
 newValueHandler(newValue)
 }
 }
 }
 }
 extension URLSession {
 func dataTaskPublisher(with url: URL) -> Publisher<Data> {
 return Publisher<Data> { valueHandler in
 let task = self.dataTask(with: url) { data, response, error in
 if let data = data {
 valueHandler(data)
 }
 }
 task.resume()
 return Subscription {
 task.cancel()
 }
 }
 }
 }
 */
// Combime is Costomize handling of asynchronous events by combininb event-processing operators
// 是一套透過組合變換事件操作來處理亦不事件的標準庫
// 事件執行過程關西包括：被觀察者Pubisher和觀察者Subcriber
// 在編成中如果數據流能保證是單向的，會讓程序變得簡單
/*
 Benefits of using Combine framework:
 
 Simple asynchronous code.
 Multithreading is simplified.
 Composable components of business logic that can be easily combined into chains.
 
 */

