//
//  APIService.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/28.
//

import Foundation

protocol APIService {
    @available(iOS 15.0.0, *)
    func fetchFruitDatail(item :APIModel.FruitData) async throws -> [APIModel.FruitData]
}

final class APIServiceImpl:APIService {
    @available(iOS 15.0.0, *)
    func fetchFruitDatail(item :APIModel.FruitData) async throws -> [APIModel.FruitData] {
        let urlSession = URLSession.shared
        let url = getTwoWeeksSingleFruitURL(item: item)
        let (data,_) = try await urlSession.data(from:url)
        let arr = try JSONDecoder().decode(APIModel.self, from: data)
        return arr.Data
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
