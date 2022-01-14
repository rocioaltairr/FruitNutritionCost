//
//  HomeListHeader.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/16.
//

import SwiftUI

struct Home_ListHeader: View {
    @State var headerData: APIModel.FruitData
    @Binding var unitType: String
    var body: some View {
        NavigationLink(destination: DetailView(item: headerData, unitType: $unitType)) {
            Home_HeaderList(item: headerData, unitType: $unitType)
        }
    }
}

struct Home_ListHeader_Previews: PreviewProvider {
    @State static var unitType: String = "平均批發價/公斤"
    @State static var item: APIModel.FruitData = APIModel.FruitData(TransDate: "", CropName: "", Avg_Price: 0, Trans_Quantity: 0)
    static var previews: some View {
        Home_ListHeader(headerData: item, unitType: $unitType)
    }
}
