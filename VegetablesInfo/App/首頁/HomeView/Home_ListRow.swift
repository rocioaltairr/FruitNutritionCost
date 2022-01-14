//
//  ListRow.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/11.
//

import SwiftUI

struct Home_ListRow: View {
    @State var item :APIModel.FruitData?
    @Binding var unitType: String
    var body: some View {
        if item?.Trans_Quantity != 0 {
            HStack {
                Text(item?.CropName ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                VStack {
                    if unitType == "平均批發價/公斤"{
                        Text(String(format: "%.1f", item!.Avg_Price))
                            .font(.title2)
                            .fontWeight(.bold)
                    } else if unitType == "平均批發價/台斤"{
                        Text(String(format: "%.1f", item!.Avg_Price * 1.66666667 ))
                            .font(.title2)
                            .fontWeight(.bold)
                    } else if unitType == "粗估零售價/公斤"{
                        Text(String(format: "%.1f", item!.Avg_Price * 2.5))
                            .font(.title2)
                            .fontWeight(.bold)
                    } else if unitType == "粗估零售價/台斤"{
                        Text(String(format: "%.1f", item!.Avg_Price * 1.66666667 * 2.5 ))
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        
    }
}

// MARK: - PREVIEW
struct Home_ListRow_Previews: PreviewProvider {
    @State static var unitType: String = "平均批發價/公斤"
    static var previews: some View {
        Home_ListRow(unitType: $unitType)
    }
}
