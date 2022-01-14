//
//  CardView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/15.
//

import SwiftUI

struct CardView: View {
  // MARK: - PROPERTIES
  
  //var fruit: Fruit
  
  @State private var isAnimating: Bool = false
  @State var tabItem:TabItem?
    
  // MARK: - BODY
  
  var body: some View {
    ZStack {
      VStack(spacing: 20) {
        // FRUIT: IMAGE
//        Image("草莓")
//          .resizable()
//          .scaledToFit()
//          .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
//          .scaleEffect(isAnimating ? 1.0 : 0.6)
        
        // FRUIT: TITLE
          Text(tabItem?.name ?? "")
          .foregroundColor(Color.white)
          .font(.largeTitle)
          .fontWeight(.heavy)
          .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
        
        // FRUIT: HEADLINE
          Text(tabItem?.detail ?? "")
          .foregroundColor(Color.white)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 16)
          .frame(maxWidth: 480)
        
        // BUTTON: START
        SetButtonView()
      } //: VSTACK
    } //: ZSTACK
    .onAppear {
      withAnimation(.easeOut(duration: 0.5)) {
        isAnimating = true
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    .background(LinearGradient(gradient: Gradient(colors: [ Color("ColorAppleDark"),Color("ColorAppleLight")]), startPoint: .top, endPoint: .bottom))
    .cornerRadius(20)
    .padding(.horizontal, 20)
  }
}

// MARK: - PREVIEW

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
      CardView()
      .previewLayout(.fixed(width: 320, height: 640))
  }
}
