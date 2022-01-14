//
//  ContentView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/11.
//

import SwiftUI

struct HomeView: View {
    
    @State var unitType = "平均批發價/公斤"
    @State var shownChooseUnit = false
    @State var shownSearch = false
    @State var isSearching = false
    
    @State var message = ""
    @State var c: ((String)->(Void))?
    @State var isSuccess = false
    
    @ObservedObject var viewModel = HomeViewModel()
    
    @State var text: String = ""
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
    }
    // Varieties of types struct class protoco; geneirc enum function
    // 總結，簡單化跟聲明式式好的View設計重點，函有ViewModel支持，因為兩者呈現事務方式，通過interpreting function 還有 提供User敏感的意圖，讓View去呈現
    
    // View提供User意圖
    var body: some View {
        GeometryReader { geometry in
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                NavigationView {
                    ZStack {
                        VStack {
                            if let fruitData = viewModel.fruitDataModel {
                                List {
                                    if shownSearch {
                                        //: 搜尋Search Bar View
                                        SearchView(text: $text, isSearching: $isSearching, shownSearch: $shownSearch)
                                    }
                                    if isSearching == false || text.isEmpty{
                                        //: 主頁List
                                        HomeFruitList(fruitData: fruitData, unitType: $unitType)
                                            .frame(height: geometry.size.height - 16)
                                    } else {
                                        //: 搜尋結果List
                                        HomeSearchList(fruitData: fruitData, unitType: unitType, text: text)
                                            .frame(height: geometry.size.height - 16)
                                    }
                                }.onAppear{
                                    UITableView.appearance().showsVerticalScrollIndicator = false
                                }
                                .listStyle(PlainListStyle()) // 取消 List 的padding
                            }
                        }
                        if shownChooseUnit {
                            //: 選擇單位Alert
                            AlertView(unitType:$unitType,shown: $shownChooseUnit, closureA: $c ,isSuccess: isSuccess, message: message)
                        }
                        
                    }
                    .navigationTitle("水果")
                    .navigationBarItems(trailing:
                                            VStack {
                        Button("選擇單位") {
                            shownChooseUnit.toggle()
                            
                        }.foregroundColor(Color.gray)
                    })
                    .navigationBarItems(leading:
                                            VStack {
                        Button("搜尋") {
                            shownSearch.toggle()
                            if shownSearch == false {
                                isSearching = false
                            }
                        }.foregroundColor(Color.gray)
                    })
                }//: NAVIGATION
                // .foregroundColor(.red) 全部字
                //.onAppear(perform: viewModel.setupDataTaskPublisher)
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
    
    func getToday() -> String {
        let datefomatter = DateFormatter()
        datefomatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        datefomatter.dateFormat = "MM.dd"
        let todayDate = Date()
        return  datefomatter.string(from: todayDate)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
