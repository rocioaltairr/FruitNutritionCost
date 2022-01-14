//
//  LoadingView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/15.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: 120,
                       height: 120)
                .position(x: geometry.size.width/2, y: geometry.size.height/2)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary.opacity(0.5))
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
                
            }//.ignoresSafeArea()
        }.ignoresSafeArea()
    }

}
