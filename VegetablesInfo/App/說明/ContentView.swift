//
//  ContentView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/19.
//

import SwiftUI
import Combine

struct User: Decodable, Identifiable {
    let id:Int
    let name:String
}
final class ViewModel: ObservableObject {
    @Published var time = ""
    @Published var users = [User]()
    private var cancellables =  Set<AnyCancellable>()
    
    let formatter: DateFormatter = {
        let df = DateFormatter()
        df.timeStyle = .medium
        return df
    }()
    
    init() {
        //setupPublishers()
    }
    
    private func setupPublishers() {
        //setupTimerPublishers()
        //setupDataTaskPublisher()
    }
    
    
    private func setupDataTaskPublisher() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data,response in
                guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink (receiveCompletion:{_ in}) { users in
                self.users = users
            }
            .store(in: &cancellables)

    }
    
    private func setupTimerPublishers() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink{ value in
                self.time = self.formatter.string(from: value)
            }
            .store(in: &cancellables)
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("選擇單位可以選擇零售價或批發價，零售價為批發價x2.5，為粗估單位僅作參考。\n資料來源為行政院農業委員會資料開放平台。")
            //Spacer()
//            Text(viewModel.time)
//                .padding()
//            List(viewModel.users) { user in
//                Text(user.name)
            }
            .frame(width: 300, height: 300)
        }
        
    //}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
/*
開發 SwiftUI App，為了實現 source of truth，確保單一資料來源，避免資料不同步的問題，我們會使用 State & Binding 管理 struct 型別的資料，使用 StateObject ＆ObservedObject 管理 class 型別的資料。

用 @State 宣告的 property 將是資料來源，其它以 @Binding 宣告的 property 將參考它，存取同一份資料。

同樣的，用 @StateObject 宣告的 property 將是資料來源，其它以 @ObservedObject 宣告的 property 將參考它，存取同一份資料*/
