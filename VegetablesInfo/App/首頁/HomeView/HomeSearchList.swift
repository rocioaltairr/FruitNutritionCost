//
//  HomeSearchList.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/28.
//

import SwiftUI

struct HomeSearchList: View {
    @State var fruitData: APIModel
    @State var unitType: String
    @State var text: String
    var body: some View {
        List {
            ForEach(fruitData.Data, id:\.id) { item in
                if item.CropName.contains(text) {
                    NavigationLink(destination: DetailView(item: item, unitType: $unitType)) {
                        Home_ListRow(item: item, unitType: $unitType)
                    }
                }
            }
        }        
    }
}

struct HomeSearchList_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchList(fruitData: APIModel(RS: "", Data: []), unitType: "平均批發價/公斤", text: "")
    }
}
