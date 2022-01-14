//
//  DetailView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/11.
//

import SwiftUI
struct DetailView: View {
    @State var item :APIModel.FruitData
    @Binding var unitType: String
    @StateObject var viewModel = FruitDetailViewModel(service: FruitsService())
    
    var body: some View {
        //MARK: - HEADER點進
        if item.Avg_Price == 0 { // 水果營養資訊
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                NavigationView {
                    ScrollView(.vertical,showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            // 圖片Header
                            Detail_HeaderView(item: item)
                            
                            VStack (alignment: .leading, spacing: 20){
                                
                                let filtedItem = ItemsList.filter{$0.image == item.generalName}
                                
                                Text(item.CropName)
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(filtedItem.count == 0 ? ItemsList[0].gradientColors[1] : filtedItem[0].gradientColors[1])
                                
                                // 營養
                                DetailNutrientsView(fruit: item)
                                
                                // 更多資訊
                                Text("更多資訊\(item.CropName)".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(returnTextColor())
                                
                                // 說明文字
                                Text(ItemsList[0].description)
                                    .multilineTextAlignment(.leading)
                                
                            } //: VSTACK
                            .padding(.horizontal,20)
                        } //: VSTACK
                        .navigationBarHidden(true)
                    } //: SCROLL
                    .edgesIgnoringSafeArea(.top)
                    .navigationBarItems(trailing:
                                            VStack {
                        Button(action: {
                            viewModel.isFavorate.toggle()
                            viewModel.isFavorate ? viewModel.saveFavorate(item: item) : viewModel.removeFavorate(item: item)
                        }) {
                            Image(systemName: "suit.heart")
                        }.foregroundColor(viewModel.isFavorate ? Color.red:Color.gray)
                    })
                } //: NAVIGATION
                .navigationViewStyle(StackNavigationViewStyle())
            }
        } else { // 水果一週價格
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                VStack(alignment: .leading, spacing: 0) {
                    // 一週價格
                    List {
                        Section(header:
                                    Text(" 一週價格")) {
                            ForEach(viewModel.arrEverdayAverageCostInLastWeek) { week in
                                DetailListRow(dateString:  week.returnDate, CostString:  week.returnCost, unitType: $unitType)
                            }
                        }
                    }
                } //: VSTACK
                .edgesIgnoringSafeArea(.top)
                .navigationBarItems(trailing:
                                        VStack {
                    Button(action: {
                        viewModel.isFavorate.toggle()
                        viewModel.isFavorate ? viewModel.saveFavorate(item: item) : viewModel.removeFavorate(item: item)
                    }) {
                        Image(systemName: "suit.heart")
                    }.foregroundColor(viewModel.isFavorate ? Color.red:Color.gray)
                    
                })
                .navigationBarTitle(Text(item.CropName),displayMode: .inline)
                .navigationViewStyle(StackNavigationViewStyle())
                .onAppear{viewModel.getFruitDetail(from: item)}
                // MARK: - Model—>View (1) View顯示時onAppear調用，緊接著調用viewModel中getFruitDetail()
                
                
            }
        }
    }
    
    // 取得文字顏色
    func returnTextColor() -> Color {
        var TextColor:Color = ItemsList[0].gradientColors[1]
        let filtedItem = ItemsList.filter{$0.image == item.generalName}
        
        if filtedItem.count != 0 {
            TextColor = filtedItem[0].gradientColors[1]
        }
        return TextColor
    }
}

struct DetailView_Previews: PreviewProvider {
    @State static var unitType: String = "平均批發價/公斤"
    @State static var item: APIModel.FruitData = APIModel.FruitData(TransDate: "", CropName: "", Avg_Price: 0, Trans_Quantity: 0)
    static var previews: some View {
        DetailView(item: item, unitType: $unitType)
    }
}


/*
struct DetailView: View {
    @State var item :APIModel.FruitData
    @Binding var unitType: String
    // MARK: - Model—>View (4) View 中的ObservedObject收到通知後驅動 UI 更新
    @ObservedObject private var viewModel = DetailViewModel()
    
    var body: some View {
        //MARK: - HEADER點進
        if item.Avg_Price == 0 { // 水果營養資訊
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                NavigationView {
                    ScrollView(.vertical,showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            // 圖片Header
                            Detail_HeaderView(item: item)
                            
                            VStack (alignment: .leading, spacing: 20){
                                
                                let filtedItem = ItemsList.filter{$0.image == item.generalName}
                                
                                Text(item.CropName)
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(filtedItem.count == 0 ? ItemsList[0].gradientColors[1] : filtedItem[0].gradientColors[1])
                                
                                // 營養
                                DetailNutrientsView(fruit: item)
                                
                                // 更多資訊
                                Text("更多資訊\(item.CropName)".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(returnTextColor())
                                
                                // 說明文字
                                Text(ItemsList[0].description)
                                    .multilineTextAlignment(.leading)
                                
                            } //: VSTACK
                            .padding(.horizontal,20)
                        } //: VSTACK
                        .navigationBarHidden(true)
                    } //: SCROLL
                    .edgesIgnoringSafeArea(.top)
                    .navigationBarItems(trailing:
                                            VStack {
                        Button(action: {
                            viewModel.isFavorate.toggle()
                            viewModel.isFavorate ? viewModel.saveFavorate(item: item) : viewModel.removeFavorate(item: item)
                        }) {
                            Image(systemName: "suit.heart")
                        }.foregroundColor(viewModel.isFavorate ? Color.red:Color.gray)
                    })
                } //: NAVIGATION
                .navigationViewStyle(StackNavigationViewStyle())
            }
        } else { // 水果一週價格
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                VStack(alignment: .leading, spacing: 0) {
                    // 一週價格
                    List {
                        Section(header:
                                    Text(" 一週價格")) {
                            ForEach(viewModel.arrEverdayAverageCostInLastWeek) { week in
                                DetailListRow(dateString:  week.returnDate, CostString:  week.returnCost, unitType: $unitType)
                            }
                        }
                    }
                } //: VSTACK
                .edgesIgnoringSafeArea(.top)
                .navigationBarItems(trailing:
                                        VStack {
                    Button(action: {
                        viewModel.isFavorate.toggle()
                        viewModel.isFavorate ? viewModel.saveFavorate(item: item) : viewModel.removeFavorate(item: item)
                    }) {
                        Image(systemName: "suit.heart")
                    }.foregroundColor(viewModel.isFavorate ? Color.red:Color.gray)
                    
                })
                .navigationBarTitle(Text(item.CropName),displayMode: .inline)
                .navigationViewStyle(StackNavigationViewStyle())
                .onAppear{viewModel.getFruitDetail(item: item)}
                // MARK: - Model—>View (1) View顯示時onAppear調用，緊接著調用viewModel中getFruitDetail()
                
                
            }
        }
    }
    
    // 取得文字顏色
    func returnTextColor() -> Color {
        var TextColor:Color = ItemsList[0].gradientColors[1]
        let filtedItem = ItemsList.filter{$0.image == item.generalName}
        
        if filtedItem.count != 0 {
            TextColor = filtedItem[0].gradientColors[1]
        }
        return TextColor
    }
}

struct DetailView_Previews: PreviewProvider {
    @State static var unitType: String = "平均批發價/公斤"
    @State static var item: APIModel.FruitData = APIModel.FruitData(TransDate: "", CropName: "", Avg_Price: 0, Trans_Quantity: 0)
    static var previews: some View {
        DetailView(item: item, unitType: $unitType)
    }
}*/

