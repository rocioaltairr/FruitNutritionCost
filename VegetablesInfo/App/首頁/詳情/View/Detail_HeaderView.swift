//
//  DetailHeaderView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/11.
//

import SwiftUI

struct Detail_HeaderView: View {
    @State var item :APIModel.FruitData?
    @State private var isAnimatingImage: Bool = false
    var body: some View {
        ZStack {
            if let imgName = item?.generalName {
                let filtedItem = ItemsList.filter{$0.image == imgName}
                if filtedItem.count == 0 {
                    LinearGradient(gradient: Gradient(colors: ItemsList[0].gradientColors), startPoint: .top, endPoint: .bottom)
                } else {
                    LinearGradient(gradient: Gradient(colors: filtedItem[0].gradientColors), startPoint: .top, endPoint: .bottom)
                }
                
                Image(imgName)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                    .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
            }
            
        }
        .frame(height: 440)
        .onAppear() {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimatingImage = true
            }
        }
        
    }
}

// MARK: - PREVIEW
struct Detail_HeaderView_Previews: PreviewProvider {
  static var previews: some View {
      Detail_HeaderView()
      .previewLayout(.fixed(width: 375, height: 440))
  }
}
