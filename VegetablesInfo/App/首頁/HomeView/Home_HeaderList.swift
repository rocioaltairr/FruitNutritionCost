//
//  HeaderListRow.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/11.
//

import SwiftUI

struct Home_HeaderList: View {
    @State var item :APIModel.FruitData?
    @Binding var unitType: String
    
    var body: some View {
        HStack {
            if let imgName = item?.generalName {
                let filtedItem = ItemsList.filter{$0.image == imgName}
                if filtedItem.count == 0 {
                    Image(imgName)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80, alignment: .center)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
                        .background(
                            LinearGradient(gradient: Gradient(colors: ItemsList[0].gradientColors), startPoint: .top, endPoint: .bottom)
                        )
                        .cornerRadius(8)
                } else {
                    Image(imgName)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80, alignment: .center)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
                        .background(
                            LinearGradient(gradient: Gradient(colors: filtedItem[0].gradientColors), startPoint: .top, endPoint: .bottom)
                        )
                        .cornerRadius(8)
                }
            }
            
            HStack(alignment: .center, spacing: 5) {
                Text(item?.CropName ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(unitType)
            }
            Spacer()
        }
    }
}

// MARK: - PREVIEW
struct Home_HeaderList_Previews: PreviewProvider {
    @State static var unitType: String = "平均批發價/公斤"
    static var previews: some View {
        Home_HeaderList(unitType: $unitType)
    }
}

