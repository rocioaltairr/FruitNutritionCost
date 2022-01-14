//
//  FruitsService.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/28.
//

import Foundation
import Combine

protocol FruitsServiceProtocol {
    func requetFruitDatail(from fruit: APIModel.FruitData) -> AnyPublisher<APIModel,APIError>
}

struct FruitsService:FruitsServiceProtocol {
    func requetFruitDatail(from fruit: APIModel.FruitData) -> AnyPublisher<APIModel, APIError> {
        return URLSession.shared
            .dataTaskPublisher(for: getTwoWeeksSingleFruitURL(from :fruit))
            .receive(on: DispatchQueue.main) // 因為data做UI更新，我們希望在Main Thread接收他
            .mapError { _ in APIError.unknown}
            .flatMap { data, response -> AnyPublisher<APIModel, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: APIModel.self, decoder: JSONDecoder())
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                    
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - 生產某種水果這兩週資訊的ＵＲＬ
    func getTwoWeeksSingleFruitURL(from fruit: APIModel.FruitData) -> URL { // 因為要取得近一週，個天的一週平均價，故需取得二週資訊
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
        
        let queryString = "Start_time=\(startYearInTaiwan).\(startDateString)&End_time=\(todayYearInTaiwan).\(todayDateString)&CropName=\(fruit.CropName)"
        let escapedQueryString = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = "https://data.coa.gov.tw/api/v1/AgriProductsTransType/?\(escapedQueryString)"
        return URL(string: urlString)!
    }
}


