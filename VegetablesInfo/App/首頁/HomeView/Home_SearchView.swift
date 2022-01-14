//
//  Home_SearchView.swift
//  VegetablesInfo
//
//  Created by 2008007NB01 on 2021/11/18.
//

import SwiftUI

struct Home_SearchView: View {
    @Binding var text: String
    @State private var isEditing = false
    @Binding var shownSearch: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack {
                    Button("關閉") {
                        shownSearch.toggle()
                    }.foregroundColor(Color.gray)
                    TextField("Search ...", text: $text)
                                    .padding(7)
                                    .padding(.horizontal, 25)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .padding(.horizontal, 10)
                                    .onTapGesture {
                                        self.isEditing = true
                                    }
                    Button("搜尋") {
                        
                    }.foregroundColor(Color.gray)
                }
            }
        }
    }
}

struct Home_SearchView_Previews: PreviewProvider {
    @State static var text = ""
    @State static var shownSearch = true
    static var previews: some View {
        Home_SearchView(text: $text, shownSearch: $shownSearch)
    }
}
