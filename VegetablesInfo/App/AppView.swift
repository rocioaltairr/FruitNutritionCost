//
//  AppView.swift
//  OrderFood
//
//  Created by 2008007NB01 on 2021/11/11.
//

import SwiftUI

struct AppView:View {
    @State private var showAlert = false
    
    var body: some View {
        TabView {
            HomeView()
            .tabItem({
                Image(systemName: "list.bullet.rectangle")
                Text("清單")
            })
            
            ContentView()
            .tabItem({
                Image(systemName: "face.smiling")
                Text("說明")
            })
            
            FavorateView()
            .tabItem({
                Image(systemName: "suit.heart")
                Text("最愛")
            })
            
            SettingView()
            .tabItem({
                Image(systemName: "info.circle.fill")
                Text("資訊")
            })
        }
    }
}
struct ButtonTab: View {
    @State var showAlert = false
    var body : some View {
        VStack {
            Button("show alert") {
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("hello"),
                  dismissButton: .default(Text("ok")))
        }
    }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
