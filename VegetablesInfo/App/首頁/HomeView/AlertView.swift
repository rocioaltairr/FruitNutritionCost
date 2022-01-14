//
//  AlertView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/16.
//

import SwiftUI
//protocol AlertAction {
//    func a()
//}
struct AlertView: View {
    @Binding var unitType: String
    @Binding var shown: Bool
    @Binding var closureA: ((String)->(Void))?
    //@Binding var closureB: ((String)->(Void))?
    var isSuccess: Bool
    var message: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                //             Image(isSuccess ? "check":"remove").resizable().frame(width: 50, height: 50).padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                VStack {
                    Button("平均批發價/公斤") {
                        unitType = "平均批發價/公斤"
                        closureA?("Close")
                        shown.toggle()
                    }
                    //.foregroundColor(Color.gray)
                        .frame(width: UIScreen.main.bounds.width, height: 40)
                    Button("平均批發價/台斤") {
                        unitType = "平均批發價/台斤"
                        closureA?("Close")
                        shown.toggle()
                    }
                    //.foregroundColor(Color.gray)
                        .frame(width: UIScreen.main.bounds.width, height: 40)
                    Button("粗估零售價/公斤") {
                        unitType = "粗估零售價/公斤"
                        closureA?("Close")
                        shown.toggle()
                    }
                    //.foregroundColor(Color.gray)
                        .frame(width: UIScreen.main.bounds.width, height: 40)
                    Button("粗估零售價/台斤") {
                        unitType = "粗估零售價/台斤"
                        closureA?("Close")
                        shown.toggle()
                    }
                    //.foregroundColor(Color.gray)
                        .frame(width: UIScreen.main.bounds.width, height: 40)
                    Button("取消") {
                        closureA?("Close")
                        shown.toggle()
                    }.frame(width: UIScreen.main.bounds.width, height: 40)
                       // .foregroundColor(.gray)
                }.frame(width: UIScreen.main.bounds.width-50, height: 280)
                
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .clipped()
                    .gesture(
                    TapGesture()
                        .onEnded { _ in
                            //closureA?("Close")
                            //shown.toggle()
                        })
                
                //            Spacer()
                //            Text(message).foregroundColor(Color.white)
                //            Spacer()
                //            Divider()
                
            }
            .frame(width: UIScreen.main.bounds.width, height: geometry.size.height)
            .background(Color.black.opacity(0.5))
            .cornerRadius(12)
            .clipped()
            .gesture(
            TapGesture()
                .onEnded { _ in
                    closureA?("Close")
                    shown.toggle()
                })
            
        }.ignoresSafeArea()
    }
}
