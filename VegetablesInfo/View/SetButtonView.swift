//
//  SetButtonView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/15.
//

import SwiftUI

struct SetButtonView: View {
  // MARK: - PROPERTIES
  
  @AppStorage("isOnboarding") var isOnboarding: Bool?
  
  // MARK: - BODY
  
  var body: some View {
    Button(action: {
      isOnboarding = false
    }) {
      HStack(spacing: 8) {
        Text("設定")
        
        Image(systemName: "arrow.right.circle")
          .imageScale(.large)
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
      .background(
        Capsule().strokeBorder(Color.white, lineWidth: 1.25)
      )
    } //: BUTTON
    .accentColor(Color.white)
  }
}

// MARK: - PREVIEW

struct SetButtonView_Previews: PreviewProvider {
  static var previews: some View {
      SetButtonView()
      .preferredColorScheme(.dark)
      .previewLayout(.sizeThatFits)
  }
}
