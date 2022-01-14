//
//  HomeFruitList.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/28.
//

import SwiftUI

struct HomeFruitList: View {
    @State var fruitData: APIModel?
    @Binding var unitType: String
    var body: some View {
        List {
            ForEach(ItemsList, id:\.id) { list in
                let headerData = APIModel.FruitData(generalName:list.image,TransDate: "", CropName: list.image, Avg_Price: 0, Trans_Quantity: 0)
                
                Section(header: Home_ListHeader(headerData:headerData, unitType: $unitType).frame(height: 80)) {
                    ForEach(fruitData!.Data, id:\.id) { item in
                        if item.generalName == list.image {
                            NavigationLink(destination: DetailView(item: item, unitType: $unitType)) {
                                Home_ListRow(item: item, unitType: $unitType)
                            }
                        }
                    }
                }//.listRowInsets(EdgeInsets())
            }.listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        
    }
}

