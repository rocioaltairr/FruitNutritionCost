//
//  DetailNutrientsView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/11.
//

import SwiftUI

struct DetailNutrientsView: View {
    // MARK: - PROPERTIES
    var fruit :APIModel.FruitData?
    let nutrients: [String] = ["熱量", "糖分", "脂肪", "蛋白質", "營養", "成分"]

    // MARK: - BODY

    var body: some View {
      GroupBox() {
        DisclosureGroup("每100g 營養素") {
          ForEach(0..<nutrients.count, id: \.self) { item in
            Divider().padding(.vertical, 2)
            HStack {
              Group {
                Image(systemName: "info.circle")
                Text(nutrients[item])
              }
              .foregroundColor(returnTextColor())
              .font(Font.system(.body).bold())
              
              Spacer(minLength: 25)
                Text(returnTextString()[item])
                .multilineTextAlignment(.trailing)
            }
          }
        }.foregroundColor(Color.gray)
      } //: BOX
    }
    func returnTextColor() -> Color {
        var TextColor:Color = ItemsList[0].gradientColors[1]
        let filtedItem = ItemsList.filter{$0.image == fruit?.generalName}
        
        if filtedItem.count != 0 {
            TextColor = filtedItem[0].gradientColors[1]
        }
        return TextColor
    }
    
    func returnTextString() -> [String] {
        var strText:[String] = ["", "", "", "", "", ""]
        let filtedItem = ItemsList.filter{$0.image == fruit?.generalName}
        
        if filtedItem.count != 0 {
            strText = filtedItem[0].nutrition
        }
        return strText
        
    }
}

struct DetailNutrientsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNutrientsView()
          .preferredColorScheme(.dark)
          .previewLayout(.fixed(width: 375, height: 480))
          .padding()
    }
}
//["雜柑","火龍果","百香果","酪梨","草莓","洋香瓜","藍莓","西瓜","椰子","芒果","奇異果","蓮霧","榴槤","木瓜","鳳梨","香蕉","小番茄","蘋果","葡萄","檸檬","甜橙"]
